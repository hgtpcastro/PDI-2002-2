unit vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargaitem;

interface

uses
  // TMS Aurelius
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable;

type

  [Entity]
  [Table('ORDEMCARGAITEM')]
  [Id('FIdItem', TIdGenerator.None)]
  TOrdemCargaItem = class
  private
    [Column('IDITEM', [TColumnProp.Required])]
    FIdItem: Integer;

    [Column('IDDOC', [TColumnProp.Required])]
    FIdDoc: Integer;

    [Column('ITEM', [TColumnProp.Required])]
    FItem: Integer;

    [Column('QUANTIDADE', [])]
    FQuantidade: Extended;
  public
    property IdItem: Integer read FIdItem write FIdItem;
    property IdDoc: Integer read FIdDoc write FIdDoc;
    property Item: Integer read FItem write FITem;
    property Quantidade: Extended read FQuantidade write FQuantidade;
  end;

implementation

initialization
  RegisterEntity(TOrdemCargaItem);

end.
