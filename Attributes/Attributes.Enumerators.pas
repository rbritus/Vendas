unit Attributes.Enumerators;

interface

Uses
   System.SysUtils, System.Classes;

type
  TEnumAttribute = class(TCustomAttribute)
  private
    FIndice: Integer;
    FCaption: string;
    FValue: Variant;
  public
    property Indice: Integer read FIndice write FIndice;
    property Caption: string read FCaption write FCaption;
    property Value: Variant read FValue write FValue;

    constructor Create(pIndice: Integer; pCaption: string; pValue: Integer); overload;
    constructor Create(pIndice: Integer; pCaption: string; pValue: string); overload;
  end;

implementation

{ TEnumAttribute }

constructor TEnumAttribute.Create(pIndice: Integer; pCaption: string; pValue: Integer);
begin
  FIndice := pIndice;
  FCaption := pCaption;
  FValue := pValue;
end;

constructor TEnumAttribute.Create(pIndice: Integer; pCaption, pValue: string);
begin
  FIndice := pIndice;
  FCaption := pCaption;
  FValue := pValue;
end;

end.
