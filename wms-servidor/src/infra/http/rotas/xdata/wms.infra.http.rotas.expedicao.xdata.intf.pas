unit wms.infra.http.rotas.expedicao.xdata.intf;

interface

uses
  System.Classes,
  System.Generics.Collections,
  // TMS XData
  XData.Service.Common,
  // WmsServidor
  wms.modulos.comum.dto.respostapadrao.wms,
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga;

type

  [ServiceContract]
  [URIPath('expedicao')]
  IRotasExpedicao = interface(IInvokable)
    ['{69781235-6D15-47D5-BF44-26AF9943F27B}']

    [HttpPost]
    [URIPath('incluircarga')]
    function IncluirCarga(const ARequisicao: TRequisicaoIncluirCargaDto): TRespostaPadraoWmsDto;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IRotasExpedicao));

end.
