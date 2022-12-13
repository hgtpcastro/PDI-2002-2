unit vs.infra.conexao.aurelius.firedac;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Dapt,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Comp.UI,
  FireDAC.VCLUI.Wait,
  // TMS Aurelius
  Aurelius.Drivers.Interfaces,
  Aurelius.SQL.Firebird,
  Aurelius.Schema.Firebird,
  Aurelius.Drivers.FireDac;

type

  TConexaoFireDac = class(TDataModule)
    Conexao: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
  private
    procedure ConfigurarConexao(var AConexao: TFDConnection);
  public
    procedure AfterConstruction; override;
    class function CriarConexao: IDBConnection;
    class function CriarFabricaConexao: IDBConnectionFactory;
    class function CriarPoolConexao(const APoolSize: Integer): IDBConnectionPool;
  end;

  function CriarPoolConexao(const APoolSize: Integer): IDBConnectionPool;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  System.IOUtils,
  // TMS XData
  XData.Aurelius.ConnectionPool,
  // TMS Aurelius
  Aurelius.Drivers.Base,
  Aurelius.Global.Config;

{$R *.dfm}

function CriarPoolConexao(const APoolSize: Integer): IDBConnectionPool;
begin
  Result := TConexaoFireDac.CriarPoolConexao(20)
end;

{ TConexaoFireDac }

procedure TConexaoFireDac.AfterConstruction;
var
  LAureliusConfigs: TGlobalConfigs;
begin
  inherited;
  LAureliusConfigs := TGlobalConfigs.GetInstance;
  LAureliusConfigs.MaxEagerFetchDepth := 4;
  Self.ConfigurarConexao(Conexao);
end;

procedure TConexaoFireDac.ConfigurarConexao(var AConexao: TFDConnection);
var
  LPathArquivo: String;
  LArquivo: TStrings;
begin
  LPathArquivo := TPath.Combine(TPath.GetDirectoryName(
    ParamStr(0)), 'ParametrosConexao.txt'
  );
  //variável para carregar os parametros do banco
  LArquivo := TStringList.Create;
  try
    LArquivo.LoadFromFile(LPathArquivo);
    AConexao.Params.Text := LArquivo.Text;
  finally
    LArquivo.Free;
  end;
  AConexao.LoginPrompt := False;
end;

class function TConexaoFireDac.CriarConexao: IDBConnection;
var
  LDataModule: TConexaoFireDac;
begin
  LDataModule := TConexaoFireDac.Create(nil);
  Result := TFireDacConnectionAdapter.Create(
    LDataModule.Conexao, 'Firebird', LDataModule
  );
end;

class function TConexaoFireDac.CriarFabricaConexao: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := Self.CriarConexao;
    end
  );
end;

class function TConexaoFireDac.CriarPoolConexao(
  const APoolSize: Integer): IDBConnectionPool;
begin
  Result := TDBConnectionPool.Create(APoolSize, Self.CriarFabricaConexao);
end;

end.
