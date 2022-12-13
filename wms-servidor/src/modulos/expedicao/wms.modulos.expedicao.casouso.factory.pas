unit wms.modulos.expedicao.casouso.factory;

interface

uses
  // TMS Aurelius
  Aurelius.Engine.ObjectManager,
  // WmsServidor
  wms.modulos.comum.casouso.intf,
  wms.modulos.comum.dto.respostapadrao.wms,
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga,
  wms.modulos.expedicao.dominio.repositorio.intf;

type

  TCasoUsoFactory = class
  public
    class function IncluirCarga: ICasoUso<TRequisicaoIncluirCargaDto, TRespostaPadraoWmsDto>;
  end;

implementation

uses
  // TMS XData
  XData.Server.Module,
  // WmsServidor
  wms.infra.modulos.expedicao.repositorio.xdata.carga,
  wms.infra.modulos.expedicao.servico.integracaovia.xdata,
  wms.modulos.expedicao.casouso.incluircarga,
  wms.modulos.expedicao.servico.webhook.intf;

{ TCasoUsoFactory }

class function TCasoUsoFactory.IncluirCarga: ICasoUso<TRequisicaoIncluirCargaDto, TRespostaPadraoWmsDto>;
var
  LObjectManager: TObjectManager;
  LRepositorio: ICargaRepositorio;
  LServico: IWebHookServico;
begin
  LObjectManager := TXDataOperationContext.Current.GetManager;
  LRepositorio := TCargaRepositorio.New(LObjectManager);
  LServico := TIntegracaoViaServico.New;
  Result := TIncluirCargaCasoUso.New(LRepositorio, LServico);
end;

end.

