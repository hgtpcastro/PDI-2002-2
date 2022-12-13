unit vs.infra;

interface

uses
  SysUtils,
  // TMS Aurelius
  Aurelius.Drivers.Interfaces,
  // WMS
  vs.infra.http.servidor.xdata,
  vs.infra.conexao.aurelius.firedac;

  // Alias para unit: vs.infra.http.xdata
  const IniciarServidorHttp: procedure = vs.infra.http.servidor.xdata.IniciarServidor;
  const PararServidorHttp: procedure = vs.infra.http.servidor.xdata.PararServidor;

  // Alias para unit: vs.infra.conexao.firedac
  const CriarPoolConexao: function(const APoolSize: integer): IDBConnectionPool = vs.infra.conexao.aurelius.firedac.CriarPoolConexao;

implementation


end.
