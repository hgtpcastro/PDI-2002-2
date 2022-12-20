unit wms.apresentacao.principal;

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
  Vcl.TMSLogging,
  TMSLoggingCore,
  TMSLoggingUtils;

type

  TFPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    memLog: TMemo;
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
  wms.infra;

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

  wms.infra.IniciarServidorHttp;
  TMSLogger.Info('Servidor de integração rodando na porta: 8089');
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  wms.infra.PararServidorHttp;
end;

end.
