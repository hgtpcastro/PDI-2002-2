unit vs.modulos.carregamento.modelo.ordemcargacarreg;

interface

uses
  // TMS Aurelius
  Aurelius.Mapping.Attributes;

type

  [Entity]
  [Table('ORDEMCARGACARREG')]
  [Id('FIdCarreg', TIdGenerator.IdentityOrSequence)]
  [Sequence('GEN_ORDEMCARGACARREG_IDCARREG')]
  TOrdemCargaCarreg = class
  private
    [Column('IDCARREG', [TColumnProp.Required])]
    FIdCarreg: Integer;

    [Column('IDITEM', [])]
    FIdItem: Integer;

    [Column('CARREGADA', [] )]
    FCarregada: Extended;
  public
    property IdCarreg: Integer read FIdCarreg write FIdCarreg;
    property IdItem: Integer read FIdItem write FIdItem;
    property Carregada: Extended read FCarregada write FCarregada;
  end;

implementation

initialization
  RegisterEntity(TOrdemCargaCarreg);

end.
