unit vs.infra.http.rotas.ordemcarga.xdata.intf;

interface

uses
  System.Classes,
  System.Generics.Collections,
  // TMS XData
  XData.Service.Common,
  // ViaServidorIntegracao
  vs.modulos.carregamento.dto.requisicao.incluircarregamento,
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga;

type

  [ServiceContract]
  [URIPath('ordemcarga')]
  IRotasOrdemCarga = interface(IInvokable)
    ['{4D7FA0C0-590A-4A34-82D7-5A61EF869C1D}']

    [HttpPost]
    [URIPath('sincronizar')]
    function Sincronizar(const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;

    [HttpPost]
    [URIPath('incluircarregamento')]
    function IncluirCarregamento(const ARequisicao: TRquisicaoIncluirCarregamentoDto): TRespostaPadraoDto;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IRotasOrdemCarga));

end.
