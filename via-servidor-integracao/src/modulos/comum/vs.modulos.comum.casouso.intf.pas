unit vs.modulos.comum.casouso.intf;

interface

type

  ICasoUso<TRequisicao, TResposta> = interface
    ['{9BF49FE3-65D5-44C0-95D5-33872FF7F22F}']
    function Executar(const ARequisicao: TRequisicao): TResposta;
  end;

implementation

end.
