unit vs.modulos.ordemcarga.dominio.entidade.ordemcarga;

interface

uses
  System.Generics.Collections;

type

  TOrdemCargaItemPlanejado = class;

  TOrdemCarga = class
  private
    FIdCarga: Integer;
    FItemList: TObjectList<TOrdemCargaItemPlanejado>;
  public
    constructor Create;
    destructor Destroy; override;
    property IdCarga: Integer read FIdCarga write FIdCarga;
    property ItemPlanejadoList: TObjectList<TOrdemCargaItemPlanejado> read FItemList write FItemList;
  end;

  TOrdemCargaItemPlanejado = class
  private
    FIdItem: Integer;
    FIdDocumento: Integer;
    FIdProduto: Integer;
    FQuantidade: Extended;
  public
    property IdItem: Integer read FIdItem write FIdItem;
    property IdDocumento: Integer read FIdDocumento write FIdDocumento;
    property IdProduto: Integer read FIdProduto write FIdProduto;
    property Quantidade: Extended read FQuantidade write FQuantidade;
  end;

implementation

{ TOrdemCarga }

constructor TOrdemCarga.Create;
begin
  inherited Create;
  FItemList := TObjectList<TOrdemCargaItemPlanejado>.Create(True);
end;

destructor TOrdemCarga.Destroy;
begin
  FItemList.Free;
  inherited;
end;

end.
