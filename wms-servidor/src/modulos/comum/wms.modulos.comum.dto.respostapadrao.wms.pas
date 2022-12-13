unit wms.modulos.comum.dto.respostapadrao.wms;

interface

type

  TRespostaPadraoWmsDto = class
  public
    codigo: Integer;
    msg: string;
  end;

  TRespostaPadraoWmsDtoFactory = class
  public
    class function Sucesso(const AMensagem: string): TRespostaPadraoWmsDto;
    class function Falha(const AMensagem: string): TRespostaPadraoWmsDto;
  end;

implementation

{ TRespostaPadraoFactoryDto }

class function TRespostaPadraoWmsDtoFactory.Falha(
  const AMensagem: string): TRespostaPadraoWmsDto;
begin
  Result := TRespostaPadraoWmsDto.Create;
  Result.codigo := 0;
  Result.msg := AMensagem;
end;

class function TRespostaPadraoWmsDtoFactory.Sucesso(
  const AMensagem: string): TRespostaPadraoWmsDto;
begin
  Result := TRespostaPadraoWmsDto.Create;
  Result.codigo := 1;
  Result.msg := AMensagem;
end;

end.
