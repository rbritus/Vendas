unit Utils.Constants;

interface

uses
  Classes;

type
  TConstantsString = class
  public
   const REGISTROATIVO = 'S';
   const REGISTROINATIVO = 'N';
   const CHAR_RESULT_VAZIO = #0;
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
   const CPF = '999\.999\.999\-99;0;';
   const CNPJ = '99\.999\.999\/9999\-99;0;';
   const CELULAR = '(99) 99999-9999;0;';
   const TELEFONE = '(99) 9999-9999;0;';
   const CEP = '99999\-999;0;';
  end;

  TConstantsDataHora = class
  public
   const DATAHORA_VAZIA = 0;
  end;

  TConstantsEntidade = class
  public
   const TAMANHO_GUID = 100;
   const TAMANHO_CPF = 11;
   const TAMANHO_EMAIL = 200;
   const TAMANHO_NOME = 200;
   const TAMANHO_CEP = 10;
   const TAMANHO_COMPLEMENTO = 200;
   const TAMANHO_CODIGO_PRODUTO = 100;
   const TAMANHO_ABREVIACAO = 20;
   const TAMANHO_EXTENSAO = 10;
  end;

implementation

end.
