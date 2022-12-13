unit vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargadoc;

interface

uses
  System.Generics.Collections,
  // TMS Aurelius
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  // ViaServidorIntegracao
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargaitem;

type

  [Entity]
  [Table('ORDEMCARGADOC')]
  [Id('FIdDoc', TIdGenerator.None)]
  TOrdemCargaDoc = class
  private
    [Column('IDDOC', [TColumnProp.Required])]
    FIdDoc: Integer;

    [Column('IDCARGA', [TColumnProp.Required])]
    FIdCarga: Integer;

    [Column('NUMERODOC', [TColumnProp.Required])]
    FNumeroDoc: string;

    [ManyValuedAssociation([], CascadeTypeAllRemoveOrphan)]
    [ForeignJoinColumn('IDDOC', [])]
    FOrdemCargaItemList: Proxy<TList<TOrdemCargaItem>>;

    function GetOrdemCargaItemList: TList<TOrdemCargaItem>;
  public
    constructor Create();
    destructor Destroy; override;

    property IdDoc: Integer read FIdDoc write FIdDoc;
    property IdCarga: Integer read FIdCarga write FIdCarga;
    property NumeroDoc: string read FNumeroDoc write FNumeroDoc;
    property OrdemCargaItemList: TList<TOrdemCargaItem> read GetOrdemCargaItemList;
  end;

implementation

{ TOrdemCargaDoc }

{ TOrdemCargaDoc }

constructor TOrdemCargaDoc.Create;
begin
  inherited Create;
  FOrdemCargaItemList.SetInitialValue(TList<TOrdemCargaItem>.Create);
end;

destructor TOrdemCargaDoc.Destroy;
begin
  FOrdemCargaItemList.DestroyValue;
  inherited;
end;

function TOrdemCargaDoc.GetOrdemCargaItemList: TList<TOrdemCargaItem>;
begin
  Result := FOrdemCargaItemList.Value;
end;

initialization
  RegisterEntity(TOrdemCargaDoc);

end.

