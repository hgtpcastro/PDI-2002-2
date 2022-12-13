uses
  uVsHttpRequest, uLkJson, Classes;
                  
var
  oHttp: TVsHttp;
  cUrl: String;                  
  oResposta: THttpResponse;

function SincronizarOrdemCargaWms(cRequisicao: string): THttpResponse;
begin                                  
  oHttp := TVsHttp.Create;
  try
    oHttp.ContentType := 'application/json';
    cUrl := 'http://localhost:8088/api/integracao-wms/ordemcarga/sincronizar';
    Result := oHttp.Post(cUrl, cRequisicao);
  finally
    oHttp.free;
  end;                                     
end;                                                                     

begin
  oResposta := SincronizarOrdemCargaWms(
    Format('{"idCarga": %d}',[FOrdemCarga.ValorNaTela('IDCARGA')])
   );
   
  if oResposta.Statuscode = 200 then
  begin
    ShowMessage(
      'HTTP 200 OK' + #13#13 + 
      'Esses foram os dados recebidos: ' + #13#13  + 
      oResposta.Response
    );
  end  
end;
