unit vs.infra.modulos.ordemcarga.modelo.aurelius.confordemcarga;

interface

uses
  Aurelius.Mapping.Attributes;

type

  [Entity]
  [Table('CONFORDEMCARGA')]
  [Id('FId', TIdGenerator.None)]
  TConfOrdemCarga = class
  private
    [Column('ID', [TColumnProp.Required])]
    FId: Integer;

    [Column('DESCRICAO', [])]
    FDescricao: string;

    [Column('INTEGRA_WMS', [])]
    FIntegraWMS: Integer;
  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write FDescricao;
    property IntegraWMS: Integer read FIntegraWMS write FIntegraWMS;
  end;

implementation

initialization
  RegisterEntity(TConfOrdemCarga);

end.

