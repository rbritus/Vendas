unit Connection.Controller.SqLite;

interface

uses
  System.SysUtils, System.Win.Registry, Winapi.Windows, System.Classes,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, Data.DbxSqlite, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Intf,
  DB, Datasnap.DBClient, Datasnap.Provider, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove;

type
  TQuery = Class(TFDQuery)
  public
    procedure ExecScript;
  end;

  TConexao = class(TFDConnection)
  strict private
    FDriverLink : TFDPhysSQLiteDriverLink;
    FTransaction: TFDTransaction;
    class var FInstance: TConexao;
    procedure GetConexao;
  public
    class function GetInstance: TConexao;

    procedure AtulizaEstruturaDeTabelasNoBanco;
    function ObterQuery: TQuery;
    procedure EnviarComando(Comando: String);
    function EnviaConsulta(Consulta: String): TDataSet;
    function ObterProximaSequencia(NomeTabela: String): Integer;
    function TabelaExiste(NomeTabela: String): Boolean;
    function CampoExiste(NomeTabela, NomeCampo: String): Boolean;
    procedure FecharConexao;
    constructor Create(AOwner: TComponent); Override;

    const SELECT_RECUPERACAO_ID = 'SELECT last_insert_rowid() result_id;';
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

//   if not Self.FInstance.InTransaction then
//      Self.FInstance.StartTransaction;

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
Begin
  var MyDataSet := TFDQuery.Create(nil);
  MyDataSet.Connection := GetInstance;
  Result := TQuery(MyDataSet);
End;

function TConexao.TabelaExiste(NomeTabela: String): Boolean;
begin
  var MyDataSet := Self.EnviaConsulta('SELECT * FROM sqlite_master where tbl_name = ' + QuotedStr(NomeTabela));
  try
    Result := MyDataSet.RecordCount > 0;
    MyDataSet.Close;
  finally
    FreeAndNil(MyDataSet);
  end;
end;

procedure TConexao.EnviarComando(Comando: String);
Begin
  var MyDataSet := ObterQuery;
  try
    MyDataSet.SQL.Add(Comando);
    try
      MyDataSet.ExecSQL;
    except
      on E: Exception do
      begin
        Self.RollbackRetaining;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    MyDataSet.Free;
  end;
end;

procedure TConexao.FecharConexao;
begin
  FInstance.Close;
  FDriverLink.Free;
  FTransaction.Free;
  FInstance.Free;
end;

Function TConexao.EnviaConsulta(Consulta: String): TDataSet;
Begin
  var MyDataSet := ObterQuery;
  var cds := TFDMemTable.Create(Self.Owner);
  try
    MyDataSet.Open(Consulta);
    cds.CopyDataSet(MyDataSet.Fields.DataSet, [coStructure, coRestart, coAppend]);
  finally
    FreeAndNil(MyDataSet);
  end;
  Result := cds;
End;

procedure TConexao.GetConexao;
var
   reg: TRegistry;
   Diretorio, Name: string;

   procedure CriarTransaction;
   begin
      FTransaction := TFDTransaction.Create( nil );
      FTransaction.Connection := FInstance;
   end;

begin
   Reg := TRegistry.Create;
   Diretorio := EmptyStr;
   Name := EmptyStr;
   FDriverLink := TFDPhysSQLiteDriverLink.Create( nil );
   CriarTransaction;
   FInstance.Params.Values['DriverID'] := 'SQLite';
   FInstance.UpdateOptions.LockWait := False;
   try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Vendas\', True) then
      begin
         Diretorio := Reg.ReadString('DBLocal');
         Name := Reg.ReadString('DBName');
      end;

      if Diretorio.Trim.IsEmpty then
      begin
         Diretorio := IncludeTrailingPathDelimiter(GetCurrentDir);
         Reg.WriteString('DBLocal', Diretorio);
      end;

      if Name.Trim.IsEmpty then
      begin
         Name := ChangeFileExt(ExtractFileName(ParamStr(0)),EmptyStr)+'.db';
         Reg.WriteString('DBName', Name);
      end;

      FInstance.Params.Values['Database'] := Diretorio+Name;

      (FInstance.Params as TFDPhysSQLiteConnectionDefParams).StringFormat :=
         TFDSQLiteStringFormat.sfANSI;

      FInstance.Params.Values['SharedCache'] := 'False';
      FInstance.Params.Values['Synchronous'] := 'Normal';
      FInstance.Params.Values['LockingMode'] := 'Normal';

      FInstance.TxOptions.AutoCommit := True;
      FInstance.TxOptions.AutoStart := True;
      FInstance.TxOptions.EnableNested := False;
      FInstance.TxOptions.AutoStop := False;
      FInstance.TxOptions.ReadOnly := False;
      FInstance.TxOptions.Isolation := xiReadCommitted;
      FInstance.TxOptions.StopOptions := [xoIfAutoStarted,xoIfCmdsInactive];

      FInstance.Connected := True;
   finally
      Reg.Free;
   end;
end;

Function TConexao.ObterProximaSequencia(NomeTabela: String): Integer;
Begin
   var MyDataSet := EnviaConsulta('select MAX(seq) seq from sqlite_sequence where ' +
      'upper(name) = upper('+NomeTabela+')');
   Try
      var Sequencia := MyDataSet.FieldByName('seq').AsInteger + 1;
      Result := Sequencia;
      MyDataSet.Close;
      EnviarComando('update sqlite_sequence SET seq = ' + Sequencia.ToString +
         ' where upper(name) = upper('+NomeTabela+')');
   Finally
      FreeAndNil(MyDataSet);
   End;
End;

{ TQuery }

procedure TQuery.ExecScript;
begin
  case Self.Command.CommandKind of
    skInsert, skUpdate, skDelete,
    skCreate, skDrop, skAlter: Self.ExecSQL;

    skSelect: Self.Open;
  else
    Self.OpenOrExecute;
  end;
end;

end.
