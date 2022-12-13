unit vs.modulos.ordemcarga.casouso.dto.resposta.sincronizarordemcarga;

interface

uses
  System.Generics.Collections;

type

  TItemDto = class;

  TRespostaSincronizarOrdemCargaDto = class
  public
    constructor Create;
    destructor Destroy; override;
    procedure Release;
  public
    idCarga: Integer;
    listaItens: TList<TItemDto>;
  end;

  TItemDto = class
  public
    idItem: Integer;
    idDocumento: Integer;
    idProduto: Integer;
    quantidade: Extended;
  end;

implementation

{ TRespostaSincronizarOrdemCargaDto }

constructor TRespostaSincronizarOrdemCargaDto.Create;
begin
  inherited Create;
  listaItens := TList<TItemDto>.Create;
end;

destructor TRespostaSincronizarOrdemCargaDto.Destroy;
begin
  listaItens.Free;
  inherited;
end;

procedure TRespostaSincronizarOrdemCargaDto.Release;
var
  LItem: TObject;
begin
  if Self = nil then Exit;
  if System.Assigned(listaItens) then
    begin
    for LItem in listaItens do
      LItem.Free
  end;

  Self.Free;
end;

end.
