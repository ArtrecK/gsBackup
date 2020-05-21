--------------------------------------------------------
--  DDL for Package Body PASUPERVISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PASUPERVISION" is
 
   CSL_0        CONSTANT PLS_INTEGER := 0;
  CSL_1        CONSTANT PLS_INTEGER := 1;
  CSL_2        CONSTANT PLS_INTEGER := 2;
  CSL_7        CONSTANT PLS_INTEGER := 7;
  CSL_100        CONSTANT PLS_INTEGER := 100;

PROCEDURE SPCONTPEDSUPERV(
   PA_FCNOEMPLEADO IN VARCHAR2
  ,PA_FISUCURSAL IN INTEGER
  ,PA_CONTEO     OUT NUMBER
  ,PA_MENSAJE    OUT VARCHAR2
  ,PA_CODERROR      OUT INTEGER
  ,PA_DESERROR     OUT VARCHAR2)
IS

 BEGIN

       SELECT COUNT(1)
       INTO PA_CONTEO
       FROM
        (SELECT TCEN.FIPAIS ,
                TCEN.FICANAL,
                TCEN.FISUCURSAL,
                TCEN.FIFOLIO
           FROM SCVENTASTIENDA.TACENCTETIENDA TCEN
           JOIN SCVENTASTIENDA.TAPEDIDOS TAPEDPEN
                ON TCEN.FINGCIOID = TAPEDPEN.FINGCIOID
                   AND TCEN.FINOTIENDA = TAPEDPEN.FINOTIENDA
                   AND TCEN.FICTEID = TAPEDPEN.FICTEID
                   AND TCEN.FIDIGITOVER = TAPEDPEN.FIDIGITOVER
                   AND TRIM(TAPEDPEN.FCEMPNOVENTA) = PA_FCNOEMPLEADO
                   AND TAPEDPEN.FISUCURSAL = PA_FISUCURSAL
                   AND TAPEDPEN.FIPEDSTAT=CSL_0
                   AND TAPEDPEN.FITIPOVENTA IN (CSL_1,CSL_2)
       GROUP BY TCEN.FIPAIS, TCEN.FICANAL, TCEN.FISUCURSAL, TCEN.FIFOLIO) TCLTES ;                       

 pa_codError:=CSL_1;
 PA_MENSAJE:= 'SE CONSULTO CORRECTAMENTE';

  EXCEPTION
    WHEN OTHERS THEN
      pa_codError  := SQLCODE;
      pa_desError := SUBSTR(SQLERRM, CSL_0,CSL_100);
      PA_MENSAJE:= 'OCURRIO UN ERROR AL CONSULTAR NUMERO DE PEDIDOS PENDIENTES POR SURTIR';
END SPCONTPEDSUPERV;

PROCEDURE SPCONTPRESUPSUPERV(
   PA_FCNOEMPLEADO IN VARCHAR2
  ,PA_FISUCURSAL IN INTEGER
  ,PA_DIAS IN INTEGER
  ,PA_CONTEO     OUT NUMBER
  ,PA_MENSAJE    OUT VARCHAR2
  ,PA_CODERROR      OUT INTEGER
  ,PA_DESERROR     OUT VARCHAR2)
IS

 BEGIN
     select count (distinct c.fipaiscu||c.ficanalcu||c.fisucursalcu||c.fifolio)
     INTO PA_CONTEO 
     from SCVENTASTIENDA.TAPREPARAME pp
    inner join SCVENTASTIENDA.TACENCTETIENDA c
    on c.fingcioid = pp.fingcioid and c.finotienda = pp.finotienda and c.ficteid = pp.ficteid and c.fidigitover = pp.fidigitover
    inner join SCVENTASTIENDA.TADETPREPARAM tp
    on pp.fipais = tp.fipais and pp.ficanal = tp.ficanal and pp.fisucursal = tp.fisucursal and pp.fifolioparam = tp.fifolioparam
    left join SCVENTASTIENDA.TCPRODUCTO t
    on tp.fiprodid = t.fnsku
    inner join SCVENTASTIENDA.TCLINEA l
    on t.fnlineasie = l.fnlinea
    left join SCVENTASTIENDA.TAPEDIDOS p
    on pp.fifolioparam = p.fifolioparam
     where pp.fisucursal = PA_FISUCURSAL and trim(pp.fcempno) = PA_FCNOEMPLEADO
     and TO_DATE(FDFECPREP,'DD/MM/YYYY') BETWEEN TO_DATE(SYSDATE, 'DD/MM/YYYY')- CSL_7 AND TO_DATE(SYSDATE, 'DD/MM/YYYY')
     and pp.finopedido = CSL_0;

  pa_codError:=CSL_1;
  PA_MENSAJE:= 'SE CONSULTO CORRECTAMENTE';

  EXCEPTION
    WHEN OTHERS THEN
      pa_codError  := SQLCODE;
      pa_desError := SUBSTR(SQLERRM, CSL_0,CSL_100);
      PA_MENSAJE:= 'OCURRIO UN ERROR AL CONSULTAR NUMERO DE PRESUPUESTOS';

END SPCONTPRESUPSUPERV;
end PASUPERVISION;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PASUPERVISION" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PASUPERVISION" TO "SCSISGES";
