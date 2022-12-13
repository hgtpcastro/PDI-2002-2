unit vs.infra.modulos.ordemcarga.repositorio.xdata.ordemcarga;

interface

uses
  // TMS Aurelius
  Aurelius.Engine.ObjectManager,
  // ViaServidorIntegracao
  vs.modulos.ordemcarga.dominio.repositorio.intf,
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga;

type

  TOrdemCargaRepositorio = class(TInterfacedObject, IOrdemCargaRepositorio)
  strict private
    FObjectManager: TObjectManager;
  public
    constructor Create(const AObjectManager: TObjectManager);
    destructor Destroy; override;
    class function New(const AObjectManager: TObjectManager): IOrdemCargaRepositorio;
    function Consultar(const AIdCarga: Integer): TOrdemCarga;
  end;

implementation

uses
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargacab,
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargadoc,
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargaitem;

type

  TOrdemCargaCabHelper = class helper for TOrdemCargaCab
  public
    procedure MapearPara(const AOrdemCarga: TOrdemCarga);
  end;

  TOrdemCargaItemHelper = class helper for TOrdemCargaItem
  public
    procedure MapearPara(const AOrdemCargaItemPlanejado: TOrdemCargaItemPlanejado);
  end;

{ TOrdemCargaRepositorio }

function TOrdemCargaRepositorio.Consultar(const AIdCarga: Integer): TOrdemCarga;
var
  LOrdemCarga: TOrdemCarga;
  LOrdemCargaCab: TOrdemCargaCab;
begin
  LOrdemCargaCab := FObjectManager.Find<TOrdemCargaCab>(AIdCarga);
  LOrdemCarga := TOrdemCarga.Create;
  LOrdemCargaCab.MapearPara(LOrdemCarga);
  Result := LOrdemCarga
end;

constructor TOrdemCargaRepositorio.Create(const AObjectManager: TObjectManager);
begin
  inherited Create;
  FObjectManager := AObjectManager;
end;

destructor TOrdemCargaRepositorio.Destroy;
begin

  inherited;
end;

class function TOrdemCargaRepositorio.New(
  const AObjectManager: TObjectManager): IOrdemCargaRepositorio;
begin
  Result := Self.Create(AObjectManager);
end;

{ TOrdemCargaCabHelper }

procedure TOrdemCargaCabHelper.MapearPara(const AOrdemCarga: TOrdemCarga);
var
  LOrdemCargaDoc: TOrdemCargaDoc;
  LOrdemCargaItem: TOrdemCargaItem;
  LOrdemCargaItemPlanejado: TOrdemCargaItemPlanejado;
begin
  AOrdemCarga.IdCarga := Self.IdCarga;
  for LOrdemCargaDoc in Self.OrdemCargaDocList do
  begin
    for LOrdemCargaItem in LOrdemCargaDoc.OrdemCargaItemList do
    begin
      LOrdemCargaItemPlanejado := TOrdemCargaItemPlanejado.Create;
      LOrdemCargaItem.MapearPara(LOrdemCargaItemPlanejado);
      AOrdemCarga.ItemPlanejadoList.Add(LOrdemCargaItemPlanejado);
    end;
  end;
end;

{ TOrdemCargaItemHelper }

procedure TOrdemCargaItemHelper.MapearPara(
  const AOrdemCargaItemPlanejado: TOrdemCargaItemPlanejado);
begin
  AOrdemCargaItemPlanejado.IdItem := Self.IdItem;
  AOrdemCargaItemPlanejado.IdDocumento := Self.IdDoc;
  AOrdemCargaItemPlanejado.IdProduto := Self.Item;
  AOrdemCargaItemPlanejado.Quantidade := Self.Quantidade;
end;

end.
