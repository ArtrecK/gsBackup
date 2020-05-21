--------------------------------------------------------
--  DDL for Package Body PAACTUALIZADOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAACTUALIZADOR" 
AS
   CSL_N1             CONSTANT INTEGER := -1;
   CSL_0              CONSTANT INTEGER := 0;
   CSL_1              CONSTANT INTEGER := 1;
   CSL_2              CONSTANT INTEGER := 2;
   CSL_3              CONSTANT INTEGER := 3;
   CSL_4              CONSTANT INTEGER := 4;
   CSL_5              CONSTANT INTEGER := 5;
   CSL_6              CONSTANT INTEGER := 6;
   CSL_7              CONSTANT INTEGER := 7;
   CSL_8              CONSTANT INTEGER := 8;
   CSL_9              CONSTANT INTEGER := 9;
   CSL_10             CONSTANT INTEGER := 10;
   CSL_11             CONSTANT INTEGER := 11;
   CSL_12             CONSTANT INTEGER := 12;
   CSL_13             CONSTANT INTEGER := 13;
   CSL_15             CONSTANT INTEGER := 15;
   CSL_16             CONSTANT INTEGER := 16;
   CSL_18             CONSTANT INTEGER := 18;
   CSL_19             CONSTANT INTEGER := 19;
   CSL_20             CONSTANT INTEGER := 20;
   CSL_21             CONSTANT INTEGER := 21;
   CSL_25             CONSTANT INTEGER := 25;
   CSL_26             CONSTANT INTEGER := 26;
   CSL_27             CONSTANT INTEGER := 27;
   CSL_28             CONSTANT INTEGER := 28;
   CSL_29             CONSTANT INTEGER := 29;
   CSL_30             CONSTANT INTEGER := 30;
   CSL_34             CONSTANT INTEGER := 34;
   CSL_35             CONSTANT INTEGER := 35;
   CSL_36             CONSTANT INTEGER := 36;
   CSL_37             CONSTANT INTEGER := 37;
   CSL_39             CONSTANT INTEGER := 39;
   CSL_42             CONSTANT INTEGER := 42;
   CSL_52             CONSTANT INTEGER := 52;
   CSL_53             CONSTANT INTEGER := 53;
   CSL_54             CONSTANT INTEGER := 54;
   CSL_55             CONSTANT INTEGER := 55;
   CSL_56             CONSTANT INTEGER := 56;
   CSL_57             CONSTANT INTEGER := 57;
   CSL_58             CONSTANT INTEGER := 58;
   CSL_59             CONSTANT INTEGER := 59;
   CSL_61             CONSTANT INTEGER := 61;
   CSL_62             CONSTANT INTEGER := 62;
   CSL_63             CONSTANT INTEGER := 63;
   CSL_250            CONSTANT INTEGER := 250;
   CSL_255            CONSTANT INTEGER := 255;
   CSL_3907           CONSTANT INTEGER := 3907;
   CSL_9797           CONSTANT INTEGER := 9797;
   CSL_2000           CONSTANT INTEGER := 2000;
   CSL_OWNER          CONSTANT VARCHAR (100) := 'SCVENTASTINEDA';
   CLS_SP01001_0217   CONSTANT VARCHAR2 (50) := 'SP01001_0217';
   CLS_SP01001_0208   CONSTANT VARCHAR2 (50) := 'SP01001_0208';
   CLS_SP01001_0210   CONSTANT VARCHAR2 (50) := 'SP01001_0210';
   CLS_SP01001_0220   CONSTANT VARCHAR2 (50) := 'SP01001_0220';
   CLS_SP01001_4633   CONSTANT VARCHAR2 (50) := 'SP01001_4633';
   CLS_SP01001_4719   CONSTANT VARCHAR2 (50) := 'SP01001_4719';
   CLS_SP01001_5320   CONSTANT VARCHAR2 (50) := 'SP01001_5320';
   CLS_SP01001_7422   CONSTANT VARCHAR2 (50) := 'SP01001_7422';
   CLS_SP01001_0010   CONSTANT VARCHAR2 (50) := 'SP01001_0010';
   CLS_SP01001_0012   CONSTANT VARCHAR2 (50) := 'SP01001_0012';
   CLS_SP01001_0070   CONSTANT VARCHAR2 (50) := 'SP01001_0070';
   CLS_SP01001_0075   CONSTANT VARCHAR2 (50) := 'SP01001_0075';
   CLS_SP01001_0050   CONSTANT VARCHAR2 (50) := 'SP01001_0050';
   CLS_SP01001_0060   CONSTANT VARCHAR2 (50) := 'SP01001_0060';
   CLS_SP01001_0120   CONSTANT VARCHAR2 (50) := 'SP01001_0120';
   CLS_SP01001_4361   CONSTANT VARCHAR2 (50) := 'SP01001_4361';
   CLS_SP01001_4368   CONSTANT VARCHAR2 (50) := 'SP01001_4368';
   CLS_SP01001_4380   CONSTANT VARCHAR2 (50) := 'SP01001_4380';
   CLS_SP01001_0110   CONSTANT VARCHAR2 (50) := 'SP01001_0110';
   CLS_SP01001_0100   CONSTANT VARCHAR2 (50) := 'SP01001_0100';
   CLS_SP01001_4462   CONSTANT VARCHAR2 (50) := 'SP01001_4462';
   CLS_SP01001_0115   CONSTANT VARCHAR2 (50) := 'SP01001_0115';
   CLS_SP01001_0185   CONSTANT VARCHAR2 (50) := 'SP01001_0185';
   CLS_SP01001_4381   CONSTANT VARCHAR2 (50) := 'SP01001_4381';

   /*************************************************************
   Proyecto: GESTION DE CLIENTES
   Descripci�n: Creacion de paquete para el sistema de procesamiento de transacciones.
   Par�metros de entrada: Ninguno.
   Par�metros de salida: Ninguno.
   Par�metros de entrada-salida: Ninguno.
   Valor de retorno: Resultado de ejecucion de cada l�nea.
   Precondiciones: Se necesita entrar a la base de datos como DBA.
   Creador: Carolina P�rez Vite
   Fecha de creaci�n: Mayo 2018
   *************************************************************/

   vgRowidCtrlsuc              ROWID;

   FUNCTION FNGRABAERROR (
      pa_ErrMsg        SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE,
      pa_OraErr        SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg    SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR_MESG%TYPE,
      pa_ErrId         SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrProceso    SCACTUALIZADORVT.TAERROR_LOG.FCERR_PROCESO%TYPE,
      pa_Rowid         ROWID)
      RETURN VARCHAR2
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base a los parametros graba error en la tabla de SCACTUALIZADORVT.TAERROR_LOG,
                             en caso de no poder hacerlo grabara en la historica.
      Parametros de entrada: pa_ErrMsg        - Mensaje adicional al usuario
                             pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de Oracle
                             pa_ErrId         - Identificador de error
                             pa_ErrProceso    - Proceso en que se genero el error
                             pa_Rowid          - Rowid de error
      Par�metros de salida:  --
      Valores de retorno:    VARCHAR2          - Mensaje de error Oracle
      Llamado por:           Cualquier programa.
      Precondiciones:        Se identifico y asigno el error especifico.
      Notas:                 err_cons - Consecutivo del registro SCACTUALIZADORVT.TAERROR_LOG, se genera automoticamente
      *************************************************************************************************************/
      PRAGMA AUTONOMOUS_TRANSACTION;
      vl_MsgErr     VARCHAR2 (255);
      vl_contador   INTEGER;
   BEGIN
      SELECT COUNT (CSL_1)
        INTO vl_contador
        FROM SCACTUALIZADORVT.TAERROR_LOG
       WHERE ORA_ERR_ROWID = pa_Rowid AND FISTS_ERRSOL = csl_0;

      IF vl_contador = CSL_0
      THEN
         --Registra el error ocurrido durante el procesamiento de transacciones
         INSERT INTO SCACTUALIZADORVT.TAERROR_LOG (FIERR_ID,
                                                   FCERR_MSG,
                                                   FCORA_ERR,
                                                   FCORA_ERR_MESG,
                                                   FCORA_ERR_USR,
                                                   FDERR_FECHA,
                                                   FCORA_DB_NAME,
                                                   FIORA_INSTANCE,
                                                   FCORA_INSTANCE_NAME,
                                                   FCORA_IP_ADDRESS,
                                                   FCERR_PROCESO,
                                                   ORA_ERR_ROWID)
              VALUES (pa_ErrId,
                      pa_ErrMsg,
                      pa_OraErr,
                      pa_OraErrMesg,
                      USER,
                      SYSDATE,
                      SYS_CONTEXT ('USERENV', 'DB_NAME'),
                      SYS_CONTEXT ('USERENV', 'INSTANCE'),
                      SYS_CONTEXT ('USERENV', 'INSTANCE_NAME'),
                      SYS_CONTEXT ('USERENV', 'IP_ADDRESS'),
                      pa_ErrProceso,
                      pa_Rowid);


         COMMIT;
      END IF;

      RETURN vl_MsgErr;
   EXCEPTION
      WHEN OTHERS
      THEN
         BEGIN
            INSERT
              INTO SCACTUALIZADORVT.TAERRORHIST_LOG (FIERR_ID,
                                                     FCERR_MSG,
                                                     FCORA_ERR,
                                                     FCORA_ERR_MESG,
                                                     FCORA_ERR_USR,
                                                     FDERR_FECHA,
                                                     FCORA_DB_NAME,
                                                     FIORA_INSTANCE,
                                                     FCORA_INSTANCE_NAME,
                                                     FCORA_IP_ADDRESS,
                                                     FCERR_PROCESO,
                                                     ORA_ERR_ROWID)
            VALUES (pa_ErrId,
                    pa_ErrMsg,
                    pa_OraErr,
                    pa_OraErrMesg,
                    USER,
                    SYSDATE,
                    SYS_CONTEXT ('USERENV', 'DB_NAME'),
                    SYS_CONTEXT ('USERENV', 'INSTANCE'),
                    SYS_CONTEXT ('USERENV', 'INSTANCE_NAME'),
                    SYS_CONTEXT ('USERENV', 'IP_ADDRESS'),
                    pa_ErrProceso,
                    pa_Rowid);

            COMMIT;
         EXCEPTION
            WHEN OTHERS
            THEN
               vl_MsgErr := SUBSTR (SQLERRM, csl_1, CSL_255);
         END;

         RETURN vl_MsgErr;
   END FNGRABAERROR;

   PROCEDURE SPACTCTRLCONSECTIPTRAN (
      pa_Pais         IN            SCACTUALIZADORVT.TACTRLTIPTRANS.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TACTRLTIPTRANS.FICANAL%TYPE,
      pa_Sucursal     IN            SCACTUALIZADORVT.TACTRLTIPTRANS.FISUCURSAL%TYPE,
      pa_TranTipo     IN            SCACTUALIZADORVT.TACTRLTIPTRANS.FITRANTIPO%TYPE,
      pa_ConsecTipo   IN            SCACTUALIZADORVT.TACTRLTIPTRANS.
                                     FICONSECTIPO%TYPE,
      pa_FecUltDisp   IN            SCACTUALIZADORVT.TACTRLTIPTRANS.
                                     FDFEC_ULT_DISP%TYPE,
      pa_Fitranno     IN            SCACTUALIZADORVT.TACTRLTIPTRANS.FITRANNO%TYPE,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE)
   IS
   /*************************************************************************************************************
   Proyecto:              GESTION DE CLIENTES
   Proposito:             En base a los parametros actualiza la sucursal especificada.
   Parametros de entrada: pa_Pais           - Pais
                          pa_Canal          - Canal
                          pa_Sucursal       - Sucursal
                          pa_TranTipo      - Transaccion tipo
                          pa_ConsecTipo    - Consecutivo tipo
                          pa_FecUltDisp   - Fecha de ultima transaccion procesada.
                          pa_Fitranno       - Numero de ultima transaccion procesada.
   Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                          pa_OraErrMesg  - Mensaje de error Oracle
                          pa_ErrId         - Identificador de error
                          pa_ErrMsg        - Mensaje adicional al usuario
   Llamado por:           SPCTRLDISPERSION
   Llama a:
   Precondiciones:        Se proceso satisfactoriamente una transaccion.
   Notas:                 --
   *************************************************************************************************************/
   BEGIN
      -- actualiza la sucursal con los datos de la ultima transaccion procesada
      MERGE INTO SCACTUALIZADORVT.TACTRLTIPTRANS T
           USING (SELECT pa_Pais pais,
                         pa_Canal canal,
                         pa_Sucursal sucursal,
                         pa_TranTipo tran_tipo
                    FROM DUAL) TSP
              ON (    T.FIPAISID = TSP.pais
                  AND T.FICANAL = TSP.canal
                  AND T.FISUCURSAL = TSP.sucursal
                  AND T.FITRANTIPO = TSP.tran_tipo)
      WHEN MATCHED
      THEN
         UPDATE SET
            T.FITRANNO = pa_Fitranno,
            T.FICONSECTIPO = pa_ConsecTipo,
            T.FDFEC_ULT_DISP = pa_FecUltDisp
      WHEN NOT MATCHED
      THEN
         INSERT     (T.FIPAISID,
                     T.FICANAL,
                     T.FISUCURSAL,
                     T.FITRANNO,
                     T.FITRANTIPO,
                     T.FICONSECTIPO,
                     T.FDFEC_ULT_DISP)
             VALUES (pa_Pais,
                     pa_Canal,
                     pa_Sucursal,
                     pa_Fitranno,
                     pa_TranTipo,
                     pa_ConsecTipo,
                     pa_FecUltDisp);

      IF SQL%ROWCOUNT > CSL_1
      THEN
         ROLLBACK;
         pa_ErrId := CSL_3;
         pa_ErrMsg :=
            'Error en consecutivo de tipo de transacci�n (operaci�n MERGE en la tabla SCACTUALIZADORVT.TACTRLTIPTRANS) con los valores - Consecutivo: '
            || pa_ConsecTipo
            || ' Tipo de transacci�n: '
            || pa_TranTipo
            || ' Pa�s: '
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Sucursal: '
            || pa_Sucursal
            || ' N�mero Transacci�n: '
            || pa_Fitranno;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_ErrId := CSL_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en consecutivo de tipo de transacci�n bloque de excepciones WHEN OTHERS de sp SPACTCTRLCONSECTIPTRAN con lo valores - Consecutivo '
            || pa_ConsecTipo
            || ' Tipo de transacci�n: '
            || pa_TranTipo
            || ' Pa�s: '
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Sucursal: '
            || pa_Sucursal
            || ' N�mero Transacci�n: '
            || pa_Fitranno;
   END SPACTCTRLCONSECTIPTRAN;


   PROCEDURE SPACTUALIZACTRLSUCERROR (
      pa_RowidCtrlsuc   IN            ROWID,
      pa_TranNum        IN            SCACTUALIZADORVT.TATRNCRCB.FITRANNO%TYPE,
      pa_ErrProceso     IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                       FCERR_PROCESO%TYPE,
      pa_OraErr         IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg     IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                       FCORA_ERR_MESG%TYPE,
      pa_ErrId          IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_Rowid          IN OUT NOCOPY ROWID)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Se manda a error a la sucursal con los datos especificados.
      Parametros de entrada: pa_RowidCtrlsuc  - Rowid de ctrlsuc en proceso
                             pa_TranNum       - Numero de transacci�n
                          -- pa_ErrMsg        - Descripci�n del error
                             pa_ErrProceso    - Fase en que sucedio el error
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de Oracle
                             paFIERR_ID          - Identificador de error
                             pa_Rowid          - Rowid del Cab/Det que genero el error
      Llamado por:           Cualquier programa.
      Precondiciones:        Se identifico y asigno el error especifico.
      Notas:                 --
      *************************************************************************************************************/
      PRAGMA AUTONOMOUS_TRANSACTION;
      vl_NumReg    PLS_INTEGER := csl_0;
      vl_ErrProc   SCACTUALIZADORVT.TAERROR_LOG.FCERR_PROCESO%TYPE := 'CTRL';
   BEGIN
      --Actualiza el control de sucursales (por error en el procesamiento de transacciones)
      UPDATE SCACTUALIZADORVT.TACTRLSUC
         SET FISTATADN = CSL_0,
             FITRANNO = pa_TranNum,
             ORA_ERR_ROWID = pa_Rowid
       WHERE ROWID = pa_RowidCtrlsuc;

      vl_NumReg := SQL%ROWCOUNT;

      IF vl_NumReg > csl_1                               -- Sucursal duplicada
      THEN
         ROLLBACK;
         pa_ErrProceso := vl_ErrProc;
         pa_ErrId := CSL_7;
      ELSIF vl_NumReg = csl_0                        -- Sucursal no registrada
      THEN
         ROLLBACK;
         pa_ErrProceso := vl_ErrProc;
         pa_ErrId := CSL_21;
      ELSE
         COMMIT;
      END IF;                                                 -- vl_NumReg > 1
   EXCEPTION
      WHEN SYS_INVALID_ROWID
      THEN
         pa_ErrId := CSL_52;
         pa_ErrProceso := vl_ErrProc;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN OTHERS
      THEN
         pa_ErrId := CSL_0;
         pa_ErrProceso := vl_ErrProc;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPACTUALIZACTRLSUCERROR;


   PROCEDURE SPACTUALIZACTRLSUCTRAN (
      pa_Pais         IN            SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      pa_Sucursal     IN            SCACTUALIZADORVT.TACTRLSUC.FISUCURSAL%TYPE,
      pa_FecUltTran   IN            SCACTUALIZADORVT.TACTRLSUC.FDULTTRANS%TYPE,
      pa_UltTransac   IN            SCACTUALIZADORVT.TACTRLSUC.FIULTTRANS%TYPE,
      pa_ErrProceso   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCERR_PROCESO%TYPE,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base a los parametros actualiza la sucursal especificada.
      Parametros de entrada: pa_Pais           - Pais
                             pa_Canal          - Canal
                             pa_Sucursal       - Sucursal
                             pa_FecUltTran   - Fecha de ultima transaccion procesada.
                             pa_UltTransac    - Numero de ultima transaccion procesada.
                             pa_ErrProceso    - Fase en que sucedio el error
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
                             pa_ErrMsg        - Mensaje adicional al usuario
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        Se proceso satisfactoriamente una transaccion.
      Notas:                 --
      *************************************************************************************************************/
      vl_NumReg    PLS_INTEGER := CSL_0;
      vl_ErrProc   SCACTUALIZADORVT.TAERROR_LOG.FCERR_PROCESO%TYPE := 'CTRL';
   BEGIN
      --Actualiza la sucursal con los datos de la ultima transaccion procesada
      UPDATE SCACTUALIZADORVT.TACTRLSUC
         SET FIULTTRANS = pa_UltTransac,
             FDULTTRANS = pa_FecUltTran,
             FDULTACTCEN = SYSDATE
       WHERE     FIPAISID = pa_Pais
             AND FICANAL = pa_Canal
             AND FISUCURSAL = pa_Sucursal;

      vl_NumReg := SQL%ROWCOUNT;

      IF vl_NumReg = csl_0
      THEN
         pa_ErrId := CSL_21;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al actualizar consecutivos de sucursal en la tabla CTRLSUC, no se encontr� el registro con los valores - '
            || ' Pa�s: '
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Sucursal: '
            || pa_Sucursal
            || ' N�mero Transacci�n: '
            || pa_UltTransac;
      ELSIF vl_NumReg > csl_1
      THEN
         pa_ErrProceso := vl_ErrProc;
         pa_ErrId := CSL_7;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al actualizar consecutivos de sucursal en la tabla CTRLSUC, se encontraron m�s de un registro con los valores - '
            || ' Pa�s: '
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Sucursal: '
            || pa_Sucursal
            || ' N�mero Transacci�n: '
            || pa_UltTransac;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_ErrProceso := vl_ErrProc;
         pa_ErrId := CSL_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPACTUALIZACTRLSUCTRAN;


   PROCEDURE SPALTASUCURSAL (
      pa_Pais         IN            SCACTUALIZADORVT.TACTRLSUC.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TACTRLSUC.FICANAL%TYPE,
      pa_Sucursal     IN            SCACTUALIZADORVT.TACTRLSUC.FISUCURSAL%TYPE,
      pa_TranNum      IN            SCACTUALIZADORVT.TACTRLSUC.FIULTTRANS%TYPE,
      pa_EstSuc       IN            SCACTUALIZADORVT.TACTRLSUC.FISTATADN%TYPE,
      pa_EstTda       IN            SCACTUALIZADORVT.TACTRLSUC.FISTATUSTDA%TYPE,
      pa_Rowid                      ROWID,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base a los parametros de Pais, Canal, Sucursal, Numero de transaccion y
                             fecha de la transaccion, almacena la nueva sucursal.
      Parametros de entrada: pa_Pais           - Pais
                             pa_Canal          - Canal
                             pa_Sucursal       - Sucursal
                             pa_TranNum       - Numero de Transaccion
                             pa_EstSuc        - Estatus de la sucursal
                             pa_EstTda        - Estatus de la tienda
                             pa_Rowid          - ROWID del registro en TRANCRECAB
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
      Valores de retorno:    --
      Llamado por:           SP_ESTATUS_SUCURSAL
      Llama a:               DBMS_UTILITY.format_error_backtrace.
      Precondiciones:        Se procesan las actualiza el catalogo de sucursales insertando la nueva.
      Notas:                 --
      *************************************************************************************************************/
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      -- La registra nueva sucursal como activa
      INSERT INTO SCACTUALIZADORVT.TACTRLSUC (FIPAISID,
                                              FICANAL,
                                              FISUCURSAL,
                                              FISTATADN,
                                              FISTATUSTDA,
                                              FIULTTRANS,
                                              FDULTTRANS,
                                              FDULTACTCEN,
                                              FCTIPOERR,
                                              FCDESCERR,
                                              ORA_ERR_ROWID,
                                              FITRANNO,
                                              FISTSCBAN,
                                              FDFECCBAN)
           VALUES (pa_Pais,
                   pa_Canal,
                   pa_Sucursal,
                   pa_EstSuc,
                   pa_EstTda,
                   (pa_TranNum - csl_1),
                   SYSDATE,
                   SYSDATE,
                   '',
                   '',
                   pa_Rowid,
                   CSL_0,
                   csl_0,
                   TO_DATE ('1901-01-01-00.00.00', 'YYYY-MM-DD HH24:MI:SS'));

      COMMIT;
   EXCEPTION
      WHEN INVALID_NUMBER
      THEN
         ROLLBACK;
         pa_ErrId := csl_6;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN DUP_VAL_ON_INDEX
      THEN
         ROLLBACK;
         pa_ErrId := csl_5;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN SYS_INVALID_ROWID
      THEN
         ROLLBACK;
         pa_ErrId := csl_52;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPALTASUCURSAL;


   PROCEDURE SPESTATUSSUCURSAL (
      pa_Pais         IN            SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      pa_Sucursal     IN            SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      pa_TransNum     IN            SCACTUALIZADORVT.TATRNCRCB.FITRANNO%TYPE,
      pa_EstSuc       IN OUT        SCACTUALIZADORVT.TACTRLSUC.FISTATADN%TYPE,
      pa_UltProc      IN OUT        SCACTUALIZADORVT.TACTRLSUC.FIULTTRANS%TYPE,
      pa_Rowid                      ROWID,
      pa_AltaSuc      IN OUT        NUMBER,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base a los parametros de Pais, Canal, Sucursal, Numero de transaccion,
                             fecha de la ultima transaccion procesada correctamente status de la tienda,
                             Numero de ultima transaccion procesada correctamente, y datos de banco,
                             almacena la nueva sucursal (en caso de no estar registrada).
      Parametros de entrada: pa_Pais           - Pais
                             pa_Canal          - Canal
                             pa_Sucursal       - Sucursal
                             pa_TransNum      - Numero de Transaccion
                             pi_status_suc     - Estatus de la Sucursal
                             pa_UltProc       - Numero de la ultima transaccion procesada
                             pa_Rowid          - ROWID del registro en TRANCRECAB
                             pa_AltaSuc       - Indica si se dio de alta la sucursal
                          -- pafdulttrans      - Fecha de la ultima transaccion procesada
                          -- pafistscban       - Datos de BANCO
                          -- pafdfeccban       - Datos de BANCO
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg: - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
                             pa_ErrMsg        - Mensaje adicional al usuario
      Valores de retorno:    --
      Llamado por:           SPACTUALIZADORCABECEROS
      Llama a:
      Precondiciones:        Se procesan las actualiza el catalogo de sucursales insertando la nueva.
      Notas:                 --
      *************************************************************************************************************/
      vl_EstTda   SCACTUALIZADORVT.TACTRLSUC.FISTATUSTDA%TYPE;
   BEGIN
      --Selecciona datos de sucursal para verificar que realmente no exista
      SELECT FISTATADN,
             FIULTTRANS,
             FISTATUSTDA,
             ROWID
        INTO pa_EstSuc,
             pa_UltProc,
             vl_EstTda,
             vgRowidCtrlsuc
        FROM SCACTUALIZADORVT.TACTRLSUC
       WHERE     FIPAISID = pa_Pais
             AND FICANAL = pa_Canal
             AND FISUCURSAL = pa_Sucursal;

      -- Valida estatus de tienda
      IF (pa_EstSuc = csl_1) AND (vl_EstTda != csl_1)
      THEN
         pa_EstSuc := csl_0;
         pa_ErrId := csl_9;
         pa_ErrMsg := vl_EstTda;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         -- Si no encontro la sucursal, la registra como activa
         BEGIN
            pa_EstSuc := csl_1;
            vl_EstTda := csl_1;
            pa_AltaSuc := csl_1;
            SCACTUALIZADORVT.PAACTUALIZADOR.SPALTASUCURSAL (pa_Pais,
                                                            pa_Canal,
                                                            pa_Sucursal,
                                                            pa_TransNum,
                                                            pa_EstSuc,
                                                            vl_EstTda,
                                                            pa_Rowid,
                                                            pa_OraErr,
                                                            pa_OraErrMesg,
                                                            pa_ErrId);
         EXCEPTION
            WHEN OTHERS
            THEN
               pa_ErrId := csl_8;
               pa_OraErr := SQLCODE;
               pa_OraErrMesg := SQLERRM;
         END;
      WHEN TOO_MANY_ROWS
      THEN
         pa_ErrId := csl_3;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPESTATUSSUCURSAL;


   PROCEDURE SPGRABAERRCAB (
      pa_Rowid                      ROWID,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Graba en TRANCRECABERR el reg. con error para poder analizarlo
      Parametros de entrada: pa_Rowid - ROWID del reg. erroneo.
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
                             pa_ErrMsg        - Mensaje adicional al usuario
      Llamado por:           SPCTRLDISPERSION
      Precondiciones:        Se identifico el registro que genera el error.
      Notas:                 --
      *************************************************************************************************************/
      PRAGMA AUTONOMOUS_TRANSACTION;
      vl_NumReg       PLS_INTEGER := csl_0;
      vl_contador     INTEGER;
      vl_FIPAISID     SCACTUALIZADORVT.TATRNCRCBE.FIPAISID%TYPE;
      vl_FICANAL      SCACTUALIZADORVT.TATRNCRCBE.FICANAL%TYPE;
      vl_FISUCURSAL   SCACTUALIZADORVT.TATRNCRCBE.FISUCURSAL%TYPE;
      vl_FITRANNO     SCACTUALIZADORVT.TATRNCRCBE.FITRANNO%TYPE;
   BEGIN
      SELECT FIPAISID,
             FICANAL,
             FISUCURSAL,
             FITRANNO
        INTO vl_FIPAISID,
             vl_FICANAL,
             vl_FISUCURSAL,
             vl_FITRANNO
        FROM SCACTUALIZADORVT.TATRNCRCB
       WHERE ROWID = pa_Rowid;

      SELECT COUNT (csl_1)
        INTO vl_contador
        FROM SCACTUALIZADORVT.TATRNCRCBE
       WHERE     FIPAISID = vl_FIPAISID
             AND FICANAL = vl_FICANAL
             AND FISUCURSAL = vl_FISUCURSAL
             AND FITRANNO = vl_FITRANNO;

      IF vl_contador = csl_0
      THEN
         --Graba cabecero con error
         INSERT INTO SCACTUALIZADORVT.TATRNCRCBE (FIPAISID,
                                                  FICANAL,
                                                  FISUCURSAL,
                                                  FITRANNO,
                                                  FITRANTIPO,
                                                  FICONSECTIPO,
                                                  FDTRANSFECHR,
                                                  FCTRANWS,
                                                  FCTRANUSR,
                                                  FITRANNOREG,
                                                  FITRANSMIT,
                                                  ORA_ERR_ROWID,
                                                  FDFECHARECEP)
            SELECT FIPAISID,
                   FICANAL,
                   FISUCURSAL,
                   FITRANNO,
                   FITRANTIPO,
                   FICONSECTIPO,
                   FDTRANSFECHR,
                   FCTRANWS,
                   FCTRANUSR,
                   FITRANNOREG,
                   FITRANSMIT,
                   pa_Rowid,
                   FDFECHARECEP
              FROM SCACTUALIZADORVT.TATRNCRCB
             WHERE ROWID = pa_Rowid;

         vl_NumReg := SQL%ROWCOUNT;

         IF vl_NumReg = csl_0
         THEN
            ROLLBACK;
            pa_ErrId := csl_27;
            pa_ErrMsg :=
               'Error al grabar el cabecero que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRCBE a partir de select en SCACTUALIZADORVT.TATRNCRCB, no existe el registro a buscar con los siguientes datos - ROWID:'
               || pa_Rowid;
         ELSE
            COMMIT;
         END IF;                                              -- vl_NumReg = 0
      END IF;
   EXCEPTION
      WHEN SYS_INVALID_ROWID
      THEN
         ROLLBACK;
         pa_ErrId := csl_61;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al grabar el cabecero que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRCBE a partir de select en SCACTUALIZADORVT.TATRNCRCB, los siguientes datos de b�squeda no son v�lidos - ROWID:'
            || pa_Rowid;
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_ErrId := csl_27;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al grabar el cabecero que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRCBE a partir de select en SCACTUALIZADORVT.TATRNCRCB, bloque de excepciones WHEN OTHERS con los datos de b�squeda - ROWID:'
            || pa_Rowid;
   END SPGRABAERRCAB;


   PROCEDURE SPGRABAERRDET (
      pa_Rowid                      ROWID,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Graba en TRANCREDETERR el reg. con error para poder analizarlo
      Parametros de entrada: pa_Rowid          - ROWID del reg. erroneo.
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
                             pa_ErrMsg        - Mensaje adicional al usuario
      Llamado por:           SPDISPERSADETALLES
      Precondiciones:        Se identifico el registro que genera el error.
      Notas:                 --
      *************************************************************************************************************/
      PRAGMA AUTONOMOUS_TRANSACTION;
      vl_NumReg       PLS_INTEGER := csl_0;
      vl_contador     INTEGER;
      vl_FIPAISID     SCACTUALIZADORVT.TATRNCRDTE.FIPAISID%TYPE;
      vl_FICANAL      SCACTUALIZADORVT.TATRNCRDTE.FICANAL%TYPE;
      vl_FISUCURSAL   SCACTUALIZADORVT.TATRNCRDTE.FISUCURSAL%TYPE;
      vl_FITRANNO     SCACTUALIZADORVT.TATRNCRDTE.FITRANNO%TYPE;
      vl_FICONSDETA   SCACTUALIZADORVT.TATRNCRDTE.FICONSDETA%TYPE;
   BEGIN
      SELECT FIPAISID,
             FICANAL,
             FISUCURSAL,
             FITRANNO,
             FICONSDETA
        INTO vl_FIPAISID,
             vl_FICANAL,
             vl_FISUCURSAL,
             vl_FITRANNO,
             vl_FICONSDETA
        FROM SCACTUALIZADORVT.TATRNCRDT
       WHERE ROWID = pa_Rowid;

      SELECT COUNT (csl_1)
        INTO vl_contador
        FROM SCACTUALIZADORVT.TATRNCRDTE
       WHERE     FIPAISID = vl_FIPAISID
             AND FICANAL = vl_FICANAL
             AND FISUCURSAL = vl_FISUCURSAL
             AND FITRANNO = vl_FITRANNO
             AND FICONSDETA = vl_FICONSDETA;

      IF vl_contador = csl_0
      THEN
         --Graba Detalle con error
         INSERT INTO SCACTUALIZADORVT.TATRNCRDTE (FIPAISID,
                                                  FICANAL,
                                                  FISUCURSAL,
                                                  FITRANNO,
                                                  FICONSDETA,
                                                  FITIPOREG,
                                                  FCDATODETA,
                                                  ORA_ERR_ROWID)
            SELECT FIPAISID,
                   FICANAL,
                   FISUCURSAL,
                   FITRANNO,
                   FICONSDETA,
                   FITIPOREG,
                   FCDATODETA,
                   pa_Rowid
              FROM SCACTUALIZADORVT.TATRNCRDT
             WHERE ROWID = pa_Rowid;

         vl_NumReg := SQL%ROWCOUNT;

         IF vl_NumReg = csl_0
         THEN
            ROLLBACK;
            pa_ErrId := csl_25;
            pa_ErrMsg :=
               'Error al grabar el detalle que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRDTE a partir de select en SCACTUALIZADORVT.TATRNCRDT, no existe el registro a buscar con los siguientes datos - ROWID: '
               || pa_Rowid;
         ELSE
            COMMIT;
         END IF;                                              -- vl_NumReg > 1
      END IF;
   EXCEPTION
      WHEN SYS_INVALID_ROWID
      THEN
         ROLLBACK;
         pa_ErrId := csl_61;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al grabar el detalle que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRDTE a partir de select en SCACTUALIZADORVT.TATRNCRDT, los siguientes datos de b�squeda no son v�lidos - ROWID: '
            || pa_Rowid;
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_ErrId := csl_25;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error al grabar el detalle que origin� la excepci�n en la tabla SCACTUALIZADORVT.TATRNCRDTE a partir de select en SCACTUALIZADORVT.TATRNCRDT, bloque de excepciones WHEN OTHERS con los datos de b�squeda - ROWID:'
            || pa_Rowid;
   END SPGRABAERRDET;


   PROCEDURE SPHISTORICOCABECERO (
      pa_recTrancrecab   IN            SCACTUALIZADORVT.TATRNCRCB%ROWTYPE,
      pa_Rowid                         ROWID,
      pa_ErrProceso      IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                        FCERR_PROCESO%TYPE,
      pa_OraErr          IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg      IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                        FCORA_ERR_MESG%TYPE,
      pa_ErrId           IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg          IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE,
      pa_notif_conting   IN OUT        VARCHAR)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Genera el historico de transaccions para el cabecero.
      Par�metros de entrada: pa_recTrancrecab Datos del cabecero.
                             paFecha_transac  Fecha de la transaccion
      Par�metros de salida:  pa_ErrCod        C�digo de error
                             pa_ErrMsg        Mensaje de error
                             pa_ErrId         - Identificador de error
      Valor de retorno:
      Precondiciones:        Termino correctamente la dispercion de datos de la transaccion
      *************************************************************************************************************/
      vl_MsgError     SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE;
      vl_MenErrorFn   VARCHAR2 (250);
   BEGIN
      --Pasa Cabecero al historico
      INSERT INTO SCACTUALIZADORVT.TATRNCRCBH (FIPAISID,
                                               FICANAL,
                                               FISUCURSAL,
                                               FITRANNO,
                                               FITRANTIPO,
                                               FICONSECTIPO,
                                               FDTRANSFECHR,
                                               FCTRANWS,
                                               FCTRANUSR,
                                               FITRANNOREG,
                                               FITRANSMIT,
                                               FDFECHARECEP)
           VALUES (pa_recTrancrecab.FIPAISID,
                   pa_recTrancrecab.FICANAL,
                   pa_recTrancrecab.FISUCURSAL,
                   pa_recTrancrecab.FITRANNO,
                   pa_recTrancrecab.FITRANTIPO,
                   pa_recTrancrecab.FICONSECTIPO,
                   pa_recTrancrecab.FDTRANSFECHR,
                   pa_recTrancrecab.FCTRANWS,
                   pa_recTrancrecab.FCTRANUSR,
                   pa_recTrancrecab.FITRANNOREG,
                   pa_recTrancrecab.FITRANSMIT,
                   pa_recTrancrecab.FDFECHARECEP)
              LOG ERRORS INTO SCACTUALIZADORVT.TATRNCRCBHL
                     ('Error al Respaldar en Hist�rico (TRANCRECABHIST):  '
                      || TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS'))
                     REJECT LIMIT UNLIMITED;

      IF SQL%ROWCOUNT = csl_0
      THEN
         vl_MsgError :=
            'Aviso - Se graba el cabecero que no se pudo pasar al historico en la tabla SCACTUALIZADORVT.TATRNCRCBH, se va a guardar el registro en la tabla TRANCRECABHIST_LOG con los siguientes valores - '
            || ' Pa�s: '
            || pa_recTrancrecab.fipaisid
            || ' Canal: '
            || pa_recTrancrecab.ficanal
            || ' Sucursal: '
            || pa_recTrancrecab.fisucursal
            || ' N�mero Transacci�n: '
            || pa_recTrancrecab.fitranno;
         vl_MenErrorFn :=
            SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (vl_MsgError,
                                                          pa_OraErr,
                                                          pa_OraErrMesg,
                                                          csl_26   -- FIERR_ID
                                                                ,
                                                          pa_ErrProceso,
                                                          pa_Rowid);
      END IF;                                                 -- vl_NumReg = 0
   EXCEPTION
      WHEN INVALID_NUMBER
      THEN
         pa_ErrId := csl_6;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en el proceso de guardar en el hist�rico las transacciones, tabla TRANCRECABHIST (n�mero inv�lido) con los siguientes valores - '
            || 'Pa�s: '
            || pa_recTrancrecab.fipaisid
            || ' Canal: '
            || pa_recTrancrecab.ficanal
            || ' Sucursal: '
            || pa_recTrancrecab.fisucursal
            || ' Numero Transacci�n: '
            || pa_recTrancrecab.fitranno;
      WHEN DUP_VAL_ON_INDEX
      THEN
         pa_ErrId := csl_5;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en el proceso de guardar en el hist�rico las transacciones, tabla TRANCRECABHIST (error de llave primaria) con los siguientes valores - '
            || 'Pa�s: '
            || pa_recTrancrecab.fipaisid
            || ' Canal: '
            || pa_recTrancrecab.ficanal
            || ' Sucursal: '
            || pa_recTrancrecab.fisucursal
            || ' Numero Transacci�n: '
            || pa_recTrancrecab.fitranno;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en el proceso de guardar en el hist�rico las transacciones, tabla TRANCRECABHIST (Bloque de excepciones WHEN OTHERS) con los siguientes valores - '
            || 'Pa�s: '
            || pa_recTrancrecab.fipaisid
            || ' Canal: '
            || pa_recTrancrecab.ficanal
            || ' Sucursal: '
            || pa_recTrancrecab.fisucursal
            || ' Numero Transacci�n: '
            || pa_recTrancrecab.fitranno;
   END SPHISTORICOCABECERO;

   PROCEDURE SPVALIDACONSECTIPTRAN (
      pa_Pais         IN            SCACTUALIZADORVT.TATRNCRDT.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TATRNCRDT.FICANAL%TYPE,
      pa_Sucursal     IN            SCACTUALIZADORVT.TATRNCRDT.FISUCURSAL%TYPE,
      pa_TranTipo     IN OUT        SCACTUALIZADORVT.TATRNCRCB.FITRANTIPO%TYPE,
      pa_ConsecTipo   IN OUT        SCACTUALIZADORVT.TATRNCRCB.FICONSECTIPO%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_ErrMsg       IN OUT        SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Descripci�n:           En base a los parametros de Pais, Canal y Tipo de registro
                             Valida consecutivo del tipo de transaccion
      Par�metros de entrada:
                             pa_Pais           - Pais
                             pa_Canal          - Canal
                             pa_Sucursal       - Sucursal
                             pa_TranTipo      - Tipo de transaccion
                             pa_ConsecTipo    - Consecutivo tipo
      Par�metros de salida:  pa_OraErrMesg  - Mensaje de error Oracle
                             pa_OraErr       - C�digo de error Oracle
                             pa_ErrMsg        - Mensaje de error adicional
                             pa_ErrId         - Identificador de error
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        Se debe validar el consecutivo de transaccion de la Sucursal.
      *************************************************************************************************************/
      vl_NumConcec          PLS_INTEGER := csl_0;
      exc_ErrorValidacion   EXCEPTION;

      --Cursor para obtener el consecutivo del tipo de transacccion
      CURSOR cur_CtrlConTiptran
      IS
         SELECT FICONSECTIPO
           FROM SCACTUALIZADORVT.TACTRLTIPTRANS
          WHERE     FIPAISID = pa_Pais
                AND FICANAL = pa_Canal
                AND FISUCURSAL = pa_Sucursal
                AND FITRANTIPO = pa_TranTipo;
   BEGIN
      -- Valida consecutivo de tipo de transacci�n
      FOR rec_CtrlConTiptran IN cur_CtrlConTiptran
      LOOP
         vl_NumConcec := rec_CtrlConTiptran.ficonsectipo;
      END LOOP;

      IF vl_NumConcec > csl_0
      THEN
         IF (vl_NumConcec <> (pa_ConsecTipo - csl_1)) --forzosamente tiene que ser el siguiente
         THEN
            pa_ErrId := csl_12;
            pa_ErrMsg :=
               'Error en validaci�n de consecutividad en tipo de transacci�n con los valores -  '
               || 'Pa�s: '
               || pa_Pais
               || ' Canal: '
               || pa_Canal
               || ' Sucursal: '
               || pa_Sucursal
               || ' Tipo de transacci�n: '
               || pa_TranTipo
               || ' Consecutivo de tipo de transacci�n: '
               || pa_ConsecTipo
               || ' �ltimo validado: '
               || vl_NumConcec;
            RAISE exc_ErrorValidacion;
         END IF;
      END IF;
   EXCEPTION
      WHEN exc_ErrorValidacion
      THEN
         RETURN;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPVALIDACONSECTIPTRAN;


   PROCEDURE SPVALIDAREGISTRO (
      pa_Pais         IN            SCACTUALIZADORVT.TATRNCRDT.FIPAISID%TYPE,
      pa_Canal        IN            SCACTUALIZADORVT.TATRNCRDT.FICANAL%TYPE,
      pa_TipoReg      IN            SCACTUALIZADORVT.TATRNCRDT.FITIPOREG%TYPE,
      pa_RegAccion    IN OUT        SCACTUALIZADORVT.TAREGISTRO.FIREG_ACCION%TYPE,
      pa_SpName       IN OUT        SCACTUALIZADORVT.TAREGISTRO.FCREG_SP_NAME%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_ErrMsg       IN OUT        SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Descripci�n:           En base a los parametros de Pais, Canal y Tipo de registro
                             valida que exista Tip_reg y devuelve estatus
      Par�metros de entrada:
                             pa_Pais           - Pais
                             pa_Canal          - Canal
                             pa_TipoReg       - Tipo de registro
      Par�metros de salida:  pa_RegAccion     - Accion a realizar
                             pa_SpName        - Nombre del SP que ejecuta
                             pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        Se debe validar el consecutivo de detalle de transacciones y
                             obtener los distintos tipos de registro.
      *************************************************************************************************************/
      vl_RegEstatus         SCACTUALIZADORVT.TAREGISTRO.FIREG_ESTATUS%TYPE;
      exc_ErrorValidacion   EXCEPTION;
      vl_ExisteReg          CHAR (1) := 'N';

      --Cursor para obtener el estatus y accion del registro.
      CURSOR cur_Registro
      IS
         SELECT FIREG_ESTATUS, FIREG_ACCION, FCREG_SP_NAME
           FROM SCACTUALIZADORVT.TAREGISTRO
          WHERE     FIPAISID = pa_Pais
                AND FICANAL = pa_Canal
                AND FITIPOREG = pa_TipoReg;
   BEGIN
      FOR rec_Registro IN cur_Registro
      LOOP
         vl_ExisteReg := 'S';
         vl_RegEstatus := rec_Registro.FIREG_ESTATUS;
         pa_RegAccion := rec_Registro.FIREG_ACCION;
         pa_SpName := TRIM (rec_Registro.FCREG_SP_NAME);
      END LOOP;

      IF vl_ExisteReg = 'N'
      THEN
         pa_ErrId := csl_15;
         pa_ErrMsg :=
            'Error en validaci�n del tipo de registro, no existe el tipo de registro en la tabla SCACTUALIZADORVT.TAREGISTRO, registro validado con los valores - Pa�s:'
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Tipo de registro: '
            || pa_TipoReg;
      ELSIF vl_RegEstatus = csl_0                      -- Registro 0) Inactivo
      THEN
         pa_ErrId := csl_16;
         pa_ErrMsg :=
            'Error en validaci�n del tipo de registro, el tipo de registro esta inactivo en la tabla SCACTUALIZADORVT.TAREGISTRO, registro validado con los valores - Pa�s:'
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Tipo de registro: '
            || pa_TipoReg
            || ' Estatus: '
            || vl_RegEstatus;
         RAISE exc_ErrorValidacion;
      -- Solo Procesa las sig. acciones:
      -- 1-Procesa.
      -- 2-Procesa y pasa estructura.
      -- 3-Pasa estructura.
      -- 4-Ignorar.
      ELSIF pa_RegAccion > csl_4
      THEN
         pa_ErrId := csl_29;
         pa_ErrMsg :=
            'Error en validaci�n del tipo de registro, el valor para la acci�n a realizar del registro esta fuera de rango (valor mayor a 4; valores permitidos del 1 al 4), registro validado con los valores - Pa�s:'
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Tipo de registro: '
            || pa_TipoReg
            || ' Estatus: '
            || vl_RegEstatus
            || ' Acci�n: '
            || pa_RegAccion;
         RAISE exc_ErrorValidacion;
      ELSIF pa_RegAccion < 1
      THEN
         pa_ErrId := csl_29;
         pa_ErrMsg :=
            'Error en validaci�n del tipo de registro, el valor para la acci�n a realizar del registro esta fuera de rango (valor menor a 1; valores permitidos del 1 al 4), registro validado con los valores - Pa�s:'
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Tipo de registro: '
            || pa_TipoReg
            || ' Estatus: '
            || vl_RegEstatus
            || ' Acci�n: '
            || pa_RegAccion;
         RAISE exc_ErrorValidacion;
      END IF;                                  -- vl_RegEstatus y pa_RegAccion
   EXCEPTION
      WHEN exc_ErrorValidacion
      THEN
         RETURN;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en validaci�n del tipo de registro, bloque de excepciones WHEN OTHERS; registro validado con los valores - Pa�s:'
            || pa_Pais
            || ' Canal: '
            || pa_Canal
            || ' Tipo de registro: '
            || pa_TipoReg
            || ' Estatus: '
            || vl_RegEstatus
            || ' Acci�n: '
            || pa_RegAccion;
   END SPVALIDAREGISTRO;


   PROCEDURE SPVALIDATRANTIPO (
      pa_TranTipo     IN            SCACTUALIZADORVT.TATRNCRCB.FITRANTIPO%TYPE,
      pa_OraErr       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_OraErrMesg   IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                     FCORA_ERR_MESG%TYPE,
      pa_ErrId        IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base al parametro Tipo de Transacci�n valida que exista y este activo
      Parametros de entrada: pa_TranTipo      - Tipo de Transacci�n
      Par�metros de salida:  pa_OraErr       - C�digo de error Oracle
                             pa_OraErrMesg  - Mensaje de error Oracle
                             pa_ErrId         - Identificador de error
      Valores de retorno:    NULL si la transacci�n es valida
      Llamado por:           SPACTUALIZADORCABECEROS
      Precondiciones:        --
      Notas:                 --
      *************************************************************************************************************/
      vl_TranEstatus   SCACTUALIZADORVT.TACATTRANSACCION.FITRAN_ESTATUS%TYPE;
   BEGIN
      SELECT FITRAN_ESTATUS
        INTO vl_TranEstatus
        FROM SCACTUALIZADORVT.TACATTRANSACCION
       WHERE FITRANTIPO = pa_TranTipo;

      IF vl_TranEstatus = csl_0
      THEN
         pa_ErrId := csl_2;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         pa_ErrId := csl_1;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN TOO_MANY_ROWS
      THEN
         pa_ErrId := csl_3;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
   END SPVALIDATRANTIPO;


   FUNCTION FNOBTENERFORMATONUMERO (pa_Valor        VARCHAR2,
                                    pa_LongCampo    PLS_INTEGER,
                                    pa_NumDec       PLS_INTEGER)
      RETURN VARCHAR2
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Funcion utilizada para checar que el tipo de dato numerico en el dato del detalle,
                             en realidad sea un n�mero.
      Parametros de entrada: pa_Valor       - cadena a comprobar
                             pa_LongCampo  - longitud del campo
                             pa_NumDec     - no de decimales
      Valor de retorno:      Devuelve un tipo de VARCHAR2.
      Llamado por:           FN_OBTENER_SQL
      Notas:
      *************************************************************************************************************/
      vl_Formato      VARCHAR2 (30) := NULL; -- Para almacenar el formato a utilizar (mascara).
      vl_Inicio       PLS_INTEGER := csl_1; -- Para el inicio del valor (por el signo).
      vl_DatoNumber   NUMBER := NULL; -- Para almacenar el dato ya convertido a numero.
      vl_DatoChar     SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE := NULL; -- Para almacenar el dato de regreso a caracter.;
      vl_Valor        VARCHAR2 (30) := NULL;
      vg_Cadena       VARCHAR2 (30) := 'S99999999999999999999999999999'; -- Para tener un formato inicial.
   BEGIN
      -- Checa el inicio de la cadena (por si tiene o no signo el valor a checar).
      IF (SUBSTR (pa_Valor, csl_1, csl_1) = '+')
         OR (SUBSTR (pa_Valor, csl_1, csl_1) = '-')
      THEN
         vl_Inicio := csl_1;
      ELSE
         vl_Inicio := csl_2;
      END IF;

      --
      IF pa_NumDec > csl_0
      THEN
         vl_Valor :=
            SUBSTR (pa_Valor, 1, LENGTH (pa_Valor) - pa_NumDec) || '.'
            || SUBSTR (pa_Valor,
                       LENGTH (pa_Valor) - pa_NumDec + csl_1,
                       pa_NumDec);
         vl_Formato :=
               SUBSTR (vg_Cadena, vl_Inicio, pa_LongCampo)
            || '.'
            || SUBSTR (vg_Cadena, csl_2, pa_NumDec);
      ELSE
         vl_Valor := SUBSTR (pa_Valor, csl_1, LENGTH (pa_Valor));
         vl_Formato := SUBSTR (vg_Cadena, vl_Inicio, pa_LongCampo);
      END IF;

      --
      vl_DatoNumber := TO_NUMBER (vl_Valor, vl_Formato);
      vl_DatoChar :=
         TO_CHAR (vl_DatoNumber,
                  vl_Formato,
                  'NLS_NUMERIC_CHARACTERS = ''.,''');
      --
      RETURN vl_DatoChar;
   END FNOBTENERFORMATONUMERO;


   FUNCTION ISDATE2 (pa_String VARCHAR2)
      RETURN NUMBER
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Se utiliza para identificar si un string es de tipo de tipo fecha.
      Par�metros de entrada: pa_String - String a validar.
      Par�metros de salida:  Regresa un 0 Cero, 1 Uno, 2 Dos
      Valores de retorno:    0 - Si es un valor nulo � si son espacios en blanco
                             1 - Si es un valor de tipo fecha
                             2 - Si No es un valor tipo fecha
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        VAlida que el dato sea tipo fecha, pero considera el sgiguiente formato como mandatorio
                             -> YYYY-MM-DD  HH24:MI:SS <- Esto es porque se asume que siempre se recibira esa mascara.
      Notas:
      *************************************************************************************************************/
      vl_Exp   DATE;
   BEGIN
      IF (pa_String IS NULL)
      THEN
         RETURN (csl_0);
      END IF;

      vl_Exp := TO_DATE (pa_String, 'YYYY-MM-DD  HH24:MI:SS');
      RETURN (csl_1);
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN (csl_2);
   END ISDATE2;


   FUNCTION ISNUMBER2 (pa_String VARCHAR2)
      RETURN NUMBER
   IS
      /**********************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Se utiliza para identificar si un string es de tipo numerico.
      Par�metros de entrada: pa_String - String a validar.
      Par�metros de salida:  Regresa un 0 Cero, 1 Uno, 2 Dos
      Valores de retorno:    0 - Si es un valor nulo � si son espacios en blanco
                             1 - Si es un valor n�merico
                             2 - Si No es un valor n�merico
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        .
      Notas:
      ***********************************************************************************************************/
      vl_Exp   NUMBER;
   BEGIN
      IF (pa_String IS NULL)
      THEN
         RETURN (csl_0);
      END IF;

      vl_Exp := TO_NUMBER (REPLACE (REPLACE (pa_String, '.'), ','));
      RETURN (csl_1);
   EXCEPTION
      WHEN INVALID_NUMBER OR VALUE_ERROR
      THEN
         RETURN (csl_2);
   END ISNUMBER2;


   FUNCTION ISTIMESTAMP2 (pa_String VARCHAR2)
      RETURN NUMBER
   IS
      /**********************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Se utiliza para identificar si un string es de tipo de tipo fecha.
      Par�metros de entrada: pa_String - String a validar.
      Par�metros de salida:  Regresa un 0 Cero, 1 Uno, 2 Dos
      Valores de retorno:    0 - Si es un valor nulo � si son espacios en blanco
                             1 - Si es un valor de tipo fecha con formato TIMESTAMP
                             2 - Si No es un valor tipo fecha con formato TIMESTAMP
      Llamado por:           SPCTRLDISPERSION
      Llama a:
      Precondiciones:        VAlida que el dato sea tipo fecha, pero considera el siguiente formato como mandatorio
                             -> YYYY-MM-DD-HH24.MI.SS.FF3 <- Esto es porque se asume que siempre se recibira esa mascara.
      Notas:
      ***********************************************************************************************************/
      vl_Exp   TIMESTAMP;
   BEGIN
      IF (pa_String IS NULL)
      THEN
         RETURN (csl_0);
      END IF;

      vl_Exp := TO_TIMESTAMP (pa_String, 'YYYY-MM-DD-HH24.MI.SS.FF3');
      RETURN (csl_1);
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN (csl_2);
   END ISTIMESTAMP2;


   PROCEDURE SPOBTENERSQL (
      pa_DatoDetalle      IN            SCACTUALIZADORVT.TATRNCRDT.FCDATODETA%TYPE,
      pa_ArrEstrucTabla   IN            SCACTUALIZADORVT.ARR_ESTRUCTURA_TAEST,
      pa_SchemaDispersa   IN            SCACTUALIZADORVT.TACAT_SP.FCSP_OWNER%TYPE,
      pa_Query            IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                         FCERR_MSG%TYPE,
      pa_ErrCod           IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                         FCORA_ERR%TYPE,
      pa_OraErrMesg       IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                         FCORA_ERR_MESG%TYPE,
      pa_ErrId            IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE,
      pa_ErrMsg           IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                         FCERR_MSG%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             Genera query para pasar la columna FCDATODETA del Detalle a la estructura ROWTYPE.
      Parametros de entrada: pa_DatoDetalle  :  - Dato del detalle.
                             pi_arr_estru_tabla: - Definici�n de Estructura de la tabla a procesar informacion.
                             pa_SchemaDispersa: - Esquema de la funcion FNOBTENERFORMATOFECHA
      Parametros de salida:  pi_query            - Query generado.
                             pa_ErrCod:         - C�digo de error Oracle
                             pa_OraErrMesg:   - Mensaje de error Oracle
                             pa_ErrId           - Identificador de error
                             pa_ErrMsg          - Mensaje adicional al usuario
      Llamado por:           SPDISPERSADETALLES
      Llama a:               FNOBTENERSQL
      Notas:                 Recibe estructura(s) de la tabla(s) a procesar
      *************************************************************************************************************/
      vl_PosIni             PLS_INTEGER := csl_1;
      vl_DatoTmp            VARCHAR2 (255);
      vl_Comillas           BOOLEAN; -- �Los datos en la consulta SQL llevan comillas?
      vl_Registros          PLS_INTEGER := csl_0;
      vl_Signo              CHAR (1) := NULL;
      vl_EsSigno            BOOLEAN := FALSE;
      vl_DatoNum            PLS_INTEGER;
      vl_Datdec             PLS_INTEGER;
      vl_Datdec2            PLS_INTEGER;
      vl_DatoFec            PLS_INTEGER;
      vl_CaseTipdat         VARCHAR2 (30);
      vl_Comilla            VARCHAR2 (3) := CHR (csl_39);
      exc_ErrorValidacion   EXCEPTION;
   BEGIN
      FOR I IN csl_1 .. pa_ArrEstrucTabla.LAST
      LOOP
         EXIT WHEN pa_ArrEstrucTabla (I).COLUMN_NAME IS NULL;
         vl_Comillas := TRUE;
         vl_Registros := vl_Registros + csl_1;
         vl_DatoTmp :=
            SUBSTR (pa_DatoDetalle,
                    vl_PosIni,
                    pa_ArrEstrucTabla (I).DATA_LENGTH);
         /* VALIDACION DE CARACTERES */
         vl_CaseTipdat := pa_ArrEstrucTabla (I).DATA_TYPE;

         CASE pa_ArrEstrucTabla (I).DATA_TYPE
            WHEN 'CHAR'
            THEN
               IF SUBSTR (pa_ArrEstrucTabla (I).COLUMN_NAME, csl_1, csl_6) =
                     'DSIGNO'
               THEN
                  IF (vl_DatoTmp = '+') OR (vl_DatoTmp = '-')
                  THEN
                     vl_EsSigno := TRUE;
                     vl_Signo := vl_DatoTmp;
                  ELSE
                     pa_ErrId := csl_39;
                     pa_ErrMsg :=
                           'Signo: '
                        || vl_Signo
                        || ' Campo: '
                        || pa_ArrEstrucTabla (I).COLUMN_NAME
                        || ' Posici�n del dato: '
                        || vl_PosIni;
                     RAISE exc_ErrorValidacion;
                  END IF;                          -- vl_DatoTmp IN ('+', '-')
               ELSIF           -- Si es nulo el dato char convierte en blanco.
                    vl_DatoTmp IS NULL
               THEN
                  vl_DatoTmp := ' ';
               END IF;         -- Si es nulo el dato char convierte en blanco.

               vl_DatoTmp := REPLACE (vl_DatoTmp, '''', '''''');
               vl_Comillas := TRUE;
            WHEN 'VARCHAR2'
            THEN
               IF              -- Si es nulo el dato char convierte en blanco.
                 vl_DatoTmp IS NULL
               THEN
                  vl_DatoTmp := ' ';
               END IF;         -- Si es nulo el dato char convierte en blanco.

               vl_DatoTmp := REPLACE (vl_DatoTmp, '''', '''''');
               vl_Comillas := TRUE;
            /* VALIDACION DE FECHAS */
            WHEN 'DATE'
            THEN
               vl_DatoFec := NULL;
               vl_DatoTmp := TRIM (vl_DatoTmp);

               IF                                               -- Fecha nula.
                 vl_DatoTmp = '9999-99-99-99.99.99'
               THEN
                  vl_DatoTmp :=
                     pa_SchemaDispersa || '.'
                     || 'PAUTILERIAS.FNOBTENERFORMATOFECHA (''1901-01-01-00.00.00'')';
               ELSE
                  vl_DatoFec := ISDATE2 (vl_DatoTmp);

                  --
                  IF vl_DatoFec = csl_1
                  THEN
                     vl_DatoTmp :=
                           pa_SchemaDispersa
                        || '.'
                        || 'PAUTILERIAS.FNOBTENERFORMATOFECHA ('
                        || vl_Comilla
                        || vl_DatoTmp
                        || vl_Comilla
                        || ')';
                  ELSIF vl_DatoFec = csl_0
                  THEN
                     vl_DatoTmp :=
                        pa_SchemaDispersa || '.'
                        || 'PAUTILERIAS.FNOBTENERFORMATOFECHA (''1901-01-01-00.00.00'')';
                  ELSE
                     pa_ErrId := csl_35;
                     pa_ErrMsg :=
                           'Valor del dato: '
                        || vl_DatoTmp
                        || ' Campo: '
                        || pa_ArrEstrucTabla (I).COLUMN_NAME
                        || ' Posici�n del dato: '
                        || vl_PosIni;
                     RAISE exc_ErrorValidacion;
                  END IF;
               END IF;                                          -- Fecha nula.

               vl_Comillas := FALSE;
            WHEN 'TIMESTAMP(6)'
            THEN
               vl_DatoFec := NULL;
               vl_DatoTmp := TRIM (vl_DatoTmp);

               IF                                               -- Fecha nula.
                 vl_DatoTmp = '9999-99-99-99.99.99.999'
               THEN
                  vl_DatoTmp :=
                     'TO_TIMESTAMP (''1901-01-01-00.00.00.000'', ''YYYY-MM-DD-HH24.MI.SS.FF3'')';
               ELSE
                  vl_DatoFec := ISTIMESTAMP2 (vl_DatoTmp);

                  IF vl_DatoFec = csl_1
                  THEN
                     vl_DatoTmp :=
                           'TO_TIMESTAMP ('
                        || vl_Comilla
                        || vl_DatoTmp
                        || vl_Comilla
                        || ',''YYYY-MM-DD-HH24.MI.SS.FF3'''
                        || ')';
                  ELSIF vl_DatoFec = csl_0
                  THEN
                     vl_DatoTmp :=
                        'TO_TIMESTAMP (''1901-01-01-00.00.00.000'', ''YYYY-MM-DD-HH24.MI.SS.FF3'')';
                  ELSE
                     pa_ErrId := csl_53;
                     pa_ErrMsg :=
                           'Valor del dato: '
                        || vl_DatoTmp
                        || ' Campo: '
                        || pa_ArrEstrucTabla (I).COLUMN_NAME
                        || ' Posici�n del dato: '
                        || vl_PosIni;
                     RAISE exc_ErrorValidacion;
                  END IF;
               END IF;                                          -- Fecha nula.

               vl_Comillas := FALSE;
            -- VALIDACION DE NUMEROS - Valida numeros con y sin signo
            WHEN 'NUMBER'
            THEN
               vl_DatoTmp := TRIM (vl_DatoTmp);
               vl_Datdec := INSTR (vl_DatoTmp, '.');
               vl_Datdec2 := INSTR (vl_DatoTmp, ',');

               IF (vl_Datdec > csl_0) OR (vl_Datdec2 > csl_0)
               THEN
                  pa_ErrId := csl_54;
                  pa_ErrMsg :=
                        'Valor del dato: '
                     || vl_DatoTmp
                     || ' Campo: '
                     || pa_ArrEstrucTabla (I).COLUMN_NAME
                     || ' Posici�n del dato: '
                     || vl_PosIni;
                  RAISE exc_ErrorValidacion;
               END IF;

               vl_DatoNum := ISNUMBER2 (vl_DatoTmp);

               IF vl_DatoNum = csl_1
               THEN
                  IF TO_NUMBER (vl_DatoTmp) = csl_0
                  THEN
                     vl_DatoTmp := '0';
                  ELSE
                     IF vl_EsSigno = TRUE
                     THEN
                        vl_EsSigno := FALSE;
                        vl_DatoTmp := vl_Signo || vl_DatoTmp;
                     END IF;

                     IF pa_ArrEstrucTabla (I).DATA_PRECISION > csl_0
                     THEN
                        BEGIN
                           vl_DatoTmp :=
                              SCACTUALIZADORVT.PAACTUALIZADOR.
                               FNOBTENERFORMATONUMERO (
                                 vl_DatoTmp,
                                 LENGTH (vl_DatoTmp),
                                 pa_ArrEstrucTabla (I).DATA_PRECISION);
                        EXCEPTION
                           WHEN OTHERS
                           THEN
                              pa_ErrId := csl_55;
                              pa_ErrCod := SQLCODE;
                              pa_OraErrMesg := SQLERRM;
                              pa_ErrMsg :=
                                    'Valor del dato: '
                                 || vl_DatoTmp
                                 || ' Campo: '
                                 || pa_ArrEstrucTabla (I).COLUMN_NAME
                                 || ' Posici�n del dato: '
                                 || vl_PosIni;
                              RAISE exc_ErrorValidacion;
                        END;
                     END IF;        -- pa_ArrEstrucTabla(I).data_precision > 0
                  END IF;
               ELSIF vl_DatoNum = csl_0
               THEN
                  vl_DatoTmp := '0';
               ELSE
                  pa_ErrId := csl_36;
                  pa_ErrMsg :=
                        'Valor del dato: '
                     || vl_DatoTmp
                     || ' Campo: '
                     || pa_ArrEstrucTabla (I).COLUMN_NAME
                     || ' Posici�n del dato: '
                     || vl_PosIni;
                  RAISE exc_ErrorValidacion;
               END IF;

               vl_Comillas := FALSE;
         END CASE;


         -- Primer columna?
         IF vl_Registros = csl_1
         THEN
            -- �La columna en la consulta lleva comillas?
            IF vl_Comillas = TRUE
            THEN
               pa_Query := vl_Comilla || vl_DatoTmp || vl_Comilla;
            ELSE
               pa_Query := vl_DatoTmp;
            END IF;              -- �La columna en la consulta lleva comillas?
         ELSE                                            -- Mas de una columna
            -- �La columna en la consulta lleva comillas?
            IF vl_Comillas = TRUE
            THEN
               pa_Query :=
                  pa_Query || ',' || vl_Comilla || vl_DatoTmp || vl_Comilla;
            ELSE
               pa_Query := pa_Query || ',' || vl_DatoTmp;
            END IF;              -- �La columna en la consulta lleva comillas?
         END IF;                                            -- Primer columna?

         -- Asigna la sig. pos. inicial.
         vl_PosIni := vl_PosIni + pa_ArrEstrucTabla (I).DATA_LENGTH;
      END LOOP;                                           -- pa_ArrEstrucTabla

      -- Termina de armar SELECT.
      pa_Query := 'SELECT ' || pa_Query || ' FROM DUAL';
   EXCEPTION
      WHEN exc_ErrorValidacion
      THEN
         pa_ErrMsg :=
            'Error en validaci�n de estructura del detalle (campo FCDATODETA contra cat�logo de estructuras tabla SCACTUALIZADORVT.TACATESTRUCTURA) validaci�n realizada con los datos - '
            || pa_ErrMsg;
      WHEN CASE_NOT_FOUND
      THEN
         pa_ErrId := csl_56;
         pa_ErrCod := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en validaci�n de estructura del detalle (campo FCDATODETA contra cat�logo de estructuras tabla SCACTUALIZADORVT.TACATESTRUCTURA), el tipo de dato en el cat�logo no es v�lido, tipo de dato que se intento validar - '
            || vl_CaseTipdat;
      WHEN OTHERS
      THEN
         pa_ErrId := csl_0;
         pa_ErrCod := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg :=
            'Error en validaci�n de estructura del detalle (campo FCDATODETA contra cat�logo de estructuras tabla SCACTUALIZADORVT.TACATESTRUCTURA bloque de excepciones WHEN OTHERS, validaci�n realizada con los datos - '
            || pa_ErrMsg;
   END SPOBTENERSQL;


   PROCEDURE SPDISPERSADETALLES (
      pa_Pais          IN            SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      pa_Canal         IN            SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      pa_Sucursal      IN            SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      pa_NumTran       IN            SCACTUALIZADORVT.TATRNCRCB.FITRANNO%TYPE,
      pa_StatusSuc     IN OUT        SCACTUALIZADORVT.TACTRLSUC.FISTATADN%TYPE,
      pa_OraErrMesg    IN OUT NOCOPY SCACTUALIZADORVT.TAERROR_LOG.
                                      FCORA_ERR_MESG%TYPE,
      pa_OraErr        IN OUT        SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE,
      pa_ErrMsg        IN OUT        SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE,
      pa_recCabecero   IN            SCACTUALIZADORVT.TATRNCRCB%ROWTYPE,
      pa_Rowid         IN OUT        ROWID)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Descripci�n:           En base a los parametros de Pais, Canal, Sucursal y Num. tran.,
                             dispersa los registros del detalle correspondientes al cabecero
      Par�metros de entrada:
                             pa_Pais         - Pais
                             pa_Canal        - Canal
                             pa_Sucursal     - Sucursal
                             pa_NumTran     - No. de transaccion
                             pa_recCabecero - Registro de cabecera
      Par�metros de salida:  pa_StatusSuc   - Status de sucursal
                             pa_OraErrMesg- Mensaje de error Oracle
                             pa_OraErr     - Codigo de error
                             pa_ErrMsg      - Mensaje de error adicional
                             pa_Rowid        -
      Llamado por:           SPCTRLDISPERSION
      Llama a:               SP's dinamicamente
      Precondiciones:        Se debe procesar el detalle de transacciones y ejecutar el procedimiento asociado al tipo
                             de registro. Adem�s se debe armar la tabla index by 'tmpt_cre_estructuras''que contendr�
                             las estructuras que se vayan registrando durante el proceso.
      *************************************************************************************************************/
      TYPE rec_TipReg IS RECORD
      (
         tipoReg           SCACTUALIZADORVT.TAREGISTRO.FITIPOREG%TYPE,
         regAccion         SCACTUALIZADORVT.TAREGISTRO.FIREG_ACCION%TYPE,
         nombreSp          SCACTUALIZADORVT.TACAT_SP.FCSP_NAME%TYPE,
         spOwner           SCACTUALIZADORVT.TACAT_SP.FCSP_OWNER%TYPE,
         estructuraTabla   SCACTUALIZADORVT.ARR_ESTRUCTURA_TAEST,
         estLength         SCACTUALIZADORVT.TACATESTRUCTURA.FIEST_LENGTH%TYPE,
         estNombre         SCACTUALIZADORVT.TACATESTRUCTURA.FCEST_NOMBRE%TYPE,
         spNumEst          SCACTUALIZADORVT.TACAT_SP.FISP_NUM_EST%TYPE,
         spTipoEst         SCACTUALIZADORVT.TACAT_SP.FISP_TIPO_EST%TYPE,
         numRegistros      SCACTUALIZADORVT.TATRNCRDT.FICONSDETA%TYPE,
         numCursor         INTEGER
      );

      --
      TYPE typ_TableTipReg IS TABLE OF rec_TipReg
                                 INDEX BY PLS_INTEGER;

      -- Contructor del Arreglo
      vl_TgTipReg             typ_TableTipReg;
      --
      vl_RowsProcessed        BINARY_INTEGER;
      vl_Query                VARCHAR2 (15000);
      vl_QueryAux             VARCHAR2 (15000);
      vl_Sql                  VARCHAR2 (15000);
      vl_S15                  SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE
                                 := RPAD (' ', csl_15, ' ');
      vl_S2000                SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE
                                 := RPAD (' ', csl_2000, ' ');

      vl_Trancredet           SCACTUALIZADORVT.TATRNCRDT%ROWTYPE;
      vl_TipoReg              SCACTUALIZADORVT.TATRNCRDT.FITIPOREG%TYPE;
      vl_RegAccion            SCACTUALIZADORVT.TAREGISTRO.FIREG_ACCION%TYPE;
      vl_ArrEstructTabla      SCACTUALIZADORVT.ARR_ESTRUCTURA_TAEST;
      vl_ConsTran             PLS_INTEGER := csl_0; -- Consecutivo de detalle de transacci�n.
      vl_Indice               PLS_INTEGER := csl_0;
      vl_Regins               PLS_INTEGER := csl_0;
      vl_ReginsTot            PLS_INTEGER := csl_0;

      --
      TYPE typ_TableRowId IS TABLE OF ROWID
                                INDEX BY PLS_INTEGER;

      TYPE typ_TableConsdeta IS TABLE OF NUMBER (10)
                                   INDEX BY PLS_INTEGER;

      TYPE typ_TableTiporeg IS TABLE OF NUMBER (5)
                                  INDEX BY PLS_INTEGER;

      TYPE typ_TableDatodeta IS TABLE OF VARCHAR2 (255 CHAR)
                                   INDEX BY PLS_INTEGER;

      -- Contructor del Arreglo
      vl_TableRowId           typ_TableRowId;
      vl_TableConsdeta        typ_TableConsdeta;
      vl_TableTiporeg         typ_TableTiporeg;
      vl_TableTiporeg_parse   typ_TableTiporeg;
      vl_TableDatodeta        typ_TableDatodeta;
      vl_TableDetaDisp        typ_TableDatodeta;
      vl_DetaDisp             SCACTUALIZADORVT.TATRNCRDT.FCDATODETA%TYPE;
      -- create an exception handler for ORA-24381
      vl_NumErroresExcep      NUMBER;
      exc_DmlErrors           EXCEPTION;
      PRAGMA EXCEPTION_INIT (exc_DmlErrors, -24381);
      exc_ErrorValidacion     EXCEPTION;
      --
      vl_CallSp               SCACTUALIZADORVT.TACAT_SP.FCSP_NAME%TYPE; --Llamada al stored procedure y parametros.
      -- V. de manejo de errores
      vl_ErrId                SCACTUALIZADORVT.TACAT_ERROR.FIERR_ID%TYPE;
      --
      vl_ErrProceso           SCACTUALIZADORVT.TAERROR_LOG.FCERR_PROCESO%TYPE
                                 := 'DET';
      vl_MenError             VARCHAR2 (250);
      vl_ExisteReg            CHAR (1);
      vl_Rowid                ROWID;
      vl_RowidDet             ROWID;
      vl_RowidCont            ROWID := pa_Rowid;
      vl_SpOwner              SCACTUALIZADORVT.TACAT_SP.FCSP_OWNER%TYPE;
      vl_SpNumEst             SCACTUALIZADORVT.TACAT_SP.FISP_NUM_EST%TYPE;
      vl_SpTipoEst            SCACTUALIZADORVT.TACAT_SP.FISP_TIPO_EST%TYPE;
      vl_EstNombre            SCACTUALIZADORVT.TACATESTRUCTURA.FCEST_NOMBRE%TYPE;
      vl_EstLength            SCACTUALIZADORVT.TACATESTRUCTURA.FIEST_LENGTH%TYPE;
      vl_EstTipoEst           SCACTUALIZADORVT.TACATESTRUCTURA.FCEST_TIPO_EST%TYPE;

      --
      CURSOR cur_Valida_Detalle
      IS
           SELECT ROWID, FICONSDETA, FITIPOREG
             FROM SCACTUALIZADORVT.TATRNCRDT
            WHERE     FIPAISID = pa_Pais
                  AND FICANAL = pa_Canal
                  AND FISUCURSAL = pa_Sucursal
                  AND FITRANNO = pa_NumTran
         ORDER BY FICONSDETA;

      -- Obtiene los registros que componen la transacci�n.
      CURSOR cur_Detalle
      IS
         SELECT FICONSDETA, FITIPOREG, FCDATODETA
           FROM SCACTUALIZADORVT.TATRNCRDT
          WHERE ROWID = vl_Rowid;

      --
      CURSOR cur_cat_estructura
      IS
           SELECT FCEST_NOMBRE,
                  FCEST_TIPO_EST,
                  FCEST_OWNER,
                  FARRESTRUC_ARRAY,
                  FIEST_LENGTH,
                  FIEST_PAIS,
                  FIEST_CANAL,
                  FIEST_TIPO_REG
             FROM SCACTUALIZADORVT.TACATESTRUCTURA
            WHERE FCSP_NAME = vl_CallSp
         ORDER BY FCEST_NOMBRE;

      --
      CURSOR cur_cat_sp
      IS
         SELECT FCSP_OWNER, FISP_NUM_EST, FISP_TIPO_EST
           FROM SCACTUALIZADORVT.TACAT_SP
          WHERE FCSP_NAME = vl_CallSp;

      vl_exec_sp_final        VARCHAR2 (4000);
   BEGIN
      vl_Rowid := pa_Rowid;

      FOR c_val_det IN cur_Valida_Detalle
      LOOP
         vl_ConsTran := vl_ConsTran + csl_1;

         -- Consecutivo de detalle de transacci�n correcto?
         IF vl_ConsTran != c_val_det.FICONSDETA
         THEN
            vl_ErrId := csl_13;
            pa_ErrMsg :=
               'Error en validaci�n de consecutividad de detalles, no encontr� el consecutivo n�mero: '
               || vl_ConsTran
               || ' con los valores - '
               || 'Pa�s: '
               || pa_Pais
               || ' Canal: '
               || pa_Canal
               || ' Sucursal: '
               || pa_Sucursal
               || ' Numero Transacci�n: '
               || pa_NumTran;
            RAISE exc_ErrorValidacion;
         END IF;

         -- Almacena ROWID en arreglo
         vl_TableRowId (vl_ConsTran) := c_val_det.ROWID;
         -- Almacena tipo de registro
         vl_TgTipReg (c_val_det.FITIPOREG).TIPOREG := c_val_det.FITIPOREG;
         vl_TgTipReg (c_val_det.FITIPOREG).NUMREGISTROS :=
            NVL (vl_TgTipReg (c_val_det.FITIPOREG).NUMREGISTROS, 0) + 1;
      END LOOP;                                          -- cur_Valida_Detalle

      -- Valida los diferentes tipos de registro almacenados
      vl_Indice := vl_TgTipReg.FIRST;

      LOOP
         EXIT WHEN vl_Indice IS NULL;

         -- Solo busca los registros que no tenga accion a seguir
         IF vl_TgTipReg (vl_Indice).REGACCION IS NULL
         THEN
            vl_TipoReg := vl_TgTipReg (vl_Indice).TIPOREG;
            pa_OraErrMesg := NULL;
            pa_OraErr := NULL;
            pa_ErrMsg := NULL;
            vl_ErrId := NULL;
            SCACTUALIZADORVT.PAACTUALIZADOR.SPVALIDAREGISTRO (pa_Pais,
                                                              pa_Canal,
                                                              vl_TipoReg,
                                                              vl_RegAccion,
                                                              vl_CallSp,
                                                              pa_OraErrMesg,
                                                              pa_OraErr,
                                                              pa_ErrMsg,
                                                              vl_ErrId);

            IF vl_ErrId IS NOT NULL
            THEN
               RAISE exc_ErrorValidacion;
            END IF;

            -- Almacena estatus del tipo de registro y nombre de sp
            vl_TgTipReg (vl_Indice).REGACCION := vl_RegAccion;
            vl_TgTipReg (vl_Indice).NOMBRESP := vl_CallSp;


            -- Valida que el tipo de registro tenga asignado un store procedure
            IF (vl_RegAccion = csl_1) OR (vl_RegAccion = csl_2)
            THEN
               IF vl_CallSp IS NULL
               THEN
                  vl_ErrId := csl_18;
                  pa_ErrMsg :=
                     'Error en validaci�n de SP, no se encuentra registrado el SP en el cat�logo SCACTUALIZADORVT.TAREGISTRO para los valores - '
                     || ' Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || pa_Sucursal
                     || ' N�mero Transacci�n: '
                     || pa_NumTran
                     || ' Tipo de registro: '
                     || vl_TipoReg
                     || ' Acci�n a realizar: '
                     || vl_RegAccion;
                  RAISE exc_ErrorValidacion;
               END IF;

               vl_ExisteReg := 'N';

               -- Obtiene numero de estructuras y tipo_est del SP
               FOR c_cat_sp IN cur_cat_sp
               LOOP
                  vl_SpOwner := c_cat_sp.FCSP_OWNER;
                  vl_SpNumEst := c_cat_sp.FISP_NUM_EST;
                  vl_SpTipoEst := c_cat_sp.FISP_TIPO_EST;
                  vl_ExisteReg := 'S';
               END LOOP;

               IF vl_ExisteReg = 'N'
               THEN
                  vl_ErrId := csl_30;
                  pa_ErrMsg :=
                     'Error en validaci�n de SP, no se encuentra registrado el SP en el cat�logo SCACTUALIZADORVT.TACAT_SP para los valores - '
                     || 'Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || pa_Sucursal
                     || ' Numero Transacci�n: '
                     || pa_NumTran
                     || ' SP:'
                     || vl_SpOwner
                     || '.'
                     || vl_CallSp;
                  RAISE exc_ErrorValidacion;
               END IF;

               -- Si el SP unicamente trabaja con una estructura guarda su informacion.
               IF vl_SpNumEst = csl_1
               THEN
                  vl_ExisteReg := 'N';

                  FOR c_cat_estructura IN cur_cat_estructura
                  LOOP
                     vl_ExisteReg := 'S';
                     vl_TgTipReg (vl_Indice).ESTRUCTURATABLA :=
                        c_cat_estructura.FARRESTRUC_ARRAY;
                     vl_TgTipReg (vl_Indice).ESTNOMBRE :=
                        c_cat_estructura.FCEST_NOMBRE;
                     vl_TgTipReg (vl_Indice).ESTLENGTH :=
                        c_cat_estructura.FIEST_LENGTH;
                  END LOOP;

                  IF vl_ExisteReg = 'N'
                  THEN
                     vl_ErrId := csl_42;
                     pa_ErrMsg :=
                        'Error en validaci�n de estructura, no se encuentra registrada la estructura del registro en el cat�logo SCACTUALIZADORVT.TACATESTRUCTURA para los valores - '
                        || 'Pa�s: '
                        || pa_Pais
                        || ' Canal: '
                        || pa_Canal
                        || ' Sucursal: '
                        || pa_Sucursal
                        || ' Numero Transacci�n: '
                        || pa_NumTran
                        || ' SP:'
                        || vl_SpOwner
                        || '.'
                        || vl_CallSp;
                     RAISE exc_ErrorValidacion;
                  END IF;                               -- vl_ExisteReg  = 'N'
               END IF;                                      -- vl_SpNumEst = 1

               -- Almacena datos del SP
               vl_TgTipReg (vl_Indice).SPOWNER := vl_SpOwner;
               vl_TgTipReg (vl_Indice).SPNUMEST := vl_SpNumEst;
               vl_TgTipReg (vl_Indice).SPTIPOEST := vl_SpTipoEst;
               -- Dinamico
               vl_TgTipReg (vl_Indice).NUMCURSOR := csl_0;
            END IF;                    -- vl_RegAccion = 1 OR vl_RegAccion = 2
         END IF;                   -- vl_TgTipReg(vl_Indice).regAccion IS NULL

         -- Obtiene el indice del sig. tipo de registro.
         vl_Indice := vl_TgTipReg.NEXT (vl_Indice);
      END LOOP;                                           -- vl_TgTipReg.FIRST

      --
      vl_Trancredet.FIPAISID := pa_Pais;
      vl_Trancredet.FICANAL := pa_Canal;
      vl_Trancredet.FISUCURSAL := pa_Sucursal;
      vl_Trancredet.FITRANNO := pa_NumTran;

      -- Procesa los detalles de la transaccion
      FOR REG_DETALLE IN csl_1 .. vl_ConsTran
      LOOP
         vl_RowidDet := vl_TableRowId (REG_DETALLE);
         vl_Rowid := vl_TableRowId (REG_DETALLE);

         FOR c_detalle IN cur_Detalle
         LOOP
            vl_RegAccion := vl_TgTipReg (c_detalle.FITIPOREG).REGACCION;
            vl_Trancredet.FICONSDETA := c_detalle.FICONSDETA;
            vl_Trancredet.FITIPOREG := c_detalle.FITIPOREG;
            vl_Trancredet.FCDATODETA := c_detalle.FCDATODETA;

            -- INICIO DEL PROCESO POR REGISTRO
            -- vl_InicioProceso := CURRENT_TIMESTAMP;
            -- Guarda la estructura en el arreglo.
            IF (vl_RegAccion = csl_2) OR (vl_RegAccion = csl_3)
            THEN
               -- Almacena fcdatodeta en arreglo
               vl_TableDetaDisp (c_detalle.FITIPOREG) := c_detalle.FCDATODETA;
            END IF;                                    -- vl_RegAccion = 2 o 3

            -- ---------------------------------------------------------------------------------
            -- Procesa los registros.
            IF (vl_RegAccion = csl_1) OR (vl_RegAccion = csl_2)
            THEN
               vl_CallSp := vl_TgTipReg (c_detalle.FITIPOREG).NOMBRESP;
               vl_SpOwner := vl_TgTipReg (c_detalle.FITIPOREG).SPOWNER;

               BEGIN                   -- Bloque de generacion de SQL dinamico
                  -- Evalua dependiendo del numero de estructuras del SP

                  CASE vl_TgTipReg (c_detalle.FITIPOREG).SPNUMEST
                     WHEN 1
                     THEN
                        -- Valida que pueda dispersar todo el detalle
                        IF NVL (LENGTH (RTRIM (c_detalle.FCDATODETA)), csl_0) >
                              vl_TgTipReg (c_detalle.FITIPOREG).ESTLENGTH
                        THEN
                           vl_ErrId := csl_34;
                           pa_ErrMsg :=
                              'Error en la validaci�n del detalle de transacci�n, la longitud del campo FCDATODETA es mayor a la definida en el cat�logo SCACTUALIZADORVT.TACATESTRUCTURA con los valores - '
                              || ' Pa�s: '
                              || pa_Pais
                              || ' Canal: '
                              || pa_Canal
                              || ' Sucursal: '
                              || pa_Sucursal
                              || ' N�mero de Transacci�n: '
                              || pa_NumTran
                              || ' consecutivo de detalle: '
                              || REG_DETALLE
                              || ' Estructura: '
                              || vl_TgTipReg (c_detalle.FITIPOREG).ESTNOMBRE
                              || ' Dato excedente: '
                              || SUBSTR (
                                    c_detalle.FCDATODETA,
                                    vl_TgTipReg (c_detalle.FITIPOREG).
                                     ESTLENGTH
                                    + 1);

                           RAISE exc_ErrorValidacion;
                        END IF;

                        SCACTUALIZADORVT.PAACTUALIZADOR.
                         SPOBTENERSQL (
                           c_detalle.FCDATODETA,
                           vl_TgTipReg (c_detalle.FITIPOREG).ESTRUCTURATABLA,
                           vl_SpOwner,
                           vl_Query,
                           pa_OraErr,
                           pa_OraErrMesg,
                           vl_ErrId,
                           pa_ErrMsg);

                        IF vl_ErrId IS NOT NULL
                        THEN
                           pa_ErrMsg :=
                              'Error en la validaci�n del detalle de transacci�n con los valores -'
                              || ' Pa�s: '
                              || pa_Pais
                              || ' Canal: '
                              || pa_Canal
                              || ' Sucursal: '
                              || pa_Sucursal
                              || ' N�mero de Transacci�n: '
                              || pa_NumTran
                              || ' consecutivo de detalle: '
                              || REG_DETALLE
                              || ' Estructura:'
                              || vl_TgTipReg (c_detalle.FITIPOREG).ESTNOMBRE
                              || ', '
                              || pa_ErrMsg;
                           RAISE exc_ErrorValidacion;
                        END IF;
                     WHEN csl_2
                     THEN
                        IF vl_TgTipReg (c_detalle.FITIPOREG).SPTIPOEST = 1 -- E-Commerce
                        THEN
                           IF pa_recCabecero.FISUCURSAL = csl_9797
                              OR pa_recCabecero.FISUCURSAL = csl_3907
                           THEN
                              vl_EstTipoEst := 'EC';
                           ELSE
                              vl_EstTipoEst := '0';
                           END IF;

                           vl_ArrEstructTabla := NULL;
                           vl_ExisteReg := 'N';

                           FOR c_cat_estructura IN cur_cat_estructura
                           LOOP
                              -- Obtiene estructura
                              IF NVL (c_cat_estructura.FCEST_TIPO_EST, '0') =
                                    vl_EstTipoEst
                              THEN
                                 vl_ExisteReg := 'S';
                                 vl_ArrEstructTabla :=
                                    c_cat_estructura.FARRESTRUC_ARRAY;
                                 vl_EstLength := c_cat_estructura.FIEST_LENGTH;
                              END IF;
                           END LOOP;                     -- cur_cat_estructura

                           IF vl_ExisteReg = 'N'
                           THEN
                              vl_ErrId := csl_42;
                              pa_ErrMsg :=
                                    'Del SP: '
                                 || vl_SpOwner
                                 || '.'
                                 || vl_CallSp
                                 || ', con FCEST_TIPO_EST: '
                                 || vl_EstTipoEst;
                              RAISE exc_ErrorValidacion;
                           END IF;                       -- vl_ExisteReg = 'N'

                           -- Valida que pueda dispersar todo el detalle
                           IF NVL (LENGTH (RTRIM (c_detalle.FCDATODETA)), 0) >
                                 vl_EstLength
                           THEN
                              vl_ErrId := csl_34;
                              pa_ErrMsg :=
                                 'Error en la validaci�n del detalle de transacci�n, la longitud del campo FCDATODETA es mayor a la definida en el cat�logo SCACTUALIZADORVT.TACATESTRUCTURA con los valores - '
                                 || ' Pa�s: '
                                 || pa_Pais
                                 || ' Canal: '
                                 || pa_Canal
                                 || ' Sucursal: '
                                 || pa_Sucursal
                                 || ' N�mero de Transacci�n: '
                                 || pa_NumTran
                                 || ' consecutivo de detalle: '
                                 || REG_DETALLE
                                 || ' Estructura: '
                                 || vl_TgTipReg (c_detalle.FITIPOREG).
                                     ESTNOMBRE
                                 || ' Dato excedente: '
                                 || SUBSTR (
                                       c_detalle.FCDATODETA,
                                       vl_TgTipReg (c_detalle.FITIPOREG).
                                        ESTLENGTH
                                       + 1);
                              RAISE exc_ErrorValidacion;
                           END IF;

                           --

                           SCACTUALIZADORVT.PAACTUALIZADOR.
                            SPOBTENERSQL (c_detalle.fcdatodeta,
                                          vl_ArrEstructTabla,
                                          vl_SpOwner,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);

                           IF vl_ErrId IS NOT NULL
                           THEN
                              pa_ErrMsg :=
                                 'Error en la validaci�n del detalle de transacci�n con los valores -'
                                 || ' Pa�s: '
                                 || pa_Pais
                                 || ' Canal: '
                                 || pa_Canal
                                 || ' Sucursal: '
                                 || pa_Sucursal
                                 || ' N�mero de Transacci�n: '
                                 || pa_NumTran
                                 || ' consecutivo de detalle: '
                                 || REG_DETALLE
                                 || ' Estructura:'
                                 || vl_TgTipReg (c_detalle.FITIPOREG).
                                     ESTNOMBRE
                                 || ' Detalle de mensajes --> '
                                 || CHR (10)
                                 || pa_ErrMsg;
                              RAISE exc_ErrorValidacion;
                           END IF;
                        ELSE                            -- spTipoEst Estandard
                           vl_SpNumEst := csl_0;
                           vl_Query := NULL;

                           -- Obtiene estructuras -- AQ VOY
                           FOR c_cat_estructura IN cur_cat_estructura
                           LOOP
                              vl_SpNumEst := vl_SpNumEst + csl_1;

                              -- Esta es la regla por la que decide de donde obtener el dato
                              IF c_detalle.FITIPOREG =
                                    c_cat_estructura.FIEST_TIPO_REG
                              THEN
                                 vl_DetaDisp := c_detalle.FCDATODETA;
                              ELSE
                                 BEGIN
                                    vl_DetaDisp :=
                                       vl_TableDetaDisp (
                                          c_cat_estructura.FIEST_TIPO_REG);
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       vl_ErrId := csl_59;
                                       pa_OraErr := SQLCODE;
                                       pa_OraErrMesg := SQLERRM;
                                       pa_ErrMsg :=
                                          'Error en validaci�n del tipo de registro, no se encontr� el tipo de registro asociado a la estructura con los valores - '
                                          || ' Pa�s: '
                                          || pa_Pais
                                          || ' Canal: '
                                          || pa_Canal
                                          || ' Sucursal: '
                                          || pa_Sucursal
                                          || ' N�mero de Transacci�n: '
                                          || pa_NumTran
                                          || ' consecutivo de detalle: '
                                          || c_cat_estructura.FIEST_TIPO_REG;
                                 END;

                                 IF vl_ErrId IS NOT NULL
                                 THEN
                                    RAISE exc_ErrorValidacion;
                                 END IF;
                              END IF;

                              -- Valida que pueda dispersar todo el detalle
                              IF NVL (LENGTH (RTRIM (vl_DetaDisp)), csl_0) >
                                    c_cat_estructura.FIEST_LENGTH
                              THEN
                                 vl_ErrId := csl_34;
                                 pa_ErrMsg :=
                                    'Error en la validaci�n del detalle de transacci�n, la longitud del campo FCDATODETA es mayor a la definida en el cat�logo SCACTUALIZADORVT.TACATESTRUCTURA con los valores - '
                                    || ' Pa�s: '
                                    || pa_Pais
                                    || ' Canal: '
                                    || pa_Canal
                                    || ' Sucursal: '
                                    || pa_Sucursal
                                    || ' N�mero de Transacci�n: '
                                    || pa_NumTran
                                    || ' consecutivo de detalle: '
                                    || REG_DETALLE
                                    || ' Estructura: '
                                    || c_cat_estructura.FCEST_NOMBRE
                                    || ' Dato excedente: '
                                    || SUBSTR (
                                          vl_DetaDisp,
                                          c_cat_estructura.FIEST_LENGTH + 1);
                                 RAISE exc_ErrorValidacion;
                              END IF;

                              --

                              SCACTUALIZADORVT.PAACTUALIZADOR.
                               SPOBTENERSQL (
                                 vl_DetaDisp,
                                 c_cat_estructura.FARRESTRUC_ARRAY,
                                 vl_SpOwner,
                                 vl_QueryAux                 -- Query auxiliar
                                            ,
                                 pa_OraErr,
                                 pa_OraErrMesg,
                                 vl_ErrId,
                                 pa_ErrMsg);

                              IF vl_ErrId IS NOT NULL
                              THEN
                                 pa_ErrMsg :=
                                    'Error en la validaci�n del detalle de transacci�n con los valores -'
                                    || ' Pa�s: '
                                    || pa_Pais
                                    || ' Canal: '
                                    || pa_Canal
                                    || ' Sucursal: '
                                    || pa_Sucursal
                                    || ' N�mero de Transacci�n: '
                                    || pa_NumTran
                                    || ' consecutivo de detalle: '
                                    || c_cat_estructura.FIEST_TIPO_REG
                                    || ' Estructura:'
                                    || c_cat_estructura.FCEST_NOMBRE
                                    || ', '
                                    || pa_ErrMsg;
                                 RAISE exc_ErrorValidacion;
                              END IF;

                              -- Concatena nombre de la estructura y SQL para recuperar datos de esa estructura
                              vl_Query :=
                                    vl_Query
                                 || c_cat_estructura.FCEST_NOMBRE
                                 || vl_QueryAux;
                           END LOOP;                     -- cur_cat_estructura

                           IF vl_SpNumEst !=
                                 vl_TgTipReg (c_detalle.FITIPOREG).SPNUMEST
                           THEN
                              vl_ErrId := csl_42; -- NO SE ENCONTRARON LAS ESTRUCTURAS ESPERADAS (CREAR MSG)
                              pa_ErrMsg :=
                                 'Error en validaci�n de registros a utilizar para el procesamiento del detalle, con los siguientes datos - SP: '
                                 || vl_SpOwner
                                 || '.'
                                 || vl_CallSp
                                 || ' N�mero de estructuras a utilizar: '
                                 || vl_SpNumEst
                                 || ' N�mero de estructuras esperadas: '
                                 || vl_TgTipReg (c_detalle.FITIPOREG).
                                     SPNUMEST;
                              RAISE exc_ErrorValidacion;
                           END IF;             -- Numero de estructuras del SP
                        END IF;                 -- spTipoEst = 1 -- E-Commerce
                  END CASE;
               EXCEPTION
                  WHEN CASE_NOT_FOUND
                  THEN
                     vl_ErrId := csl_56;
                     pa_OraErr := SQLCODE;
                     pa_OraErrMesg := SQLERRM;
                     pa_ErrMsg :=
                        'Error en validaci�n de estructuras para el procesamiento del detalle, el n�mero de estructuras asociadas a un SP con los datos - SP: '
                        || vl_SpOwner
                        || '.'
                        || vl_CallSp
                        || ' N�mero de estructuras asociadas: '
                        || vl_TgTipReg (c_detalle.FITIPOREG).SPNUMEST;
                  WHEN OTHERS
                  THEN
                     vl_ErrId := csl_57;
                     pa_OraErr := SQLCODE;
                     pa_OraErrMesg := SQLERRM;
                     pa_ErrMsg :=
                        'Error en validaci�n de estructuras para el procesamiento del detalle, bloque de excepciones WHEN OTHERS con los datos - SP: '
                        || vl_SpOwner
                        || '.'
                        || vl_CallSp
                        || ' N�mero de estructuras asociadas: '
                        || vl_TgTipReg (c_detalle.FITIPOREG).SPNUMEST;
               END;                    -- Bloque de generacion de SQL dinamico

               IF vl_ErrId IS NOT NULL
               THEN
                  RAISE exc_ErrorValidacion;
               END IF;

               BEGIN
                  pa_OraErr := vl_S15;
                  pa_OraErrMesg := vl_S2000;
                  pa_ErrMsg := vl_S2000;

                  IF TRIM (UPPER (vl_SpOwner)) = CSL_OWNER
                  THEN
                     CASE TRIM (UPPER (vl_CallSp))
                        WHEN CLS_SP01001_0217
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0217 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0208
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0208 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0210
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0210 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0220
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0220 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4633
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4633 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4719
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4719 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_5320
                        THEN
                           SCVENTASTIENDA.
                            SP01001_5320 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_7422
                        THEN
                           SCVENTASTIENDA.
                            SP01001_7422 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0010
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0010 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0012
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0012 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0070
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0070 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0075
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0075 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0050
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0050 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0060
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0060 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0120
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0120 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4361
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4361 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4368
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4368 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4380
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4380 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0110
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0110 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0100
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0100 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4462
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4462 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0115
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0115 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_0185
                        THEN
                           SCVENTASTIENDA.
                            SP01001_0185 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        WHEN CLS_SP01001_4381
                        THEN
                           SCVENTASTIENDA.
                            SP01001_4381 (pa_recCabecero.FIPAISID,
                                          pa_recCabecero.FICANAL,
                                          pa_recCabecero.FISUCURSAL,
                                          pa_recCabecero.FITRANNO,
                                          pa_recCabecero.FITRANTIPO,
                                          pa_recCabecero.FICONSECTIPO,
                                          pa_recCabecero.FDTRANSFECHR,
                                          pa_recCabecero.FCTRANWS,
                                          pa_recCabecero.FCTRANUSR,
                                          c_detalle.FITIPOREG,
                                          vl_Query,
                                          pa_OraErr,
                                          pa_OraErrMesg,
                                          vl_ErrId,
                                          pa_ErrMsg);
                        ELSE
                           NULL;
                     END CASE;
                  END IF;

                  IF vl_ErrId = csl_n1                                   --ecc
                  THEN
                     vl_ErrId := NULL;
                  END IF;

                  IF --Valida si es el ultimo registro del mismo tipo en la transaccion
                    vl_TgTipReg (c_detalle.FITIPOREG).NUMREGISTROS = csl_1
                  THEN
                     NULL;
                  ELSE --Valida si es el ultimo registro del mismo tipo en la transaccion
                     vl_TgTipReg (c_detalle.FITIPOREG).NUMREGISTROS :=
                        vl_TgTipReg (c_detalle.FITIPOREG).NUMREGISTROS - 1;
                  END IF; --Valida si es el ultimo registro del mismo tipo en la transaccion
               EXCEPTION
                  WHEN OTHERS
                  THEN                     --Error al llamar stored procedure.
                     IF REPLACE (REGEXP_SUBSTR (SQLERRM, 'PLS-[[:digit:]]+'),
                                 'PLS',
                                 NULL) = -00201
                     THEN
                        vl_ErrId := csl_57;
                     ELSIF REPLACE (
                              REGEXP_SUBSTR (SQLERRM, 'PLS-[[:digit:]]+'),
                              'PLS',
                              NULL) = -00306
                     THEN
                        vl_ErrId := csl_62;
                     ELSE
                        vl_ErrId := csl_19;
                     END IF;

                     pa_OraErr := SQLCODE;
                     pa_OraErrMesg := SQLERRM;
                     pa_ErrMsg :=
                        'Error en la ejecuci�n din�mica del SP asociado a los datos - '
                        || ' Pa�s: '
                        || pa_recCabecero.FIPAISID
                        || ' Canal: '
                        || pa_recCabecero.FICANAL
                        || ' Sucursal: '
                        || pa_recCabecero.FISUCURSAL
                        || ' Transacci�n: '
                        || pa_recCabecero.FITRANNO
                        || ' Tipo de registro: '
                        || c_detalle.FITIPOREG
                        || ' SP: '
                        || vl_SpOwner
                        || '.'
                        || vl_CallSp;
               END;                           -- Execucion de SP dinamicamente

               IF vl_ErrId IS NOT NULL
               THEN
                  RAISE exc_ErrorValidacion;
               END IF;
            END IF;                                    -- vl_RegAccion = 1 o 2
         END LOOP;                                                -- c_detalle
      END LOOP;                                                 -- reg_detalle

      -- Terminino satisfactoriamente de dispersar los detalles
      --
      -- Elimina detalles de la transaccion
      BEGIN
         FORALL I IN csl_1 .. vl_ConsTran
         SAVE EXCEPTIONS
            DELETE FROM SCACTUALIZADORVT.TATRNCRDT
                  WHERE ROWID = vl_TableRowId (I)
              RETURNING FICONSDETA, FITIPOREG, FCDATODETA
                   BULK COLLECT INTO vl_TableConsdeta,
                        vl_TableTiporeg,
                        vl_TableDatodeta;
      EXCEPTION
         -- If any errors occurred during the FORALL SAVE EXCEPTIONS,
         -- a single exception is raised when the statement completes.
         WHEN exc_DmlErrors
         THEN                        -- Now we figure out what failed and why.
            ROLLBACK;
            vl_NumErroresExcep := SQL%BULK_EXCEPTIONS.COUNT;

            FOR I IN 1 .. vl_NumErroresExcep
            LOOP
               pa_OraErrMesg := SQLERRM (-SQL%BULK_EXCEPTIONS (i).ERROR_CODE);
               EXIT;
            END LOOP;

            vl_ErrId := csl_20;
            pa_StatusSuc := csl_0;
            pa_OraErr := SQLCODE;
            pa_ErrMsg :=
               'Error en la eliminaci�n de los detalles procesados correctamente, no se pudieron eliminar los detalles asociados a los siguientes datos - '
               || ' Pa�s: '
               || pa_Pais
               || ' Canal: '
               || pa_Canal
               || ' Sucursal: '
               || pa_Sucursal
               || ' N�mero de Transacci�n: '
               || pa_NumTran
               || ' N�mero de registros que no se pudieron eliminar: '
               || vl_NumErroresExcep;
         WHEN OTHERS
         THEN
            vl_ErrId := csl_20;
            pa_OraErr := SQLCODE;
            pa_OraErrMesg := SQLERRM;
      END;                               -- Elimina detalles de la transaccion

      IF vl_ErrId IS NOT NULL
      THEN
         RAISE exc_ErrorValidacion;
      END IF;

      --
      -- Inserta detalles de la transaccion
      BEGIN
         FORALL I IN csl_1 .. vl_ConsTran                    --SAVE EXCEPTIONS
            INSERT INTO SCACTUALIZADORVT.TATRNCRDTH (FIPAISID,
                                                     FICANAL,
                                                     FISUCURSAL,
                                                     FITRANNO,
                                                     FICONSDETA,
                                                     FITIPOREG,
                                                     FCDATODETA,
                                                     FDFECHAFINPROCESO)
                 VALUES (pa_Pais,
                         pa_Canal,
                         pa_Sucursal,
                         pa_NumTran,
                         vl_TableConsdeta (I),
                         vl_TableTiporeg (I),
                         vl_TableDatodeta (I),
                         SYSDATE)
                    LOG ERRORS INTO SCACTUALIZADORVT.TATRNCRDTHL
                           ('Error al momento de pasar los detalles de transacci�n procesados de manera satisfactoria al hist�rico (tabla SCACTUALIZADORVT.TATRNCRCBH) - '
                            || TO_CHAR (SYSDATE, 'DD/MM/YYYY HH24:MI:SS'))
                           REJECT LIMIT UNLIMITED;

         vl_ReginsTot := SQL%ROWCOUNT;

         --
         IF vl_ReginsTot < vl_ConsTran
         THEN
            pa_ErrMsg :=
               'Aviso - Se graban los detalles que no se pudieron pasar al hist�rico en la tabla SCACTUALIZADORVT.TATRNCRCBHL, datos - N�mero de registros a insertar: '
               || (vl_ConsTran - vl_ReginsTot)
               || ' Total de registros a pasar al hist�rico: '
               || vl_ConsTran;
            vl_MenError :=
               SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (pa_ErrMsg,
                                                             pa_OraErr,
                                                             pa_OraErrMesg,
                                                             csl_63 -- FIERR_ID
                                                                   ,
                                                             vl_ErrProceso,
                                                             vl_RowidCont);
         END IF;                                              -- vl_NumReg = 0
      EXCEPTION
         -- If any errors occurred during the FORALL SAVE EXCEPTIONS,
         -- a single exception is raised when the statement completes.
         WHEN exc_DmlErrors
         THEN                        -- Now we figure out what failed and why.
            ROLLBACK;
            vl_NumErroresExcep := SQL%BULK_EXCEPTIONS.COUNT;

            FOR I IN csl_1 .. vl_NumErroresExcep
            LOOP
               pa_OraErrMesg := SQLERRM (-SQL%BULK_EXCEPTIONS (i).ERROR_CODE);
               EXIT;
            END LOOP;

            vl_ErrId := csl_20;
            pa_StatusSuc := csl_0;
            pa_OraErr := SQLCODE;
            pa_ErrMsg :=
               'Error al momento de pasar los detalles de transacci�n procesados de manera satisfactoria al hist�rico, valores - N�mero de registros que no pudieron pasarse: '
               || vl_NumErroresExcep;
         WHEN OTHERS
         THEN
            vl_ErrId := csl_20;
            pa_OraErr := SQLCODE;
            pa_OraErrMesg := SQLERRM;
      END;                               -- Inserta detalles de la transaccion

      IF vl_ErrId IS NOT NULL
      THEN
         RAISE exc_ErrorValidacion;
      END IF;
   EXCEPTION
      WHEN exc_ErrorValidacion
      THEN
         ROLLBACK;
         pa_Rowid := vl_Rowid;

         ------ecc
         IF vl_ErrId = csl_n1
         THEN
            pa_StatusSuc := csl_n1;
         ELSE
            pa_StatusSuc := csl_0;
         END IF;

         ------ecc

         vl_TableRowId.DELETE;
         vl_MenError :=
            SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (pa_ErrMsg,
                                                          pa_OraErr,
                                                          pa_OraErrMesg,
                                                          vl_ErrId,
                                                          vl_ErrProceso,
                                                          vl_Rowid);

         vl_ErrId := NULL;

         -- Si el error fue al procesar graba el detalle
         IF vl_RowidDet IS NOT NULL
         THEN
            SCACTUALIZADORVT.PAACTUALIZADOR.SPGRABAERRDET (vl_Rowid,
                                                           pa_OraErr,
                                                           pa_OraErrMesg,
                                                           vl_ErrId,
                                                           pa_ErrMsg);
         END IF;                                    -- vl_RowidDet IS NOT NULL

         IF vl_ErrId IS NOT NULL
         THEN
            vl_MenError :=
               SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (pa_ErrMsg,
                                                             pa_OraErr,
                                                             pa_OraErrMesg,
                                                             vl_ErrId,
                                                             vl_ErrProceso,
                                                             vl_Rowid);
         END IF;
      WHEN SYS_INVALID_ROWID
      THEN
         vl_ErrId := csl_52;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
      WHEN OTHERS                  --Error general de la aplicacion (Detalle).
      THEN
         vl_ErrId := csl_0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_StatusSuc := csl_0;
         vl_TableRowId.DELETE;
         vl_MenError :=
            SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (pa_ErrMsg,
                                                          pa_OraErr,
                                                          pa_OraErrMesg,
                                                          vl_ErrId,
                                                          vl_ErrProceso,
                                                          vl_Rowid);
   END SPDISPERSADETALLES;



   PROCEDURE SPCTRLDISPERSION (
      pa_Pais     IN SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      pa_Canal    IN SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      pa_SucIni   IN SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      pa_SucFin   IN SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE)
   IS
      /*************************************************************************************************************
      Proyecto:              GESTION DE CLIENTES
      Proposito:             En base a los parametros de Pais, Canal y Sucursal,
                             controla el proceso de dispersion de los registros del
                             cabecero y los correspondientes del detalle
      Parametros de entrada: pa_Pais     - Pais
                             pa_Canal    - Canal
                             pa_SucIni  - Sucursal inicial
                             pa_SucFin  - Sucursal final
      Par�metros de salida:  po_FCORA_ERR - Error general
      Valores de retorno:    TRUE si la transacci�n es valida
      Llamado por:           DBMS_SCHEDULER
      Llama a:               SP_DISPERSA_DETALLES
      Precondiciones:        Se debe procesar el cabecero y detalle de transacciones, cuando se detecte algun error,}
                             este se registra en la tabla de control de sucursales (CTRLSUC), de lo contrario se pro-
                             cesan todas y cada una de las transacciones de la sucursal en cuestion.
      Notas:                 Se omitio el numero de transacciones a procesar
      *************************************************************************************************************/
      vl_Sucursal       SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE := csl_0;
      vl_EstSuc         SCACTUALIZADORVT.TACTRLSUC.FISTATADN%TYPE := csl_0; -- Estatus de la sucursal: 0 = en error 1 = sin error
      vl_UltTrans       SCACTUALIZADORVT.TACTRLSUC.FIULTTRANS%TYPE := csl_0; -- Ultima transaccion procesada
      rec_Trancrecab    SCACTUALIZADORVT.TATRNCRCB%ROWTYPE; -- Registro de cabecero
      exc_ErrSucursal   EXCEPTION;
      exc_ErrGeneral    EXCEPTION;
      vl_OraErrMesg     SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR_MESG%TYPE;
      vl_ErrMsg         SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE := NULL;
      vl_ErrId          SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE;
      vl_ErrProceso     SCACTUALIZADORVT.TAERROR_LOG.FCERR_PROCESO%TYPE
                           := 'CAB';
      vl_MenErrorFn     VARCHAR2 (250);
      vl_FechaTransac   DATE;
      vl_RowidErr       ROWID;
      vl_AltaSuc        PLS_INTEGER;
      pa_OraErr         VARCHAR2 (4000);                      --07/12/2006 FHT

      --
      TYPE typ_TableCatTrans IS TABLE OF NUMBER (5)
                                   INDEX BY PLS_INTEGER;

      -- Contructor del Arreglo
      vl_CatTrans       typ_TableCatTrans;

      --
      CURSOR cur_Cabecero
      IS
           SELECT ROWID,
                  FISUCURSAL,
                  FITRANNO,
                  FITRANTIPO,
                  FICONSECTIPO,
                  FDTRANSFECHR,
                  FCTRANWS,
                  FCTRANUSR,
                  FITRANNOREG,
                  FITRANSMIT,
                  FDFECHARECEP
             FROM SCACTUALIZADORVT.TATRNCRCB
            WHERE     FIPAISID = pa_Pais
                  AND FICANAL = pa_Canal
                  AND FISUCURSAL BETWEEN pa_SucIni AND pa_SucFin
         ORDER BY FISUCURSAL, FITRANNO;
   BEGIN
      FOR rec_Cabecero IN cur_Cabecero
      LOOP                                                  -- Ciclo cabeceros
         -- Inicializa variables para identificar error
         vl_RowidErr := rec_Cabecero.ROWID;
         vl_ErrId := NULL;
         vl_OraErrMesg := NULL;
         vl_ErrMsg := NULL;
         pa_OraErr := NULL;                                   --07/12/2006 FHT
         vl_FechaTransac := SYSDATE;

         -- Boque manejo de excepciones por transaccion
         BEGIN
            -- Valida cambio de sucursal
            IF rec_Cabecero.FISUCURSAL <> vl_Sucursal
            THEN
               vl_Sucursal := rec_Cabecero.FISUCURSAL; --Lleva control de cambio de sucursal
               -- Valida sucursal
               vl_AltaSuc := 0;
               SCACTUALIZADORVT.PAACTUALIZADOR.
                SPESTATUSSUCURSAL (pa_Pais,
                                   pa_Canal,
                                   rec_Cabecero.FISUCURSAL,
                                   rec_Cabecero.FITRANNO,
                                   vl_EstSuc,
                                   vl_UltTrans,
                                   rec_Cabecero.ROWID,
                                   vl_AltaSuc,
                                   pa_OraErr,
                                   vl_OraErrMesg,
                                   vl_ErrId,
                                   vl_ErrMsg);

               IF vl_ErrId IS NOT NULL
               THEN
                  vl_ErrMsg :=
                     'Error en la validaci�n de la sucursal con los datos - Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || rec_Cabecero.FISUCURSAL
                     || ' N�mero Transacci�n: '
                     || rec_Cabecero.FITRANNO;
                  RAISE exc_ErrGeneral;
               END IF;
            END IF;                                --VALIDA CAMBIO DE SUCURSAL

            vl_UltTrans := rec_Cabecero.FITRANNO;

            -- Valida tipo transac.
            IF vl_CatTrans.EXISTS (rec_Cabecero.FITRANTIPO)
            THEN
               NULL;                       --Si existe el fitrantipo es valido
            ELSE
               SCACTUALIZADORVT.PAACTUALIZADOR.
                SPVALIDATRANTIPO (rec_Cabecero.FITRANTIPO,
                                  pa_OraErr,
                                  vl_OraErrMesg,
                                  vl_ErrId);

               IF vl_ErrId IS NOT NULL
               THEN
                  vl_ErrMsg :=
                     'Error en la validaci�n del tipo de transacci�n (no se encuentra registrado o se defini� como inactivo) para los datos - '
                     || ' Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || rec_Cabecero.FISUCURSAL
                     || ' N�mero de Transacci�n: '
                     || rec_Cabecero.FITRANNO
                     || ' Tipo de registro: '
                     || rec_Cabecero.FITRANTIPO;
                  RAISE exc_ErrGeneral;
               END IF;

               vl_CatTrans (rec_Cabecero.FITRANTIPO) :=
                  rec_Cabecero.FITRANTIPO;
            END IF;

            -- Mueve datos del cabecero a estructura.
            rec_Trancrecab.FIPAISID := pa_Pais;
            rec_Trancrecab.FICANAL := pa_Canal;
            rec_Trancrecab.FISUCURSAL := rec_Cabecero.FISUCURSAL;
            rec_Trancrecab.FITRANNO := rec_Cabecero.FITRANNO;
            rec_Trancrecab.FITRANTIPO := rec_Cabecero.FITRANTIPO;
            rec_Trancrecab.FICONSECTIPO := rec_Cabecero.FICONSECTIPO;
            rec_Trancrecab.FDTRANSFECHR := rec_Cabecero.FDTRANSFECHR;
            rec_Trancrecab.FCTRANWS := rec_Cabecero.FCTRANWS;
            rec_Trancrecab.FCTRANUSR := rec_Cabecero.FCTRANUSR;
            rec_Trancrecab.FITRANNOREG := rec_Cabecero.FITRANNOREG;
            rec_Trancrecab.FITRANSMIT := rec_Cabecero.FITRANSMIT;
            rec_Trancrecab.FDFECHARECEP := rec_Cabecero.FDFECHARECEP;

            -- Si hay registros en el detalle, se procesan
            IF rec_Cabecero.FITRANNOREG > csl_0
            THEN
               SCACTUALIZADORVT.PAACTUALIZADOR.
                SPDISPERSADETALLES (pa_Pais,
                                    pa_Canal,
                                    rec_Cabecero.FISUCURSAL,
                                    rec_Cabecero.FITRANNO,
                                    vl_EstSuc,
                                    vl_OraErrMesg,
                                    pa_OraErr,
                                    vl_ErrMsg,
                                    rec_Trancrecab,
                                    vl_RowidErr);          -- Procesa detalle.

               -- Valida error por operaciones duplicadas
               IF vl_EstSuc = csl_n1
               THEN
                  --vl_ErrId := 58;
                  vl_ErrMsg :=
                     'Advertencia Transaccion Duplicada, detalles de la transacci�n con los datos - Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || rec_Cabecero.FISUCURSAL
                     || ' Numero Transacci�n: '
                     || rec_Cabecero.FITRANNO
                     || ' Detalle de mensajes -> '
                     || CHR (csl_10)
                     || vl_ErrMsg;
                  vl_ErrProceso := 'DET';
                  vl_ErrId := NULL;
                  vl_EstSuc := NULL;
               --RAISE exc_ErrGeneral;
               END IF;


               -- Valida error
               IF vl_EstSuc = csl_0
               THEN
                  vl_ErrId := csl_58;
                  vl_ErrMsg :=
                     'Error en el procesamiento de detalles de la transacci�n con los datos - Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || rec_Cabecero.FISUCURSAL
                     || ' Numero Transacci�n: '
                     || rec_Cabecero.FITRANNO
                     || ' Detalle de mensajes -> '
                     || CHR (10)
                     || vl_ErrMsg;
                  vl_ErrProceso := 'DET';
                  RAISE exc_ErrGeneral;
               END IF;
            END IF;                            -- rec_Cabecero.fitrannoreg > 0

            -- Bloque eliminacion de cabecero
            BEGIN
               DELETE FROM SCACTUALIZADORVT.TATRNCRCB
                     WHERE ROWID = rec_Cabecero.ROWID;
            EXCEPTION
               WHEN OTHERS
               THEN
                  vl_ErrId := csl_28;
                  vl_ErrMsg :=
                     'Error al momento de eliminar el cabecero procesado de manera satisfactoria con los siguientes datos - Pa�s: '
                     || pa_Pais
                     || ' Canal: '
                     || pa_Canal
                     || ' Sucursal: '
                     || rec_Cabecero.FISUCURSAL
                     || ' Numero Transacci�n: '
                     || rec_Cabecero.FITRANNO
                     || ' para la eliminaci�n se utiliz� el ROWID: '
                     || rec_Cabecero.ROWID;
                  pa_OraErr := SQLCODE;
                  vl_OraErrMesg := SQLERRM;
                  RAISE exc_ErrGeneral;
            END;                             -- Bloque eliminacion de cabecero

            IF vl_ErrId IS NOT NULL
            THEN
               RAISE exc_ErrGeneral;
            END IF;

            --
            SCACTUALIZADORVT.PAACTUALIZADOR.
             SPACTCTRLCONSECTIPTRAN (pa_Pais,
                                     pa_Canal,
                                     rec_Cabecero.FISUCURSAL,
                                     rec_Cabecero.FITRANTIPO,
                                     rec_Cabecero.FICONSECTIPO,
                                     vl_FechaTransac,
                                     rec_Cabecero.FITRANNO,
                                     pa_OraErr,
                                     vl_OraErrMesg,
                                     vl_ErrId,
                                     vl_ErrMsg);

            IF vl_ErrId IS NOT NULL
            THEN
               RAISE exc_ErrGeneral;
            END IF;

            SCACTUALIZADORVT.PAACTUALIZADOR.
             SPACTUALIZACTRLSUCTRAN (pa_Pais,
                                     pa_Canal,
                                     rec_Cabecero.FISUCURSAL,
                                     rec_Cabecero.FDTRANSFECHR,
                                     rec_Cabecero.FITRANNO,
                                     vl_ErrProceso,
                                     pa_OraErr,
                                     vl_OraErrMesg,
                                     vl_ErrId,
                                     vl_ErrMsg);

            IF vl_ErrId IS NOT NULL
            THEN
               vl_ErrMsg :=
                  'Error al actualizar consecutivo de transacci�n con los siguientes datos - Pa�s: '
                  || pa_Pais
                  || ' Canal: '
                  || pa_Canal
                  || ' Sucursal: '
                  || rec_Cabecero.FISUCURSAL
                  || ' Numero Transacci�n: '
                  || rec_Cabecero.FITRANNO
                  || ' Detalle de mensajes -> '
                  || CHR (csl_10)
                  || vl_ErrMsg;
               RAISE exc_ErrGeneral;
            END IF;

            --
            SCACTUALIZADORVT.PAACTUALIZADOR.
             SPHISTORICOCABECERO (rec_Trancrecab,
                                  vl_RowidErr,
                                  vl_ErrProceso,
                                  pa_OraErr,
                                  vl_OraErrMesg,
                                  vl_ErrId,
                                  vl_ErrMsg,
                                  vl_FechaTransac);

            IF vl_ErrId IS NOT NULL
            THEN
               RAISE exc_ErrGeneral;
            END IF;

            --
            COMMIT;
         --
         EXCEPTION
            WHEN exc_ErrSucursal
            THEN
               NULL;
            WHEN exc_ErrGeneral
            THEN
               ROLLBACK;
               vl_EstSuc := csl_0;
            WHEN OTHERS
            THEN
               ROLLBACK;
               vl_EstSuc := csl_0;
               vl_ErrId := csl_0;
               vl_OraErrMesg := SQLERRM;
               pa_OraErr := SQLCODE;
         END;                  -- Bloque manejo de excepciones por transaccion

         -- Si existe error lo graba
         IF vl_ErrId IS NOT NULL
         THEN
            --
            vl_MenErrorFn :=
               SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (vl_ErrMsg,
                                                             pa_OraErr,
                                                             vl_OraErrMesg,
                                                             vl_ErrId,
                                                             vl_ErrProceso,
                                                             vl_RowidErr);
            vl_ErrId := NULL;
            SCACTUALIZADORVT.PAACTUALIZADOR.
             SPACTUALIZACTRLSUCERROR (vgRowidCtrlsuc,
                                      rec_Cabecero.FITRANNO,
                                      vl_ErrProceso,
                                      pa_OraErr,
                                      vl_OraErrMesg,
                                      vl_ErrId,
                                      vl_RowidErr);

            IF vl_ErrId IS NOT NULL
            THEN
               vl_MenErrorFn :=
                  SCACTUALIZADORVT.PAACTUALIZADOR.
                   FNGRABAERROR (vl_ErrMsg,
                                 pa_OraErr,
                                 vl_OraErrMesg,
                                 vl_ErrId,
                                 vl_ErrProceso,
                                 vl_RowidErr);
            END IF;

            vl_ErrId := NULL;
            SCACTUALIZADORVT.PAACTUALIZADOR.
             SPGRABAERRCAB (rec_Cabecero.ROWID,
                            pa_OraErr,
                            vl_OraErrMesg,
                            vl_ErrId,
                            vl_ErrMsg);

            IF vl_ErrId IS NOT NULL
            THEN
               vl_MenErrorFn :=
                  SCACTUALIZADORVT.PAACTUALIZADOR.
                   FNGRABAERROR (vl_ErrMsg,
                                 pa_OraErr,
                                 vl_OraErrMesg,
                                 vl_ErrId,
                                 vl_ErrProceso,
                                 vl_RowidErr);
            END IF;
         END IF;                                   -- Si existe error lo graba
      END LOOP;                                             -- Ciclo cabeceros
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_OraErr := SQLCODE;
         vl_OraErrMesg := SQLERRM;
         vl_MenErrorFn :=
            SCACTUALIZADORVT.PAACTUALIZADOR.FNGRABAERROR (vl_ErrMsg,
                                                          pa_OraErr,
                                                          vl_OraErrMesg,
                                                          csl_0    -- vl_ErrId
                                                               ,
                                                          vl_ErrProceso,
                                                          vl_RowidErr);
   END SPCTRLDISPERSION;



   PROCEDURE SPDISPERSATRANSAC (
      pa_SucursalIni   IN SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      pa_SucursalFin   IN SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE)
   IS
      /*******************************************************************************
        Proyecto:     GESTION DE CLIENTES
        Descripci�n:  Inicia procesamiento de transacciones
        Par�metros de Entrada: pa_SucursalIni  - Procesa transacciones desde la sucursal pa_SucursalIni
                               pa_SucursalFin  - Procesa transacciones hasta la sucursal pa_SucursalFin
        Par�metros de Salida:
        Valor de Retorno:
        Par�metros de Entrada-Salida:
        PreCondiciones:

        Creador:            Carolina P�rez Vite
        Fecha de Creaci�n:  Mayo 2018
      *******************************************************************************/

      CURSOR cur_TransacProc
      IS
           SELECT FIPAISID,
                  FICANAL,
                  MIN (FISUCURSAL) SUCINI,
                  MAX (FISUCURSAL) SUCFIN
             FROM SCACTUALIZADORVT.TATRNCRCB
            WHERE     FITRANSMIT = csl_0
                  AND FISUCURSAL > pa_SucursalIni
                  AND FISUCURSAL <= pa_SucursalFin
         GROUP BY FIPAISID, FICANAL;
   BEGIN
      FOR vlTransacProc IN cur_TransacProc
      LOOP
         SCACTUALIZADORVT.PAACTUALIZADOR.
          SPCTRLDISPERSION (vlTransacProc.FIPAISID,
                            vlTransacProc.FICANAL,
                            vlTransacProc.SUCINI,
                            vlTransacProc.SUCFIN);
      END LOOP;
   END SPDISPERSATRANSAC;
END PAACTUALIZADOR;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZADOR" TO "SCSISGES";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZADOR" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZADOR" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZADOR" TO "USRINFFENIX";
