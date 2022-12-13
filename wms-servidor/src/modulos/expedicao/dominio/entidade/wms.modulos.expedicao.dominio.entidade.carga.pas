unit wms.modulos.expedicao.dominio.entidade.carga;

interface

type

  TCarga = class
  private
    FId: Integer;
    FIdCarga: Integer;
    FDadosCarga: string;
    FCargaFinalizada: Boolean;
  public
    property Id: Integer read FId write FId;
    property IdCarga: Integer read FIdCarga write FIdCarga;
    property DadosCarga: string read FDadosCarga write FDadosCarga;
    property CargaFinalizada: Boolean read FCargaFinalizada write FCargaFinalizada;
  end;

implementation

end.
