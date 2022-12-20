unit vs.modulos.carregamento.casouso.incluircarregamento;

interface

uses
  // TMS Aurelius
  Aurelius.Engine.ObjectManager,
  // ViaServidorIntegracao
  vs.modulos.comum.casouso.intf,
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.carregamento.dto.requisicao.incluircarregamento,
  vs.modulos.carregamento.repositorio.ordemcargacarreg.intf;

type

  TIncluirCarregamentoCasoUso = class(
    TInterfacedObject,
    ICasoUso<TRquisicaoIncluirCarregamentoDto, TRespostaPadraoDto>)
  strict private
    FObjectManager: TObjectManager;
    FRepositorio: IOrdemCargaCarregRepositorio;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ICasoUso<TRquisicaoIncluirCarregamentoDto, TRespostaPadraoDto>;
    function Executar(const ARequisicao: TRquisicaoIncluirCarregamentoDto): TRespostaPadraoDto;
  end;

implementation

uses
  System.SysUtils,
  // TMS Logger
  Vcl.TMSLogging,
  // TMS Aurelius
  Aurelius.Drivers.Interfaces,
  // TMS XData
  XData.Server.Module,
  // ViaServidorIntegracao
  vs.modulos.carregamento.modelo.ordemcargacarreg,
  vs.modulos.carregamento.repositorio.ordemcargacarreg;

type

  TTItemDtoHelper = class helper for TItemDto
  public
    procedure MapearparaModelo(const AOrdemCargaCarreg: TOrdemCargaCarreg);
  end;

{ TIncluirCarregamentoServico }

constructor TIncluirCarregamentoCasoUso.Create;
begin
  inherited Create;
  FObjectManager := TXDataOperationContext.Current.GetManager;
  FRepositorio := TOrdemCargaCarregRepositorio.New;
end;

destructor TIncluirCarregamentoCasoUso.Destroy;
begin

  inherited;
end;

function TIncluirCarregamentocasoUso.Executar(
  const ARequisicao: TRquisicaoIncluirCarregamentoDto): TRespostaPadraoDto;
var
  LItemDto: TItemDto;
  LOrdemCargaCarreg: TOrdemCargaCarreg;
  LTransacao: IDBTransaction;
begin
  TMSLogger.Info(Format('Recebendo dados da Ordem Carga(%d), do WMS via WebHook.',[ARequisicao.idCarga]));
  Sleep(3000);
  LTransacao := FObjectManager.Connection.BeginTransaction;
  try
    for LItemDto in ARequisicao.listaItens do
    begin
      LOrdemCargaCarreg := TOrdemCargaCarreg.Create;
      LItemDto.MapearparaModelo(LOrdemCargaCarreg);
      FRepositorio.Incluir(LOrdemCargaCarreg);
    end;
    LTransacao.Commit;

    TMSLogger.Info('Carregamento finalizado.');
    Result := TRespostaPadraoDtoFactory.Sucesso('Processado com sucesso!');
  except
    on E: Exception do
    begin
      Result := TRespostaPadraoDtoFactory.Falha(e.Message);
      LTransacao.Rollback;
      raise;
    end;
  end;
end;

{ TRquisicaoIncluirCarregamentoDtoHelper }

procedure TTItemDtoHelper.MapearparaModelo(
  const AOrdemCargaCarreg: TOrdemCargaCarreg);
begin
  AOrdemCargaCarreg.IdItem := Self.idItem;
  AOrdemCargaCarreg.Carregada := Self.quantidade;
end;

class function TIncluirCarregamentoCasoUso.New: ICasoUso<TRquisicaoIncluirCarregamentoDto, TRespostaPadraoDto>;
begin
  Result := Self.Create;
end;

end.
