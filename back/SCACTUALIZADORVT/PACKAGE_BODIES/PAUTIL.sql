--------------------------------------------------------
--  DDL for Package Body PAUTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAUTIL" AS

    csl_0   CONSTANT INTEGER := 0;
    csl_1   CONSTANT INTEGER := 1;

    PROCEDURE spictrlerrores (
        pa_tipoaplicacion   IN scactualizadorvt.tactrlerrores.fitipoaplicacion%TYPE,
        pa_originoerr       IN scactualizadorvt.tactrlerrores.fcorigino%TYPE,
        pa_numeroerr        IN scactualizadorvt.tactrlerrores.finumero%TYPE,
        pa_mensageerr       IN scactualizadorvt.tactrlerrores.fcmensaje%TYPE,
        pa_causaerr         IN scactualizadorvt.tactrlerrores.fccausa%TYPE
    ) IS

/*******************************************************************************
  Proyecto:     PEDIDOS TIENDA
  Descripci�n:  Inserta errores surgidos en la dispersion de transaciones y del monitoreo
  Par�metros de Entrada:  pa_tipoaplicacion -- Aplicacion que tuvo el error (Web, Transaccion, etc)
                          pa_originoerror   -- Programa donde se Origino el Error
                          paNoError        -- Numero de Error Generado
                          paMsgError       -- Mensaje de Error Generado
                          pa_causaerror     -- Posible Causa del Error
  Par�metros de Salida:
  Valor de Retorno:
  Par�metros de Entrada-Salida:
  PreCondiciones:

  Creador:            Gpe. Hayde� Montiel Moreno
  Fecha de Creaci�n:  28 de Junio del 2017
*******************************************************************************/

        vl_folioconsec   scactualizadorvt.tactrlerrores.ficonsec%TYPE := 0;  -- Folio Consecutivo 
        vl_causaerr      scactualizadorvt.tactrlerrores.fccausa%TYPE := '';  -- Posible Causa del Error 
        vl_sestatus      scactualizadorvt.tactrlerrores.fistatus%TYPE := 0; --  estatus de registro de error de nuevo.
    BEGIN
        SELECT
            nvl(MAX(ficonsec),csl_0)
        INTO vl_folioconsec
        FROM
            scactualizadorvt.tactrlerrores
        WHERE
            fitipoaplicacion = pa_tipoaplicacion;

   -- Si no tiene mensaje de error 

        IF
            nvl(length(pa_causaerr),csl_0) = csl_0
        THEN
            vl_causaerr := 'SIN CAUSA';
        ELSE
            vl_causaerr := pa_causaerr;
        END IF;

        MERGE INTO scactualizadorvt.tactrlerrores ca USING (
            SELECT
                pa_tipoaplicacion tipoapp,
                vl_folioconsec folioconsec,
                pa_numeroerr numeroerr,
                pa_mensageerr mensajeerr,
                pa_causaerr causaerr
            FROM
                dual
        )
        ce ON (
            nvl(ca.fitipoaplicacion,csl_0) = ce.tipoapp
            AND nvl(ca.ficonsec,csl_0) = ce.folioconsec
            AND finumero = ce.numeroerr
            AND fcmensaje = ce.mensajeerr
            AND fccausa = ce.causaerr
            AND fistatus = csl_0
        )
        WHEN MATCHED THEN UPDATE SET ca.fcorigino = pa_originoerr,
        ca.fdfechasurgio = SYSDATE
        WHEN NOT MATCHED THEN INSERT (
            ca.fitipoaplicacion,
            ca.ficonsec,
            ca.fdfechasurgio,
            ca.fcorigino,
            ca.finumero,
            ca.fcmensaje,
            ca.fccausa,
            ca.fistatus ) VALUES (
            pa_tipoaplicacion,
        vl_folioconsec + csl_1,
            SYSDATE,
            pa_originoerr,
            pa_numeroerr,
            pa_mensageerr,
            vl_causaerr,
            vl_sestatus );

        IF
            SQL%rowcount >= csl_1
        THEN
            COMMIT;
        END IF;
    exception when others then
        rollback;
    END spictrlerrores;

END pautil;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAUTIL" TO "USRACTVT";
