unit wms.infra.http.rotas.expedicao.xdata;

interface

uses
  System.Classes,
  System.Generics.Collections,
  // TMS XData
  XData.Service.Common,
  // WmsServidor
  wms.infra.http.rotas.expedicao.xdata.intf,
  wms.modulos.comum.dto.respostapadrao.wms,
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga;

type

  [ServiceImplementation]
  TRotasExpedicao = class(TInterfacedObject, IRotasExpedicao)
  private
    function IncluirCarga(const ARequisicao: TRequisicaoIncluirCargaDto): TRespostaPadraoWmsDto;
  end;

implementation

uses
  // WmsServidor
  wms.modulos.expedicao.casouso.factory;

{ TRotasExpedicao }

function TRotasExpedicao.IncluirCarga(
  const ARequisicao: TRequisicaoIncluirCargaDto): TRespostaPadraoWmsDto;
begin
  Result := TCasoUsoFactory.IncluirCarga.Executar(ARequisicao);
end;

initialization
  RegisterServiceType(TypeInfo(TRotasExpedicao));

end.
