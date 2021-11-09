unit Utils.Constants;

interface

uses
  Classes;

type
  TConstantsString = class
  public
   const REGISTROATIVO = 'S';
   const REGISTROINATIVO = 'N';
   const CHAR_RESULT = #0;
  end;

  TConstantsInteger = class
  public
   const MENOS_UM = -1;
   const ZERO = 0;
   const LARGURA_MENU_MAXIMIZADO = 200;
   const LARGURA_MENU_MINIMIZADO = 58;
  end;

  TConstantsMasks = class
  public
   const CPF = '000.000.000-00';
   const CNPJ = '00.000.000/0000-00;0';
   const CELULAR = '(00)00000-0000';
   const TELEFONE = '(00)0000-0000';
   const CEP = '00000-000';
  end;

implementation

end.
