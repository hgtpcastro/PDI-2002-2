unit vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargacab;

interface

uses
  SysUtils,
  Generics.Collections,
  // TMS Aurelius
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Proxy,
  // WMS
  vs.infra.modulos.ordemcarga.modelo.aurelius.confordemcarga,
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargadoc;

type

  [Entity]
  [Table('ORDEMCARGACAB')]
  [Sequence('GEN_ORDEMCARGACAB_IDCARGA')]
  [Id('FIdCarga', TIdGenerator.IdentityOrSequence)]
  TOrdemCargaCab = class
  private
    [Column('IDCARGA', [TColumnProp.Required])]
    FIdCarga: Integer;

    [Association([], CascadeTypeAll - [TCascadeType.Remove, TCascadeType.Flush])]
    [JoinColumn('CONFIG', [], 'ID')]
    FConfOrdemCarga: TConfOrdemCarga;

    [ManyValuedAssociation([], CascadeTypeAllRemoveOrphan)]
    [ForeignJoinColumn('IDCARGA', [])]
    FOrdemCargaDocList: Proxy<TList<TOrdemCargaDoc>>;

    function GetOrdemCargaDocList: TList<TOrdemCargaDoc>;
  public
    constructor Create();
    destructor Destroy; override;

    property IdCarga: Integer read FIdCarga write FIdCarga;
    property ConfOrdemCarga: TConfOrdemCarga read FConfOrdemCarga write FConfOrdemCarga;
    property OrdemCargaDocList: TList<TOrdemCargaDoc> read GetOrdemCargaDocList;
  end;

implementation

{ TOrdemCargaCab }

constructor TOrdemCargaCab.Create;
begin
  inherited;
  FOrdemCargaDocList.SetInitialValue(TList<TOrdemCargaDoc>.Create);
end;

destructor TOrdemCargaCab.Destroy;
begin
  FOrdemCargaDocList.DestroyValue;
  inherited;
end;

function TOrdemCargaCab.GetOrdemCargaDocList: TList<TOrdemCargaDoc>;
begin
  Result := FOrdemCargaDocList.Value;
end;

initialization
  RegisterEntity(TOrdemCargaCab);

finalization

end.
