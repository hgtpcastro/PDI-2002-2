unit wms.infra.modulos.expedicao.repositorio.xdata.carga;

interface

uses
  System.Generics.Collections,
  // TMS Aurelius
  Aurelius.Engine.ObjectManager,
  // WmsServidor
  wms.modulos.expedicao.dominio.repositorio.intf,
  wms.modulos.expedicao.dominio.entidade.carga;

type

  TCargaRepositorio = class(TInterfacedObject, ICargaRepositorio)
  strict private
    FObjectManager: TObjectManager;
  public
    constructor Create(const AObjectManager: TObjectManager);
    destructor Destroy; override;
    class function New(const AObjectManager: TObjectManager): ICargaRepositorio;
    function Incluir(const ACarga: TCarga): TCarga;
    function Alterar(const ACarga: TCarga): TCarga;
    function ConsultarCargaNaoFinalizada: TList<TCarga>;
    function ConsultarCargaFinalizada: TList<TCarga>;
  end;

implementation

uses
  // TMS Aurelius
  Aurelius.Criteria.Linq,
  // WmsServidor
  wms.infra.modulos.expedicao.modelo.aurelius.carga;

type

  TCargaHelper = class helper for TCarga
  public
    procedure MapearParaModelo(const ACargaModelo: TCargaModelo);
  end;

  TCargaModeloHelper = class helper for TCargaModelo
  public
    procedure MapearParaEntidade(const ACarga: TCarga);
  end;

{ TCargaRepositorio }

function TCargaRepositorio.Alterar(const ACarga: TCarga): TCarga;
var
  LCargaModelo: TCargaModelo;
  LCargaModeloMerge: TCargaModelo;
begin
  LCargaModelo := TCargaModelo.Create;
  try
    ACarga.MapearParaModelo(LCargaModelo);

    if FObjectManager.IsAttached(LCargaModelo) then
    begin
      FObjectManager.Flush(LCargaModelo);

      Result := TCarga.Create;
      LCargaModeloMerge.MapearParaEntidade(Result);
    end
    else
    begin
      LCargaModeloMerge := FObjectManager.Merge<TCargaModelo>(LCargaModelo);
      FObjectManager.Flush(LCargaModeloMerge);

      Result := TCarga.Create;
      LCargaModeloMerge.MapearParaEntidade(Result);
    end;
  finally
    LCargaModelo.Free;
  end;
end;

function TCargaRepositorio.ConsultarCargaFinalizada: TList<TCarga>;
var
  LCarga: TCarga;
  LCargaModelo: TCargaModelo;
  LCargaModeloList: TList<TCargaModelo>;
begin
  Result := TObjectList<TCarga>.Create(True);

  LCargaModeloList := FObjectManager.Find<TCargaModelo>.Where(
    (Linq['CARGAFINALIZADA'] = 'S')
  ).List;

  try
    for LCargaModelo in LCargaModeloList do
    begin
      LCarga := TCarga.Create;
      LCargaModelo.MapearParaEntidade(LCarga);
      Result.Add(LCarga)
    end;
  finally
    LCargaModeloList.Free;
  end;
end;

function TCargaRepositorio.ConsultarCargaNaoFinalizada: TList<TCarga>;
var
  LCarga: TCarga;
  LCargaModelo: TCargaModelo;
  LCargaModeloList: TList<TCargaModelo>;
begin
  Result := TObjectList<TCarga>.Create(True);

  LCargaModeloList := FObjectManager.Find<TCargaModelo>.Where(
    (Linq['CARGAFINALIZADA'] = 'N')
  ).List;

  try
    for LCargaModelo in LCargaModeloList do
    begin
      LCarga := TCarga.Create;
      LCargaModelo.MapearParaEntidade(LCarga);
      Result.Add(LCarga)
    end;
  finally
    LCargaModeloList.Free;
  end;
end;

constructor TCargaRepositorio.Create(const AObjectManager: TObjectManager);
begin
  inherited Create;
  FObjectManager := AObjectManager;
end;

destructor TCargaRepositorio.Destroy;
begin

  inherited;
end;

function TCargaRepositorio.Incluir(const ACarga: TCarga): TCarga;
var
  LCargaModelo: TCargaModelo;
begin
  LCargaModelo := TCargaModelo.Create;
  ACarga.MapearParaModelo(LCargaModelo);

  FObjectManager.Save(LCargaModelo);
  LCargaModelo.MapearParaEntidade(ACarga);
  Result := ACarga;
end;

class function TCargaRepositorio.New(
  const AObjectManager: TObjectManager): ICargaRepositorio;
begin
  Result := Self.Create(AObjectManager);
end;

{ TCargaHelper }

procedure TCargaHelper.MapearParaModelo(const ACargaModelo: TCargaModelo);
begin
  ACargaModelo.Id := Self.Id;
  ACargaModelo.IdCarga := Self.IdCarga;
  ACargaModelo.DadosCarga.AsUnicodeString := Self.DadosCarga;
  if Self.CargaFinalizada then
    ACargaModelo.CargaFinalizada := 'S'
  else
    ACargaModelo.CargaFinalizada := 'N';
end;

{ TCargaModeloHelper }

procedure TCargaModeloHelper.MapearParaEntidade(const ACarga: TCarga);
begin
  ACarga.Id := Self.Id;
  ACarga.IdCarga := Self.IdCarga;
  ACarga.DadosCarga := Self.DadosCarga.AsUnicodeString;
  if Self.CargaFinalizada = 'S' then
    ACarga.CargaFinalizada := True
  else
    ACarga.CargaFinalizada := False;
end;

end.
