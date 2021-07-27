unit Connection.Controller.SqLite;

interface

uses
  System.SysUtils, System.Win.Registry, Winapi.Windows, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DbxSqlite, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf,
  {Utils.Excecoes, }DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.DApt;

type
  TQuery = Class(TFDQuery);

  TConexao = class(TFDConnection)
  strict private
    DriverLink : TFDPhysSQLiteDriverLink;
    Transaction: TFDTransaction;
    class var FInstance: TConexao;
    procedure GetConexao();
  public
    class function GetInstance: TConexao;

    procedure AtulizaEstruturaDeTabelasNoBanco();
    function ObterQuery: TQuery;
    procedure EnviarComando(Comando: String);
    function EnviaConsulta(Consulta: String): TDataSet;
    function ObterProximaSequencia(NomeTabela: String): Integer;
    function TabelaExiste(NomeTabela: String): Boolean;
    function CampoExiste(NomeTabela, NomeCampo: String): Boolean;
    procedure FecharConexao();
    constructor Create(AOwner: TComponent); Override;
  end;

implementation

{ TConexaoController }

procedure TConexao.AtulizaEstruturaDeTabelasNoBanco;
begin
//   TDatabaseManager.Update(Connection);
end;

class function TConexao.GetInstance: TConexao;
begin
  if not Assigned(Self.FInstance) then
  begin
     FInstance := TConexao( Inherited NewInstance);
     FInstance.Create(nil);
     with FInstance.FormatOptions do
     begin
        OwnMapRules := True;
        with MapRules.Add do
        begin
          SourceDataType := dtMemo;
          TargetDataType := dtAnsiString;
        end;
     end;
     FInstance.GetConexao;
  end;

   if not Self.FInstance.InTransaction then
      Self.FInstance.StartTransaction;

  Result := Self.FInstance;
end;

function TConexao.CampoExiste(NomeTabela, NomeCampo: String): Boolean;
Var
   cSQL     : String;
   lResposta: Boolean;
   MyDataSet: TDataSet;
Begin
   cSQL := 'PRAGMA Table_Info('+ QuotedStr(NomeTabela) + ')';

   MyDataSet := Self.EnviaConsulta(cSQL);
   try
      MyDataSet.Filter := 'name = ' + QuotedStr(NomeCampo);
      MyDataSet.Filtered := True;
      lResposta := MyDataSet.RecordCount > 0;
   finally
      MyDataSet.Close;
      FreeAndNil(MyDataSet);
   end;

   Result := lResposta;
end;

constructor TConexao.Create(AOwner: TComponent);
begin
   Inherited;
end;

Function TConexao.ObterQuery: TQuery;
Var
   MyDataSet: TFDQuery;
Begin
   MyDataSet            := TFDQuery.Create(nil);
   MyDataSet.Connection := GetInstance;
   Result               := TQuery(MyDataSet);
End;

function TConexao.TabelaExiste(NomeTabela: String): Boolean;
var
   MyDataSet: TDataSet;
Begin
   try
       MyDataSet := Self.EnviaConsulta(
         'SELECT * FROM sqlite_master where tbl_name = ' + QuotedStr(NomeTabela));
      Result := MyDataSet.RecordCount > 0;
   finally
      MyDataSet.Close;
      FreeAndNil(MyDataSet);
   end;
end;

procedure TConexao.EnviarComando(Comando: String);
Var
   MyDataSet: TFDQuery;
Begin
   MyDataSet := ObterQuery();

   try
      MyDataSet.SQL.Add(Comando);

      Try
         MyDataSet.ExecSQL;
      Except
         On E: Exception Do
         Begin
            Self.RollbackRetaining;
//            Raise EComandoNaoExecutado.Create;
         End;
      End;
   finally
      MyDataSet.Free;
   end;
end;

procedure TConexao.FecharConexao;
begin
   FInstance.Close;
end;

Function TConexao.EnviaConsulta(Consulta: String): TDataSet;
Var
   MyDataSet: TFDQuery;
   dsp: TDataSetProvider;
Begin
   MyDataSet := ObterQuery();
   MyDataSet.SQL.Add(Consulta);
   dsp := TDataSetProvider.Create(Self.Owner);
   dsp.Name := 'dspTConexao';
   dsp.DataSet := MyDataSet;
   var cds: TClientDataSet := TClientDataSet.Create(Self.Owner);
   try
      Try
         cds.SetProvider(dsp);
         cds.Open;
//         MyDataSet.Open(Consulta);
      Except
         On E: Exception Do
         begin
            MyDataSet.Free;
//            Raise EComandoNaoExecutado.Create;
         end;
      End;
   finally
      MyDataSet.Close;
      cds.SetProvider(nil);
      cds.ProviderName := EmptyStr;
      FreeAndNil(dsp);
      FreeAndNil(MyDataSet);
   end;

   Result := cds;
End;

procedure TConexao.GetConexao();
var
   reg: TRegistry;
   Diretorio, Name: string;

   procedure CriarTransaction();
   begin
      Transaction := TFDTransaction.Create( nil );
      Transaction.Connection := FInstance;
      Transaction.Options.AutoCommit := True;
      Transaction.Options.ReadOnly := False;
      Transaction.Options.Isolation := xiReadCommitted;
   end;

begin
   Reg := TRegistry.Create();
   Diretorio := EmptyStr;
   Name := EmptyStr;
   DriverLink := TFDPhysSQLiteDriverLink.Create( nil );
   CriarTransaction();
   FInstance.Params.Values['DriverID'] := 'SQLite';
   FInstance.UpdateOptions.LockWait := False;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Produtec\', True) then
      begin
         Diretorio := Reg.ReadString('ProlojaDBLocal');
         Name := Reg.ReadString('ProlojaDBName');
      end;

      if Diretorio.Trim.IsEmpty then
      begin
         Diretorio := IncludeTrailingPathDelimiter(GetCurrentDir);
         Reg.WriteString('ProlojaDBLocal', Diretorio);
      end;

      if Name.Trim.IsEmpty then
      begin
         Name := ChangeFileExt(ExtractFileName(ParamStr(0)),EmptyStr)+'.db';
         Reg.WriteString('ProlojaDBName', Name);
      end;

      FInstance.Params.Values['Database'] := Diretorio+Name;

      (FInstance.Params as TFDPhysSQLiteConnectionDefParams).StringFormat :=
         TFDSQLiteStringFormat.sfANSI;

      FInstance.Params.Values['SharedCache'] := 'False';
      FInstance.Params.Values['Synchronous'] := 'Normal';
      FInstance.Params.Values['LockingMode'] := 'Normal';
      FInstance.Connected := True;
   finally
      Reg.Free;
   end;
end;

Function TConexao.ObterProximaSequencia(NomeTabela: String): Integer;
Var
   MyDataSet: TDataSet;
   Sequencia: integer;
Begin
   MyDataSet := EnviaConsulta('select MAX(seq) seq from sqlite_sequence where ' +
      'upper(name) = upper('+NomeTabela+')');
   Try
      Sequencia := MyDataSet.FieldByName('seq').AsInteger + 1;
      Result := Sequencia;
      MyDataSet.Close;
      EnviarComando('update sqlite_sequence SET seq = ' + Sequencia.ToString() +
         ' where upper(name) = upper('+NomeTabela+')');
   Finally
      FreeAndNil(MyDataSet);
   End;
End;

end.
