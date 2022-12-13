unit vs.modulos.carregamento.repositorio.ordemcargacarreg.intf;

interface

uses
  // ViaServidorIntegracao
  vs.modulos.carregamento.modelo.ordemcargacarreg;

type

  IOrdemCargaCarregRepositorio = interface
    ['{4A9F92F8-D74E-4CDA-9FAB-3C3A3FB4B148}']
    function Incluir(const AOrdemCargaCarreg: TOrdemCargaCarreg): TOrdemCargaCarreg;
  end;

implementation

end.
