unit wms.modulos.expedicao.dominio.repositorio.intf;

interface

uses
  System.Generics.Collections,
  // WmsServidor
  wms.modulos.expedicao.dominio.entidade.carga;

type

  ICargaRepositorio = interface
    ['{B46C7811-476F-41EB-BFCE-C70663496107}']
    function Incluir(const ACarga: TCarga): TCarga;
    function Alterar(const ACarga: TCarga): TCarga;
    function ConsultarCargaNaoFinalizada: TList<TCarga>;
    function ConsultarCargaFinalizada: TList<TCarga>;
  end;

implementation

end.
