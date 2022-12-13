unit vs.modulos.carregamento.dto.requisicao.incluircarregamento;

interface

uses
  System.Generics.Collections;

type

  TItemDto = class;

  TRquisicaoIncluirCarregamentoDto = class
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

{ TRquisicaoIncluirCarregamentoDto }

constructor TRquisicaoIncluirCarregamentoDto.Create;
begin
  inherited Create;
  listaItens := TList<TItemDto>.Create;
end;

destructor TRquisicaoIncluirCarregamentoDto.Destroy;
begin
  listaItens.Free;
  inherited;
end;

procedure TRquisicaoIncluirCarregamentoDto.Release;
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
