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
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

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
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  vs.infra;

{$R *.dfm}

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  vs.infra.IniciarServidorHttp;
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  vs.infra.PararServidorHttp;
end;

end.
