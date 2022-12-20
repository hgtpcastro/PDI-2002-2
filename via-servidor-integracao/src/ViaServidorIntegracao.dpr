program ViaServidorIntegracao;

uses
  Vcl.Forms,
  vs.apresentacao.principal in 'apresentacao\vs.apresentacao.principal.pas' {FPrincipal},
  vs.infra.http.servidor.xdata in 'infra\http\servidor\xdata\vs.infra.http.servidor.xdata.pas',
  vs.infra.conexao.aurelius.firedac in 'infra\conexao\aurelius\vs.infra.conexao.aurelius.firedac.pas' {ConexaoFireDac: TDataModule},
  vs.modulos.ordemcarga.dominio.entidade.ordemcarga in 'modulos\ordemcarga\dominio\entidade\vs.modulos.ordemcarga.dominio.entidade.ordemcarga.pas',
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargacab in 'infra\modulos\ordemcarga\modelo\aurelius\vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargacab.pas',
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargadoc in 'infra\modulos\ordemcarga\modelo\aurelius\vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargadoc.pas',
  vs.infra.modulos.ordemcarga.modelo.aurelius.confordemcarga in 'infra\modulos\ordemcarga\modelo\aurelius\vs.infra.modulos.ordemcarga.modelo.aurelius.confordemcarga.pas',
  vs.infra in 'infra\vs.infra.pas',
  vs.infra.http.rotas.ordemcarga.xdata in 'infra\http\rotas\xdata\vs.infra.http.rotas.ordemcarga.xdata.pas',
  vs.infra.http.rotas.ordemcarga.xdata.intf in 'infra\http\rotas\xdata\vs.infra.http.rotas.ordemcarga.xdata.intf.pas',
  vs.modulos.comum.casouso.intf in 'modulos\comum\vs.modulos.comum.casouso.intf.pas',
  vs.modulos.ordemcarga.casouso.sincronizarordemcarga in 'modulos\ordemcarga\casouso\vs.modulos.ordemcarga.casouso.sincronizarordemcarga.pas',
  vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga in 'modulos\ordemcarga\casouso\dto\vs.modulos.ordemcarga.casouso.dto.requisicao.sincronizarordemcarga.pas',
  vs.modulos.ordemcarga.dominio.repositorio.intf in 'modulos\ordemcarga\dominio\repositorio\vs.modulos.ordemcarga.dominio.repositorio.intf.pas',
  vs.modulos.ordemcarga.casouso.dto.resposta.sincronizarordemcarga in 'modulos\ordemcarga\casouso\dto\vs.modulos.ordemcarga.casouso.dto.resposta.sincronizarordemcarga.pas',
  vs.infra.modulos.ordemcarga.repositorio.xdata.ordemcarga in 'infra\modulos\ordemcarga\repositorio\xdata\vs.infra.modulos.ordemcarga.repositorio.xdata.ordemcarga.pas',
  vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargaitem in 'infra\modulos\ordemcarga\modelo\aurelius\vs.infra.modulos.ordemcarga.modelo.aurelius.ordemcargaitem.pas',
  vs.modulos.comum.casouso.factory in 'modulos\comum\vs.modulos.comum.casouso.factory.pas',
  vs.modulos.ordemcarga.servico.integracaowms.intf in 'modulos\ordemcarga\servico\vs.modulos.ordemcarga.servico.integracaowms.intf.pas',
  vs.modulos.ordemcarga.servico.dto.incluirordemcarga in 'modulos\ordemcarga\servico\dto\vs.modulos.ordemcarga.servico.dto.incluirordemcarga.pas',
  vs.infra.modulos.ordemcarga.servico.integracaowms.xdata in 'infra\modulos\ordemcarga\servico\integracaowms\xdata\vs.infra.modulos.ordemcarga.servico.integracaowms.xdata.pas',
  vs.modulos.comum.dto.respostapadrao in 'modulos\comum\vs.modulos.comum.dto.respostapadrao.pas',
  wms.infra.http.rotas.expedicao.xdata.intf in '..\..\wms-servidor\src\infra\http\rotas\xdata\wms.infra.http.rotas.expedicao.xdata.intf.pas',
  wms.modulos.expedicao.casouso.dto.requisicao.incluircarga in '..\..\wms-servidor\src\modulos\expedicao\casouso\dto\wms.modulos.expedicao.casouso.dto.requisicao.incluircarga.pas',
  wms.modulos.comum.dto.respostapadrao.wms in '..\..\wms-servidor\src\modulos\comum\wms.modulos.comum.dto.respostapadrao.wms.pas',
  vs.modulos.carregamento.casouso.incluircarregamento in 'modulos\carregamento\vs.modulos.carregamento.casouso.incluircarregamento.pas',
  vs.modulos.carregamento.dto.requisicao.incluircarregamento in 'modulos\carregamento\vs.modulos.carregamento.dto.requisicao.incluircarregamento.pas',
  vs.modulos.carregamento.repositorio.ordemcargacarreg in 'modulos\carregamento\vs.modulos.carregamento.repositorio.ordemcargacarreg.pas',
  vs.modulos.carregamento.repositorio.ordemcargacarreg.intf in 'modulos\carregamento\vs.modulos.carregamento.repositorio.ordemcargacarreg.intf.pas',
  vs.modulos.carregamento.modelo.ordemcargacarreg in 'modulos\carregamento\vs.modulos.carregamento.modelo.ordemcargacarreg.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
