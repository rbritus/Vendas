unit Interfaces.Services.ListaCadastro;

interface

uses
   System.Classes, Data.DB;

type

  iServicesListaCadastro = interface
    ['{3D68EA68-87DF-4B77-A0FF-DC3C84E49B8A}']
    function GetSqlListaCadastro: string;
    function GetDataSetListaCadastro: TDataSet;
  end;

implementation

end.
