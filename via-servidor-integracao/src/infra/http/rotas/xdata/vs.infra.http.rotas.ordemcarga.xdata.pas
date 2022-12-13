unit vs.infra.http.rotas.ordemcarga.xdata;

interface

uses
  System.Classes,
  System.Generics.Collections,
  // TMS XData
  XData.Service.Common,
  // ViaServidorIntegracao
  vs.infra.http.rotas.ordemcarga.xdata.intf,
  vs.modulos.carregamento.dto.requisicao.incluircarregamento,
  vs.modulos.comum.dto.respostapadrao,
  vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga;

type

  [ServiceImplementation]
  TRotasOrdemCarga = class(TInterfacedObject, IRotasOrdemCarga)
  private
    function Sincronizar(const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;
    function IncluirCarregamento(const ARequisicao: TRquisicaoIncluirCarregamentoDto): TRespostaPadraoDto;
  end;

implementation

uses
  // ViaServidorIntegracao
  vs.modulos.comum.casouso.factory;

{ TRotasOrdemCarga }

function TRotasOrdemCarga.IncluirCarregamento(
  const ARequisicao: TRquisicaoIncluirCarregamentoDto): TRespostaPadraoDto;
begin
  Result := TCasoUsoFactory.IncluirCarregamento.Executar(ARequisicao);
end;

function TRotasOrdemCarga.Sincronizar(
  const ARequisicao: TRequisicaoSincronizarOrdemCargaDto): TRespostaPadraoDto;
begin
  Result := TCasoUsoFactory.SincronizarOrdemCarga.Executar(ARequisicao);
end;

initialization
  RegisterServiceType(TypeInfo(TRotasOrdemCarga));

end.
