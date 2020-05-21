--------------------------------------------------------
--  DDL for Function FNFXGETCTESGEST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNFXGETCTESGEST" (
   pa_opcionQuery IN NUMBER,
   pa_dataIN          IN SCSISGES.TYTBGSTCU)
   RETURN SCSISGES.TYTGETFUNCTE
   PIPELINED
IS
   out_rec         SCSISGES.TYOBGETFUNCTE
                      := SCSISGES.TYOBGETFUNCTE (NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL,
                                                NULL);

   CURSOR cur_datosCU
   IS
      SELECT ORDERID,
						       FIPAIS,
             FICANAL,
             FISUCURSAL,
             FIFOLIO
        FROM TABLE (pa_dataIN);

			CSL_0   CONSTANT PLS_INTEGER := 0;
   CSL_1   CONSTANT PLS_INTEGER := 1;

BEGIN

   FOR eachRow IN cur_datosCU
   LOOP
      out_rec.FIPAIS := eachRow.FIPAIS;
      out_rec.FICANAL := eachRow.FICANAL;
      out_rec.FISUCURSAL := eachRow.FISUCURSAL;
      out_rec.FIFOLIO := eachRow.FIFOLIO;

      CASE pa_opcionQuery
         WHEN CSL_1
         THEN

            BEGIN
             SELECT MAX (ges.FDCREACION)
              INTO out_rec.FDFECHA1
              FROM SCSISGES.TAGESTION ges
             WHERE     ges.FIPAISCU = eachRow.FIPAIS
                   AND ges.FICANALCU =  eachRow.FICANAL
                   AND ges.FISUCURSALCU =  eachRow.FISUCURSAL
                   AND ges.FIFOLIOCU =  eachRow.FIFOLIO;

													IF out_rec.FDFECHA1 IS NULL THEN
                out_rec.FIPAIS := eachRow.FIPAIS;
																out_rec.FICANAL := eachRow.FICANAL;
																out_rec.FISUCURSAL := eachRow.FISUCURSAL;
																out_rec.FIFOLIO := eachRow.FIFOLIO;
																out_rec.FICAMPO1 := CSL_0;
																out_rec.FICAMPO3:= CSL_0; --no gestionado
																out_rec.FICAMPO5 := eachRow.ORDERID;
																out_rec.FDFECHA1 := SYSDATE;
																out_rec.FCCAMPO1 := 'Sin registros de gestion';
													ELSE
																		SELECT ges.FIRESULTGESTIONID
																		INTO out_rec.FICAMPO1
																		FROM SCSISGES.TAGESTION ges
																	WHERE     ges.FIPAISCU = eachRow.FIPAIS
																							AND ges.FICANALCU = eachRow.FICANAL
																							AND ges.FISUCURSALCU = eachRow.FISUCURSAL
																							AND ges.FIFOLIOCU =  eachRow.FIFOLIO
																							AND ges.FDCREACION = out_rec.FDFECHA1
																							AND ROWNUM = CSL_1;

																 SELECT rges.FCRESULTGESTIONDESC,rges.FNDIASENFRIAMIENTO
																		INTO out_rec.FCCAMPO1,
																							out_rec.FICAMPO2
																		FROM SCSISGES.TCRESULTGESTION rges
																	WHERE rges.FIRESULTGESTIONID = out_rec.FICAMPO1;

																			--obtener la diferencia de dias
																			out_rec.FICAMPO4:=TRUNC(SYSDATE)-TRUNC(out_rec.FDFECHA1);
																			IF out_rec.FICAMPO4 <= out_rec.FICAMPO2 THEN
																					out_rec.FICAMPO3:=CSL_1; --lo marcamos como gestionado por que no ha expirado
																			ELSE
																					out_rec.FICAMPO3:=CSL_0;  --lo marcamos como no gestionado por que expiro
																			END IF;

																			out_rec.FICAMPO5 := eachRow.ORDERID; --se utiliza para registro �nico
														END IF;

            EXCEPTION
               WHEN OTHERS
               THEN
                  out_rec.FIPAIS := eachRow.FIPAIS;
                  out_rec.FICANAL := eachRow.FICANAL;
                  out_rec.FISUCURSAL := eachRow.FISUCURSAL;
                  out_rec.FIFOLIO := eachRow.FIFOLIO;
																		out_rec.FICAMPO1 := CSL_0;
                  out_rec.FICAMPO3:= CSL_0; --no gestionado
																		out_rec.FICAMPO5 := eachRow.ORDERID;
																		out_rec.FDFECHA1 := SYSDATE;
																		out_rec.FCCAMPO1 := 'Ocurrio un error al consultar la gestion';
            END;


      END CASE;
      --agregar registro a la colleccion
       PIPE ROW (out_rec);
   END LOOP;

   RETURN;
END FNFXGETCTESGEST;

/

  GRANT EXECUTE ON "SCSISGES"."FNFXGETCTESGEST" TO "USRSISGES";
