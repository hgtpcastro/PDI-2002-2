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
    function ConsultarDadosOrdemCarga(const AIdCarga: Integer): TOrdemCarga;
    function IncluirCargaNoWms(const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
  public
    constructor Create(const ARepositorio: IOrdemCargaRepositorio; const AServico: IIntegracaoWmsServico);
    class function New(const ARepositorio: IOrdemCargaRepositorio; const AServico: IIntegracaoWmsServico): ICasoUso<TRequisicaoSincronizarOrdemCargaDto, TRespostaPadraoDto>;
    function Executar(const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;
  end;

implementation

uses
  SysUtils,
  System.Generics.Collections,
  // TMS Logger
  Vcl.TMSLogging,
  // ViaServidorIntegracao
  vs.modulos.ordemcarga.servico.dto.incluirordemcarga;

{ TSincronizarOrdemCarga }

function TSincronizarOrdemCargaCasoUso.ConsultarDadosOrdemCarga(
  const AIdCarga: Integer): TOrdemCarga;
begin
  TMSLogger.Info('Consultando os dados da Ordem de Carga.');
  Result := FRepositorio.Consultar(AIdCarga);
  Sleep(3000);
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
  Sleep(5000);
  TMSLogger.Info(Format('Sincronizando a Ordem Carga(%d).',[ARequisicao.idCarga]));
  Sleep(3000);
  LOrdemCarga := Self.ConsultarDadosOrdemCarga(ARequisicao.idCarga);
  Result := Self.IncluirCargaNoWms(LOrdemCarga);
  TMSLogger.LogSeparator;
end;

function TSincronizarOrdemCargaCasoUso.IncluirCargaNoWms(
  const AOrdemCarga: TOrdemCarga): TRespostaPadraoDto;
begin
  TMSLogger.Info('Incluindo a Ordem de Carga no Integrador Wms.');
  if Assigned(FIntegracaoWmsServico) then
  begin
    Sleep(3000);
    Result := FIntegracaoWmsServico.IncluirCarga(AOrdemCarga)
  end
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
