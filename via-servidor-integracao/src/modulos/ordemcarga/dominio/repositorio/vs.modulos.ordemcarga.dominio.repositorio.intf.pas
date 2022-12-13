unit vs.modulos.ordemcarga.dominio.repositorio.intf;

interface

uses
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga;

type

  IOrdemCargaRepositorio = interface
    ['{95B77537-7398-4959-9086-59ACBB8FCF10}']
    function Consultar(const AIdCarga: Integer): TOrdemCarga;
  end;

implementation

end.
