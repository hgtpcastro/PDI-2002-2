unit vs.modulos.comum.dto.respostapadrao;

interface

type

  TRespostaPadraoDto = class
  public
    executouServico: Boolean;
    mensagem: string;
  end;

    TRespostaPadraoDtoFactory = class
  public
    class function Sucesso(const AMensagem: string): TRespostaPadraoDto;
    class function Falha(const AMensagem: string): TRespostaPadraoDto;
  end;

implementation

{ TRespostaPadraoFactoryDto }

class function TRespostaPadraoDtoFactory.Falha(
  const AMensagem: string): TRespostaPadraoDto;
begin
  Result := TRespostaPadraoDto.Create;
  Result.executouServico := False;
  Result.mensagem := AMensagem;
end;

class function TRespostaPadraoDtoFactory.Sucesso(
  const AMensagem: string): TRespostaPadraoDto;
begin
  Result := TRespostaPadraoDto.Create;
  Result.executouServico := True;
  Result.mensagem := AMensagem;
end;

end.
