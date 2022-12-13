unit vs.modulos.ordemcarga.casouso.sincronizarordemcarga;

interface

uses
  // ViaServidorIntegracao
  vs.modulos.comum.casouso.intf,
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga,
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga,
  vs.modulos.ordemcarga.dominio.repositorio.intf,
  vs.modulos.ordemcarga.servico.integracaowms.intf;

type

  TSincronizarOrdemCargaCasoUso = class(
    TInterfacedObject,
    ICasoUso<TRequisicaoSincronizarOrdemCargaDto, TRespostaPadraoDto>)
  strict private
    FRepositorio: IOrdemCargaRepositorio;
    FIntegracaoWmsServico: IIntegracaoWmsServico;
    function  ConsultarDadosOrdemCarga(const AIdCarga: Integer): TOrdemCarga;
    function IncluirOrdemCargaNoWms(const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
  public
    constructor Create(const ARepositorio: IOrdemCargaRepositorio; const AServico: IIntegracaoWmsServico);
    class function New(const ARepositorio: IOrdemCargaRepositorio; const AServico: IIntegracaoWmsServico): ICasoUso<TRequisicaoSincronizarOrdemCargaDto, TRespostaPadraoDto>;
    function Executar(const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;
  end;

implementation

uses
  System.Generics.Collections,
  // ViaServidorIntegracao
  vs.modulos.ordemcarga.servico.dto.incluirordemcarga;

{ TSincronizarOrdemCarga }

function TSincronizarOrdemCargaCasoUso.ConsultarDadosOrdemCarga(
  const AIdCarga: Integer): TOrdemCarga;
begin
  Result := FRepositorio.Consultar(AIdCarga);
end;

constructor TSincronizarOrdemCargaCasoUso.Create(
  const ARepositorio: IOrdemCargaRepositorio;
  const AServico: IIntegracaoWmsServico);
begin
  inherited Create;
  FRepositorio := ARepositorio;
  FIntegracaoWmsServico := AServico;
end;

function TSincronizarOrdemCargaCasoUso.Executar(const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;
var
  LOrdemCarga: TOrdemCarga;
begin
  LOrdemCarga := Self.ConsultarDadosOrdemCarga(ARequisicao.idCarga);
  Result := Self.IncluirOrdemCargaNoWms(LOrdemCarga);
end;

function TSincronizarOrdemCargaCasoUso.IncluirOrdemCargaNoWms(
  const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
begin
  if Assigned(FIntegracaoWmsServico) then
    Result := FIntegracaoWmsServico.IncluirOrdemCarga(AOrdemCarga)
  else
    Result := TRespostaPadraoDtoFactory.Falha('Serviço de integração não informado!');
end;

class function TSincronizarOrdemCargaCasoUso.New(
  const ARepositorio: IOrdemCargaRepositorio;
  const AServico: IIntegracaoWmsServico): ICasoUso<TRequisicaoSincronizarOrdemCargaDto, TRespostaPadraoDto>;
begin
  Result := Self.Create(ARepositorio, AServico);
end;

end.
