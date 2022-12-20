unit vs.modulos.ordemcarga.servico.integracaowms.intf;

interface

uses
  // ViaServidorIntegracao
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga;

type

  IIntegracaoWmsServico = interface
    ['{C8BA6541-5234-4DAC-836D-F72F2833B097}']
    function IncluirCarga(const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
  end;

implementation

end.
