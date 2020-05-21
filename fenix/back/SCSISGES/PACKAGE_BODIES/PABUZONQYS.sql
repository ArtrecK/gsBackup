--------------------------------------------------------
--  DDL for Package Body PABUZONQYS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PABUZONQYS" 
AS

   csl_0           CONSTANT INTEGER := 0;
   csl_1           CONSTANT INTEGER := 1;
   csl_2           CONSTANT INTEGER := 2;
   vl_TOTAL        INTEGER := 0;
   vl_FECHA        INTEGER:=TO_CHAR(sysdate,'YYYYMMDD');
   vl_YEAR         INTEGER:=EXTRACT(YEAR FROM sysdate);
   vl_MONTH        INTEGER:=EXTRACT(MONTH FROM sysdate);
   vl_DAY          INTEGER:=EXTRACT(DAY FROM sysdate);

   PROCEDURE SPGUARDABUZON (
      pa_FCEMPNUM               IN   SCSISGES.TABUZON.FCEMPNUM%TYPE,       
      pa_FISUCURSAL             IN   SCSISGES.TABUZON.FISUCURSAL%TYPE,           
      pa_FICATBUZONID           IN   SCSISGES.TABUZON.FICATBUZONID%TYPE,
      pa_FIESTBUZONID           IN   SCSISGES.TABUZON.FIESTBUZONID%TYPE,
      pa_FCTEXTOBUZON           IN   SCSISGES.TABUZON.FCTEXTOBUZON%TYPE,
      pa_FNTELEFONO             IN   VARCHAR2 DEFAULT NULL,
      pa_CODIGO                 OUT  INTEGER,
      pa_MENSAJE                OUT  VARCHAR2,
      pa_MENSAJEERROR           OUT  VARCHAR2)
   AS

   BEGIN

    SELECT COUNT(FCEMPNUM) INTO vl_TOTAL FROM SCSISGES.TABUZON 
    WHERE FCEMPNUM > csl_0 
    AND FCEMPNUM = pa_FCEMPNUM 
    AND FISUCURSAL = pa_FISUCURSAL
    AND FNINACTIVO = csl_0
    AND TO_CHAR(FDCREACION,'YYYY') = vl_YEAR
    AND TO_CHAR(FDCREACION,'MM') = vl_MONTH
    AND TO_CHAR(FDCREACION,'DD') = vl_DAY;

    IF vl_TOTAL > 1 
    THEN
      pa_CODIGO := csl_2;
      pa_MENSAJE := 'limite Excedido';
      pa_MENSAJEERROR := '';

     ELSE
         --Insert nueva queja o sugerencia 
          INSERT INTO SCSISGES.TABUZON (FIBUZONID
                                    , FCEMPNUM             
                                    , FISUCURSAL
                                    , FICATBUZONID
                                    , FIESTBUZONID
                                    , FCTEXTOBUZON
                                    , FNTELEFONO)
                            VALUES (SCSISGES.SEQ_TABUZON.NEXTVAL
                                  , pa_FCEMPNUM
                                  , pa_FISUCURSAL
                                  , pa_FICATBUZONID
                                  , pa_FIESTBUZONID
                                  , pa_FCTEXTOBUZON
                                  , pa_FNTELEFONO);


      COMMIT;
      pa_CODIGO := csl_0;
      pa_MENSAJE := 'OK';
      pa_MENSAJEERROR := '';

    END IF;    

   EXCEPTION
      WHEN OTHERS
      THEN
      ROLLBACK;
      SCSISGES.SPERRORES(SYSDATE,SQLCODE,SUBSTR(SQLERRM,0,200),'SCSISGES.PABUZONQYS.SPGUARDABUZON');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL REALIZAR EL GUARDADO DE INFORMACI�N';
         pa_MENSAJEERROR := SQLCODE || '-' || SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE () || ' - SCSISGES.PABUZONQYS.SPGUARDABUZON';
END SPGUARDABUZON;


   PROCEDURE SPOBTIENECATBUZ (
        pa_TIPOBUZON   IN SCSISGES.TCCATBUZON.FICATBUZONID%TYPE,
        pa_BANDERA     OUT INTEGER,
        cur_TIPOBUZON  OUT SYS_REFCURSOR,
        pa_CODIGO      OUT INTEGER,
        pa_MENSAJE     OUT VARCHAR2
    )

    AS

    BEGIN

        IF pa_TIPOBUZON > csl_0 THEN

            OPEN cur_TIPOBUZON FOR     

               SELECT
                   ficatbuzonid,
                   fcdescripcion
               FROM
                   scsisges.tccatbuzon
               WHERE
                   fninactivo = csl_0
                   and ficatbuzonid = pa_TIPOBUZON
               ORDER BY
                   fnordenpriori;

            pa_BANDERA:= csl_0;
            pa_MENSAJE:= 'FILTRO';

        ELSE

            OPEN cur_TIPOBUZON FOR
               SELECT
                   ficatbuzonid,
                   fcdescripcion
               FROM
                   scsisges.tccatbuzon
               WHERE
                   fninactivo = csl_0 
               AND ficatbuzonid > csl_0                  
               ORDER BY
                   fnordenpriori;

            pa_BANDERA:= csl_0;
            pa_MENSAJE:= 'TODOS';            

        END IF;

               EXCEPTION
               WHEN OTHERS THEN
                    pa_CODIGO  := sqlcode;
                    pa_MENSAJE := sqlerrm; 
                    pa_BANDERA := csl_1;

    END SPOBTIENECATBUZ;


END PABUZONQYS;

/

  GRANT EXECUTE ON "SCSISGES"."PABUZONQYS" TO "USRSISGES";
