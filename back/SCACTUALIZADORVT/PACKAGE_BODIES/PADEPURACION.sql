--------------------------------------------------------
--  DDL for Package Body PADEPURACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PADEPURACION" 
AS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_7   CONSTANT INTEGER := 7;

   PROCEDURE SPDEPURAHIST (PA_CODE      OUT INTEGER,
                           PA_MESSAGE   OUT VARCHAR2,
                           PA_DETAIL    OUT VARCHAR2)
   IS
   BEGIN
      FOR cur IN (SELECT 0 AS SUCMIN,
                             218 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 219 AS SUCMIN,
                             596 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 597 AS SUCMIN,
                             988 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 989 AS SUCMIN,
                             1388 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 1389 AS SUCMIN,
                             1714 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 1715 AS SUCMIN,
                             2049 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 2050 AS SUCMIN,
                             2190 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 2191 AS SUCMIN,
                             2533 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 2534 AS SUCMIN,
                             3061 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 3062 AS SUCMIN,
                             3422 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 3423 AS SUCMIN,
                             3885 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 3886 AS SUCMIN,
                             4609 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 4610 AS SUCMIN,
                             5117 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 5118 AS SUCMIN,
                             5695 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 5696 AS SUCMIN,
                             6212 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 6213 AS SUCMIN,
                             6937 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 6938 AS SUCMIN,
                             7444 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 7445 AS SUCMIN,
                             8337 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 8338 AS SUCMIN,
                             8964 AS SUCMAX  FROM DUAL
                             UNION
                             SELECT 8965 AS SUCMIN,
                             1000 AS SUCMAX  FROM DUAL
                             )
                             LOOP
            DELETE FROM SCACTUALIZADORVT.TATRNCRCBH
            WHERE TRUNC(FDCREACION) < TRUNC((SYSDATE - CSL_7))
            AND FIPAISID=FIPAISID + CSL_0
            AND FICANAL=FICANAL + CSL_0
            AND FISUCURSAL=FISUCURSAL + CSL_0
            AND FITRANNO = FITRANNO + CSL_0
            AND FIPAISID > CSL_0
            AND FICANAL > CSL_0
            AND FISUCURSAL BETWEEN cur.SUCMIN AND cur.SUCMAX
            AND FITRANNO > CSL_0;

            DELETE FROM SCACTUALIZADORVT.TATRNCRDTH
            WHERE TRUNC(FDCREACION) < TRUNC((SYSDATE - CSL_7))
            AND FIPAISID=FIPAISID + CSL_0
            AND FICANAL=FICANAL + CSL_0
            AND FISUCURSAL=FISUCURSAL + CSL_0
            AND FITRANNO = FITRANNO + CSL_0
            AND FICONSDETA = FICONSDETA  + CSL_0
            AND FITIPOREG = FITIPOREG + CSL_0
            AND FIPAISID > CSL_0
            AND FICANAL > CSL_0
            AND FISUCURSAL BETWEEN cur.SUCMIN AND cur.SUCMAX
            AND FITRANNO > CSL_0
            AND FICONSDETA > CSL_0
            AND FITIPOREG > CSL_0;

            END LOOP;
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         PA_CODE := CSL_0;
         PA_MESSAGE := 'Ocurrio un error en depuraci�n de historial';
         PA_DETAIL :=
               SQLCODE
            || ' '
            || SQLERRM
            || ' '
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   END SPDEPURAHIST;
END PADEPURACION;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADEPURACION" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADEPURACION" TO "USRINFFENIX";
