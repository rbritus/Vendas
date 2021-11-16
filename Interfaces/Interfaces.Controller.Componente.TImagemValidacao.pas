unit Interfaces.Controller.Componente.TImagemValidacao;

interface

uses
  Vcl.Forms, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Componente.TImagemValidacao;

type

  iControllerTImagemValidacao = interface
    ['{A7FEB956-9156-4DBA-83B9-DD89A1585E5A}']
    function CriarImagemDeValidacao(AComponente: TWinControl; Mensagem: string): TImagemValidacao;
    procedure DestruirTImagemValidacaoDoForm;
  end;

implementation

end.
