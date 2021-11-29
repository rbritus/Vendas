unit Interfaces.Controller.Frame.FiltroGride;

interface

uses
   System.Classes, vcl.DBGrids;

type

  iControllerFrameFiltroGride = interface
    ['{EDA04D81-3825-43DC-A674-CFA19900259C}']
    procedure CriarPanelFiltro(Filtro: string);
    procedure InformarDbGrid(ADbGrid: TDbGrid);
    procedure Filtrar(Filtro: string);
    procedure LimparPesquisa;
  end;

implementation

end.
