unit vs.modulos.carregamento.repositorio.ordemcargacarreg;

interface

uses
  // TMS Aurelius
  Aurelius.Engine.ObjectManager,
  // ViaServidorIntegracao
  vs.modulos.carregamento.modelo.ordemcargacarreg,
  vs.modulos.carregamento.repositorio.ordemcargacarreg.intf;

type

  TOrdemCargaCarregRepositorio = class (
    TInterfacedObject
    , IOrdemCargaCarregRepositorio)
  strict private
    FObjectManager: TObjectManager;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IOrdemCargaCarregRepositorio;
    function Incluir(const AOrdemCargaCarreg: TOrdemCargaCarreg): TOrdemCargaCarreg;
  end;

implementation

uses
  // TMS XData
  XData.Server.Module;

{ TOrdemCargaCarregRepositorio }

constructor TOrdemCargaCarregRepositorio.Create;
begin
  inherited Create;
  FObjectManager := TXDataOperationContext.Current.GetManager;
end;

destructor TOrdemCargaCarregRepositorio.Destroy;
begin

  inherited;
end;

function TOrdemCargaCarregRepositorio.Incluir(
  const AOrdemCargaCarreg: TOrdemCargaCarreg): TOrdemCargaCarreg;
begin
  FObjectManager.Save(AOrdemCargaCarreg);
  Result := AOrdemCargaCarreg;
end;

class function TOrdemCargaCarregRepositorio.New: IOrdemCargaCarregRepositorio;
begin
  Result := Self.Create;
end;

end.
