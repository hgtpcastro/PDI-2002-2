unit vs.infra.http.servidor.xdata;

interface

uses
  System.SysUtils,
  // TMS Sparkle
  Sparkle.HttpSys.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module,
  // TMS XData
  XData.OpenApi.Service,
  XData.Server.Module;

procedure IniciarServidor;
procedure PararServidor;

implementation

uses
  // WMS
  vs.infra;

var
  GServidorHttp: THttpSysServer;

procedure IniciarServidor;
var
  LModuloDados: TXDataServerModule;
begin
  if Assigned(GServidorHttp) then Exit;

  //Swagger
  RegisterOpenApiService;

  GServidorHttp := THttpSysServer.Create;

  // Modulo de dados
  LModuloDados := TXDataServerModule.Create(
    'http://+:8088/api/integracao-wms'
    , vs.infra.CriarPoolConexao(20)
  );
  LModuloDados.AccessControlAllowOrigin := '*';
  LModuloDados.FlushMode := TXDataFlushMode.Single;
  LModuloDados.EnableEntityKeyAsSegment := True;

  GServidorHttp.AddModule(LModuloDados);
  GServidorHttp.Start;
end;

procedure PararServidor;
begin
  FreeAndNil(gServidorHttp);
end;

initialization
  GServidorHttp := nil;

finalization
  PararServidor;

end.
