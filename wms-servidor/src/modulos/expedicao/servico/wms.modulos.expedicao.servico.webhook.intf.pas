unit wms.modulos.expedicao.servico.webhook.intf;

interface

uses
  // WmsServidor
  wms.modulos.comum.dto.respostapadrao.wms,
  wms.modulos.expedicao.dominio.entidade.carga;

type

  IWebHookServico = interface
    ['{E10E7EEB-C928-4AF1-BE71-B8D4ED1B238A}']
    function IncluirCarregamento(const ACarga: TCarga): TRespostaPadraoWmsDto;
  end;

implementation

end.
