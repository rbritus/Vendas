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
   const TAMANHO_NUMERO_TELEFONE = 11;
   const TAMANHO_NUMERO_CELULAR = 10;
  end;

  TConstantsMasks = class
  public
   const CPF = '000\.000\.000\-00;0;';
   const CNPJ = '00\.000\.000\/0000\-00;0;';
   const CELULAR = '(99) 99999-9999;0;';
   const TELEFONE = '(99) 9999-9999;0;';
   const CEP = '00000\-000;0;';
  end;

implementation

end.
