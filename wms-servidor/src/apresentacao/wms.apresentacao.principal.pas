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
  Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

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
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  wms.infra;

{$R *.dfm}

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  wms.infra.IniciarServidorHttp;
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  wms.infra.PararServidorHttp;
end;

end.
