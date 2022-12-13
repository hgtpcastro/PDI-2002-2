program WmsServidor;

uses
  Vcl.Forms,
  wms.apresentacao.principal in 'apresentacao\wms.apresentacao.principal.pas' {FPrincipal},
  wms.infra.conexao.aurelius.firedac in 'infra\conexao\aurelius\wms.infra.conexao.aurelius.firedac.pas' {ConexaoFireDac: TDataModule},
  wms.infra.http.servidor.xdata in 'infra\http\servidor\xdata\wms.infra.http.servidor.xdata.pas',
  wms.infra.http.rotas.expedicao.xdata.intf in 'infra\http\rotas\xdata\wms.infra.http.rotas.expedicao.xdata.intf.pas',
  wms.infra.http.rotas.expedicao.xdata in 'infra\http\rotas\xdata\wms.infra.http.rotas.expedicao.xdata.pas',
  wms.infra in 'infra\wms.infra.pas',
  wms.modulos.comum.casouso.intf in 'modulos\comum\wms.modulos.comum.casouso.intf.pas',
  wms.modulos.comum.dto.respostapadrao.wms in 'modulos\comum\wms.modulos.comum.dto.respostapadrao.wms.pas',
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga in 'modulos\expedicao\casouso\dto\wms.modulos.expedicao.casouso.dto.requisicao.incluircarga.pas',
  wms.modulos.expedicao.casouso.incluircarga in 'modulos\expedicao\casouso\wms.modulos.expedicao.casouso.incluircarga.pas',
  wms.modulos.expedicao.dominio.repositorio.intf in 'modulos\expedicao\dominio\repositorio\wms.modulos.expedicao.dominio.repositorio.intf.pas',
  wms.modulos.expedicao.dominio.entidade.carga in 'modulos\expedicao\dominio\entidade\wms.modulos.expedicao.dominio.entidade.carga.pas',
  wms.modulos.expedicao.servico.webhook.intf in 'modulos\expedicao\servico\wms.modulos.expedicao.servico.webhook.intf.pas',
  wms.infra.modulos.expedicao.servico.integracaovia.xdata in 'infra\modulos\expedicao\servico\integracaovia\xdata\wms.infra.modulos.expedicao.servico.integracaovia.xdata.pas',
  wms.infra.modulos.expedicao.repositorio.xdata.carga in 'infra\modulos\expedicao\repositorio\xdata\wms.infra.modulos.expedicao.repositorio.xdata.carga.pas',
  wms.infra.modulos.expedicao.modelo.aurelius.carga in 'infra\modulos\expedicao\modelo\aurelius\wms.infra.modulos.expedicao.modelo.aurelius.carga.pas',
  wms.modulos.expedicao.casouso.factory in 'modulos\expedicao\wms.modulos.expedicao.casouso.factory.pas',
  wms.infra.conexao.aurelius.bancodados in 'infra\conexao\aurelius\wms.infra.conexao.aurelius.bancodados.pas',
  vs.infra.http.rotas.ordemcarga.xdata.intf in '..\..\via-servidor-integracao\src\infra\http\rotas\xdata\vs.infra.http.rotas.ordemcarga.xdata.intf.pas',
  vs.modulos.carregamento.dto.requisicao.incluircarregamento in '..\..\via-servidor-integracao\src\modulos\carregamento\vs.modulos.carregamento.dto.requisicao.incluircarregamento.pas',
  vs.modulos.comum.dto.respostapadrao in '..\..\via-servidor-integracao\src\modulos\comum\vs.modulos.comum.dto.respostapadrao.pas',
  vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga in '..\..\via-servidor-integracao\src\modulos\ordemcarga\casouso\dto\vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
