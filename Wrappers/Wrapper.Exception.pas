unit Wrapper.Exception;

interface

uses
  SysUtils, Forms, System.Classes, dbxcommon, Data.DB;

type
  TWrapperException = class
    public
      constructor Create;
      procedure TrataException(Sender: TObject; E : Exception);
  end;

  TExceptionGenerica = class
      class procedure MensagemExcecao(Sender: TObject; E : Exception);
  end;

  TExceptionAccessViolation = class
      class procedure MensagemExcecao(Sender: TObject; E : EAccessViolation);
  end;

  TExceptionConvercaoDeTipos = class
      class procedure MensagemExcecao(Sender: TObject; E : EConvertError);
  end;

  TExceptionDBX = class
      class procedure MensagemExcecao(Sender: TObject; E : TDBxError);
  end;

  TExceptionDataBase = class
      class procedure MensagemExcecao(Sender: TObject; E : EDatabaseError);
  end;

var
  MinhaException : TWrapperException;

implementation

uses
  Vcl.Dialogs, Utils.Menssages;

{ TException }

constructor TWrapperException.Create;
begin
  Application.OnException := TrataException;
end;

procedure TWrapperException.TrataException(Sender: TObject; E : Exception);
begin
  if E.ClassType = EAccessViolation then
  begin
    TExceptionAccessViolation.MensagemExcecao(Sender,E as EAccessViolation);
    Exit;
  end;

  if E.ClassType = EConvertError then
  begin
    TExceptionConvercaoDeTipos.MensagemExcecao(Sender,E as EConvertError);
    Exit;
  end;

  if E.ClassType = TDBxError then
  begin
    TExceptionDBX.MensagemExcecao(Sender,E as TDBxError);
    Exit;
  end;

  if E.ClassType = EDatabaseError then
  begin
    TExceptionDataBase.MensagemExcecao(Sender,E as EDatabaseError);
    Exit;
  end;

  TExceptionGenerica.MensagemExcecao(Sender,E);
end;

{ TException }

class procedure TExceptionGenerica.MensagemExcecao(Sender: TObject; E: Exception);
begin
  var Mensagem := 'Exceção genérica:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMenssages.ShowExceptionDialog(Mensagem);
end;

{ TExceptionAccessViolation }

class procedure TExceptionAccessViolation.MensagemExcecao(Sender: TObject; E: EAccessViolation);
begin
  var Mensagem := 'Acesso inválido à memória:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMenssages.ShowExceptionDialog(Mensagem);
end;

{ TExceptionConvercaoDeTipos }

class procedure TExceptionConvercaoDeTipos.MensagemExcecao(Sender: TObject; E: EConvertError);
begin
  var Mensagem := 'Erro de conversão de tipos:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMenssages.ShowExceptionDialog(Mensagem);
end;

{ TExceptionBancoDeDados }

class procedure TExceptionDBX.MensagemExcecao(Sender: TObject; E: TDBxError);
begin
  var Mensagem := string.Empty;
  case E.ErrorCode of
    TDBXErrorCodes.Warning: Mensagem := 'Warning banco de dados:';
  else
    Mensagem := 'Erro banco de dados:'
  end;
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMenssages.ShowExceptionDialog(Mensagem);
end;

{ TExceptionDataBase }

class procedure TExceptionDataBase.MensagemExcecao(Sender: TObject; E: EDatabaseError);
begin
  var Mensagem := 'Erro banco de dados:';
  Mensagem := Mensagem + SLineBreak + E.ClassName + SLineBreak + 'Erro: ' + E.Message;
  TUtilsMenssages.ShowExceptionDialog(Mensagem);
end;

initialization
  MinhaException := TWrapperException.Create;

finalization
  MinhaException.Free;

end.
