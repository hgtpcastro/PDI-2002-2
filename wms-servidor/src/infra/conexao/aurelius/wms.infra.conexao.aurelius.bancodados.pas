unit wms.infra.conexao.aurelius.bancodados;

interface

uses
  Aurelius.Drivers.Interfaces;

procedure AtualizarBancoDados(const AConnection: IDBConnection);

implementation

uses
  // TMS Aurelius
  Aurelius.Criteria.Base,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  // WmsServidor
  wms.infra.modulos.expedicao.modelo.aurelius.carga;

procedure CriarDadosParaTeste(const AObjectManager: TObjectManager);
var
  LCarga: TCargaModelo;
begin
  LCarga := TCargaModelo.Create;
  LCarga.IdCarga := 1;
  LCarga.DadosCarga.AsString := '...';
  LCarga.CargaFinalizada := 'N';
  AObjectManager.Save(LCarga);
end;

procedure AtualizarBancoDados(const AConnection: IDBConnection);
var
  LDatabaseManager: TDatabaseManager;
  LObjectManager: TObjectManager;
  LTransaction: IDBTransaction;
begin
  LDatabaseManager := TDatabaseManager.Create(AConnection);
  try
    LDatabaseManager.UpdateDatabase;
  finally
    LDatabaseManager.Free;
  end;

  (*
  LObjectManager := TObjectManager.Create(AConnection);
  try
    if LObjectManager.Find<TCargaModelo>.Take(1).UniqueResult = nil then
    begin
      LTransaction := AConnection.BeginTransaction;
      try
        CriarDadosParaTeste(LObjectManager);
        LTransaction.Commit;
      except
        LTransaction.Rollback;
        raise;
      end;
    end;
  finally
    LObjectManager.Free;
  end;
  *)
end;

end.
