unit wms.modulos.expedicao.casouso.incluircarga;

interface

uses
  // WmsServidor
  wms.modulos.comum.casouso.intf,
  wms.modulos.comum.dto.respostapadrao.wms,
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga,
  wms.modulos.expedicao.dominio.entidade.carga,
  wms.modulos.expedicao.dominio.repositorio.intf,
  wms.modulos.expedicao.servico.webhook.intf;

type

  TIncluirCargaCasoUso = class(
    TInterfacedObject,
    ICasoUso<TRequisicaoIncluirCargaDto, TRespostaPadraoWmsDto>)
  strict private
    FRepositorio: ICargaRepositorio;
    FWebHookServico: IWebHookServico;
    procedure DispararEventoCarregamentoFinalizado;
    procedure IncluirCargaNoBancoDados(const ARequisicao: TRequisicaoIncluirCargaDto);
    procedure FinalizarCarregamento;
  public
    constructor Create(const ARepositorio: ICargaRepositorio; const AServico: IWebHookServico);
    class function New(const ARepositorio: ICargaRepositorio; const AServico: IWebHookServico): ICasoUso<TRequisicaoIncluirCargaDto, TRespostaPadraoWmsDto>;
    function Executar(const ARequisicao: TRequisicaoIncluirCargaDto): TRespostaPadraoWmsDto;
  end;

implementation

uses
  System.Generics.Collections,
  // TMS Bcl
  Bcl.Json, System.SysUtils;
  // WmsServidor
//  wms.modulos.expedicao.servico.dto.webhook;

{ TSincronizarOrdemCarga }

constructor TIncluirCargaCasoUso.Create(
  const ARepositorio: ICargaRepositorio;
  const AServico: IWebHookServico);
begin
  inherited Create;
  FRepositorio := ARepositorio;
  FWebHookServico := AServico;
end;

procedure TIncluirCargaCasoUso.DispararEventoCarregamentoFinalizado;
var
  LCarga: TCarga;
  LCargaList: TList<TCarga>;
begin
  LCargaList := FRepositorio.ConsultarCargaFinalizada;
  try
    for LCarga in LCargaList do
    begin
      FWebHookServico.IncluirCarregamento(LCarga);
    end;
  finally
    LCargaList.Free;
  end;
end;

function TIncluirCargaCasoUso.Executar(const ARequisicao: TRequisicaoIncluirCargaDto): TRespostaPadraoWmsDto;
begin
  try
    Self.IncluirCargaNoBancoDados(ARequisicao);
    Sleep(3000);
    Self.FinalizarCarregamento;
    Self.DispararEventoCarregamentoFinalizado;
    Result := TRespostaPadraoWmsDtoFactory.Sucesso('Processado com Sucesso!');
  except
    on E: Exception do
    begin
      Result := TRespostaPadraoWmsDtoFactory.Falha(E.message);
    end;
  end;
end;

procedure TIncluirCargaCasoUso.IncluirCargaNoBancoDados(
  const ARequisicao: TRequisicaoIncluirCargaDto);
var
  LCarga: TCarga;
begin
  LCarga := TCarga.Create;
  try
    LCarga.IdCarga := ARequisicao.idCarga;
    LCarga.CargaFinalizada := False;
    LCarga.DadosCarga := TJson.SerializeAs<TRequisicaoIncluirCargaDto>(ARequisicao);

    FRepositorio.Incluir(LCarga);
  finally
    LCarga.Free;
  end;
end;

class function TIncluirCargaCasoUso.New(
  const ARepositorio: ICargaRepositorio;
  const AServico: IWebHookServico): ICasoUso<TRequisicaoIncluirCargaDto, TRespostaPadraoWmsDto>;
begin
  Result := Self.Create(ARepositorio, AServico);
end;

procedure TIncluirCargaCasoUso.FinalizarCarregamento;
var
  LCarga: TCarga;
  LCargaAlterada: TCarga;
  LCargaList: TList<TCarga>;
begin
  LCargaList := FRepositorio.ConsultarCargaNaoFinalizada;
  try
    for LCarga in LCargaList do
    begin
      LCarga.CargaFinalizada := True;
      LCargaAlterada := FRepositorio.Alterar(LCarga);
      LCargaAlterada.Free;
    end;
  finally
    LCargaList.Free;
  end;
end;

end.
