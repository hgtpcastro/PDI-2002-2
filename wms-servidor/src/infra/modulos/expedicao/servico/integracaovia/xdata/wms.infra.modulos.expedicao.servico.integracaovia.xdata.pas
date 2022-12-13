unit wms.infra.modulos.expedicao.servico.integracaovia.xdata;

interface

uses
  vs.modulos.carregamento.dto.requisicao.incluircarregamento,
  // WmsServico
  wms.modulos.expedicao.servico.webhook.intf,
  wms.modulos.expedicao.dominio.entidade.carga,
  wms.modulos.comum.dto.respostapadrao.wms;

type

  TIntegracaoViaServico = class(TInterfacedObject, IWebHookServico)
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IWebHookServico;
    function IncluirCarregamento(const ACarga: TCarga): TRespostaPadraoWmsDto;
  end;

implementation

uses
  // TMS Bcl
  Bcl.Json,
  // TMS Xdata
  XData.Client,
  // WmsServidor
  vs.infra.http.rotas.ordemcarga.xdata.intf,
  vs.modulos.comum.dto.respostapadrao;

{ TIntegracaoViaServico }

constructor TIntegracaoViaServico.Create;
begin

end;

destructor TIntegracaoViaServico.Destroy;
begin

  inherited;
end;

function TIntegracaoViaServico.IncluirCarregamento(
  const ACarga: TCarga): TRespostaPadraoWmsDto;
var
  LClienteRest: TXDataClient;
  LResult: TRespostaPadraoDto;
begin
  LClienteRest := TXDataClient.Create;
  try
    LClienteRest.Uri := 'http://localhost:8088/api/integracao-wms';

    LResult := LClienteRest.Service<IRotasOrdemCarga>.IncluirCarregamento(
      TJson.Deserialize<TRquisicaoIncluirCarregamentoDto>(Acarga.DadosCarga)
    );

    if LResult.executouServico then
      Result := TRespostaPadraoWmsDtoFactory.Sucesso(LResult.mensagem)
    else
      Result := TRespostaPadraoWmsDtoFactory.Falha(LResult.mensagem);
  finally
    LClienteRest.Free;
  end;
end;

class function TIntegracaoViaServico.New: IWebHookServico;
begin
  Result := Self.Create;
end;

end.
