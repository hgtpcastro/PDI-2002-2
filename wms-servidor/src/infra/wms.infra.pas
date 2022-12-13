unit wms.infra;

interface

uses
  SysUtils,
  // TMS Aurelius
  Aurelius.Drivers.Interfaces,
  // WmsServidor
  wms.infra.http.servidor.xdata,
  wms.infra.conexao.aurelius.firedac;

  // Alias para unit: vs.infra.http.xdata
  const IniciarServidorHttp: procedure = wms.infra.http.servidor.xdata.IniciarServidor;
  const PararServidorHttp: procedure = wms.infra.http.servidor.xdata.PararServidor;

  // Alias para unit: vs.infra.conexao.firedac
  const CriarPoolConexao: function(const APoolSize: integer): IDBConnectionPool = wms.infra.conexao.aurelius.firedac.CriarPoolConexao;

implementation


end.
