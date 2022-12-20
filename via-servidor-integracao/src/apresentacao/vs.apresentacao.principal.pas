unit vs.apresentacao.principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.TMSLogging,
  TMSLoggingCore,
  TMSLoggingUtils;

type

  TFPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    memLog: TMemo;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DoOutput(Sender: TObject; AOutputInformation: TTMSLoggerOutputInformation);
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  vs.infra;

{$R *.dfm}

procedure TFPrincipal.DoOutput(Sender: TObject;
  AOutputInformation: TTMSLoggerOutputInformation);
begin
  memLog.Lines.Add(
    TTMSLoggerUtils.GetConcatenatedLogMessage(AOutputInformation, True)
  );
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  TMSLogger.OnOutput := Self.DoOutput;
  TMSLogger.Clear;

  vs.infra.IniciarServidorHttp;
  TMSLogger.Info('Servidor de integração rodando na porta: 8088');
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  vs.infra.PararServidorHttp;
end;

end.
