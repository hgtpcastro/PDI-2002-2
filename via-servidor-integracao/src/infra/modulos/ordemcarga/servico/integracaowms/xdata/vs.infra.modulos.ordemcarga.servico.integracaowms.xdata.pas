unit vs.infra.modulos.ordemcarga.servico.integracaowms.xdata;

interface

uses
  // ViaServidorIntegracao
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga,
  vs.modulos.ordemcarga.servico.integracaowms.intf,
  // WmsServidor
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga;

type

  TIntegracaoWmsServico = class(TInterfacedObject, IIntegracaoWmsServico)
  strict private
    function RetornarIncluirCargaDto(const AOrdemCarga: TOrdemCarga): TRequisicaoIncluirCargaDto;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IIntegracaoWmsServico;
    function IncluirCarga(const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
  end;

implementation

uses
  // TMS Xdata
  XData.Client,
  // WmsServidor
  wms.infra.http.rotas.expedicao.xdata.intf,
  wms.modulos.comum.dto.respostapadrao.wms;

type

  TOrdemCargaHelper = class helper for TOrdemCarga
  public
    procedure MapearParaDto(const ADto: TRequisicaoIncluirCargaDto);
  end;

  TOrdemCargaItemPlanejadoHelper = class helper for TOrdemCargaItemPlanejado
  public
    procedure MapearParaDto(const ADto: TItemDto);
  end;

{ TIncluirOrdemCargaWmsServico }

constructor TIntegracaoWmsServico.Create;
begin

end;

destructor TIntegracaoWmsServico.Destroy;
begin

  inherited;
end;

function TIntegracaoWmsServico.IncluirCarga(
  const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
var
  LClienteRest: TXDataClient;
  LResult: TRespostaPadraoWmsDto;
begin
  LClienteRest := TXDataClient.Create;
  try
    LClienteRest.Uri := 'http://localhost:8089/api/wms-server';

    LResult := LClienteRest.Service<IRotasExpedicao>.IncluirCarga(
      Self.RetornarIncluirCargaDto(AOrdemCarga)
    );

    if LResult.codigo = 1 then
      Result := TRespostaPadraoDtoFactory.Sucesso(LResult.msg)
    else
      Result := TRespostaPadraoDtoFactory.Falha(LResult.msg);
  finally
    LClienteRest.Free;
  end;
end;

class function TIntegracaoWmsServico.New: IIntegracaoWmsServico;
begin
  Result := Self.Create;
end;

function TIntegracaoWmsServico.RetornarIncluirCargaDto(
  const AOrdemCarga: TOrdemCarga): TRequisicaoIncluirCargaDto;
begin
  Result := TRequisicaoIncluirCargaDto.Create;
  AOrdemCarga.MapearParaDto(Result);
end;

{ TOrdemCargaHelper }

procedure TOrdemCargaHelper.MapearParaDto(
  const ADto: TRequisicaoIncluirCargaDto);
var
  LItemPlanejado: TOrdemCargaItemPlanejado;
  LItemDto: TItemDto;
begin
  ADto.idCarga := Self.IdCarga;
  for LItemPlanejado in Self.ItemPlanejadoList do
  begin
    LItemDto := TItemDto.Create;
    LItemPlanejado.MapearParaDto(LItemDto);
    ADto.listaItens.Add(LItemDto);
  end;
end;

{ TOrdemCargaItemPlanejadoHelper }

procedure TOrdemCargaItemPlanejadoHelper.MapearParaDto(const ADto: TItemDto);
begin
  ADto.idItem := Self.IdItem;
  ADto.idDocumento := Self.IdDocumento;
  ADto.idProduto := Self.IdProduto;
  ADto.quantidade := Self.Quantidade;
end;

end.
