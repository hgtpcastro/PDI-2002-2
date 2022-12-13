unit wms.infra.modulos.expedicao.modelo.aurelius.carga;

interface

uses
  // TMS Aurelius
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob;

type

  [Entity]
  [Table('CARGA')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  [Sequence('GEN_CARGA_ID')]
  TCargaModelo = class
  private
    [Column('ID', [TColumnProp.Required])]
    FId: Integer;

    [Column('ID_CARGA', [])]
    FIdCarga: Integer;

    [Column('CARGA_FINALIZADA', [], 1)]
    FCargaFinalizada: string;

    [Column('DADOS_CARGA', [])]
    [DBTypeMemo]
    FDadosCarga: TBlob;
  public
    property Id: Integer read FId write FId;
    property IdCarga: Integer read FIdCarga write FIdCarga;
    property CargaFinalizada: string read FCargaFinalizada write FCargaFinalizada;
    property DadosCarga: TBlob read FDadosCarga write FDadosCarga;
  end;

implementation

initialization
  RegisterEntity(TCargaModelo);

end.
