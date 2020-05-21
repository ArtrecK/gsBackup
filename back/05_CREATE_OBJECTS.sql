ALTER SESSION SET CONTAINER = ORCLPDB1;
PROMPT **************************************************************************************
PROMPT CREACION DE TABLAS SCVENTASTIENDA
PROMPT **************************************************************************************
@SCVENTASTIENDA/TYPES/TYCABECEROTXN.sql;
@SCVENTASTIENDA/TYPES/TYCABTXNGEN.sql;
@SCVENTASTIENDA/TYPES/TYDETALLETXN.sql;
@SCVENTASTIENDA/TYPES/TYOBEMPLEADOOBJ.sql;
@SCVENTASTIENDA/TYPES/TYOBPRODUCTO.sql;
@SCVENTASTIENDA/TYPES/TYTABCABTXNGEN.sql;
@SCVENTASTIENDA/TYPES/TYTBEMPLEADOOBJ.sql;
@SCVENTASTIENDA/TYPES/TYTBPRODUCTO.sql;
@SCVENTASTIENDA/TYPES/TYTRANSACCION.sql;
@SCVENTASTIENDA/TABLES/CENLINEACRED.sql;
@SCVENTASTIENDA/TABLES/CRECTEUNICPED.sql;
@SCVENTASTIENDA/TABLES/CREDLINEACRED.sql;
@SCVENTASTIENDA/TABLES/PEDIDOS_CREDITO.sql;
@SCVENTASTIENDA/TABLES/TACENCTETIENDA.sql;
@SCVENTASTIENDA/TABLES/TACLIENTES.sql;
@SCVENTASTIENDA/TABLES/TACLIENTESHTRIA.sql;
@SCVENTASTIENDA/TABLES/TACREDCLIENHST.sql;
@SCVENTASTIENDA/TABLES/TACREDCLIENTES.sql;
@SCVENTASTIENDA/TABLES/TACREDCTECTEHTR.sql;
@SCVENTASTIENDA/TABLES/TACREDCTECTES.sql;
@SCVENTASTIENDA/TABLES/TACREDINVES.sql;
@SCVENTASTIENDA/TABLES/TACREDITO.sql;
@SCVENTASTIENDA/TABLES/TACREDSOLICITUD.sql;
@SCVENTASTIENDA/TABLES/TACREDVTATIENDA.sql;
@SCVENTASTIENDA/TABLES/TACTETIENDAHIST.sql;
@SCVENTASTIENDA/TABLES/TADETPEDIDOS.sql;
@SCVENTASTIENDA/TABLES/TADETPREPARAM.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0010.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0012.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0050.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0060.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0070.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0075.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0100.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0110.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0115.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0120.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0185.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0208.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0210.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0215.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0217.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_0220.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4361.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4368.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4380.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4381.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4462.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4633.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_4719.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_5320.sql;
@SCVENTASTIENDA/TABLES/TAEST01001_7422.sql;
@SCVENTASTIENDA/TABLES/TAESTATUSPEDIDO.sql;
@SCVENTASTIENDA/TABLES/TAESTSOLICITUD.sql;
@SCVENTASTIENDA/TABLES/TAMOVPEDIDOS.sql;
@SCVENTASTIENDA/TABLES/TAPEDCIFRASCTRL.sql;
@SCVENTASTIENDA/TABLES/TAPEDIDOS.sql;
@SCVENTASTIENDA/TABLES/TAPREPARAME.sql;
@SCVENTASTIENDA/TABLES/TAPREPARAMEHTR.sql;
@SCVENTASTIENDA/TABLES/TASOLICITUDES.sql;
@SCVENTASTIENDA/TABLES/TATIPOVENTA.sql;
@SCVENTASTIENDA/TABLES/TATRANSAC_ERROR.sql;
@SCVENTASTIENDA/TABLES/TATXNERROR_TMP.sql;
@SCVENTASTIENDA/TABLES/TCLINEA.sql;
@SCVENTASTIENDA/TABLES/TCPERIODOSPARAM.sql;
@SCVENTASTIENDA/TABLES/TCPRODUCTO.sql;
@SCVENTASTIENDA/TABLES/TCSUCURSAL.sql;
@SCVENTASTIENDA/INDEXES/IDX01PERIODOSPA.sql;
@SCVENTASTIENDA/INDEXES/IDX02PERIODOSPA.sql;
@SCVENTASTIENDA/INDEXES/IDXPREPARAHIST1.sql;
@SCVENTASTIENDA/INDEXES/IDXPREPARAHIST2.sql;
@SCVENTASTIENDA/INDEXES/IDXPREPARAHIST3.sql;
@SCVENTASTIENDA/INDEXES/IDXPREPARAHIST4.sql;
@SCVENTASTIENDA/INDEXES/IDXPREPARAHIST5.sql;
@SCVENTASTIENDA/INDEXES/IDXTAESTSOLDESC.sql;
@SCVENTASTIENDA/INDEXES/IDXTAESTSOLEST.sql;
@SCVENTASTIENDA/INDEXES/IDX_CRECTEPD01.sql;
@SCVENTASTIENDA/INDEXES/IDX_CRECTEPD02.sql;
@SCVENTASTIENDA/INDEXES/IDX_CRECTEPD03.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDLIN001.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDLIN002.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDLIN003.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDLIN004.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDVTA1.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDVTA2.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDVTA3.sql;
@SCVENTASTIENDA/INDEXES/IDX_CREDVTA4.sql;
@SCVENTASTIENDA/INDEXES/IDX_LINEACRED01.sql;
@SCVENTASTIENDA/INDEXES/IDX_LINEACRED02.sql;
@SCVENTASTIENDA/INDEXES/IDX_LINEACRED03.sql;
@SCVENTASTIENDA/INDEXES/IDX_PEDCIFRAS1.sql;
@SCVENTASTIENDA/INDEXES/IDX_PEDCIFRAS2.sql;
@SCVENTASTIENDA/INDEXES/IDX_PEDCIFRAS3.sql;
@SCVENTASTIENDA/INDEXES/IDX_PREPARM002.sql;
@SCVENTASTIENDA/INDEXES/IDX_PREPARM004.sql;
@SCVENTASTIENDA/INDEXES/IDX_TACRCTEST04.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATRANSAC01.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATRANSAC02.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATRANSAC03.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATRANSAC04.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATXNERR01.sql;
@SCVENTASTIENDA/INDEXES/IDX_TATXNERR02.sql;
@SCVENTASTIENDA/INDEXES/IDX_TBCLIENTES1.sql;
@SCVENTASTIENDA/INDEXES/IX01CATPRODUCTO.sql;
@SCVENTASTIENDA/INDEXES/IX02CATPRODUCTO.sql;
@SCVENTASTIENDA/INDEXES/IX03CATPRODUCTO.sql;
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED01.sql;
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED02.sql;
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED03.sql;
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED04.sql;
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED05.sql;
@SCVENTASTIENDA/INDEXES/IXPREPARAME.sql;
@SCVENTASTIENDA/INDEXES/IXSUCURSALHTR.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDCLCL.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDCLCLHTR.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDCLCLN.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDCLCLNHT.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDINVES.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDSOLICI.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDSOLSOL.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDSOLST.sql;
@SCVENTASTIENDA/INDEXES/IXTACREDSOLSTAT.sql;
@SCVENTASTIENDA/INDEXES/IXTAPEDIDOSTDA.sql;
@SCVENTASTIENDA/INDEXES/IXTAPREPARAME02.sql;
@SCVENTASTIENDA/INDEXES/IXTAPREPARAME03.sql;
@SCVENTASTIENDA/INDEXES/IXTASOLICITUDES.sql;
@SCVENTASTIENDA/INDEXES/IXTASOLICITUEMP.sql;
@SCVENTASTIENDA/INDEXES/IXTASOLICITUNEG.sql;
@SCVENTASTIENDA/INDEXES/IXTCLINEA01.sql;
@SCVENTASTIENDA/INDEXES/IXTCLINEADESC.sql;
@SCVENTASTIENDA/INDEXES/IXTCLINEAPROD.sql;
@SCVENTASTIENDA/INDEXES/IXTCSUCURSAL.sql;
@SCVENTASTIENDA/INDEXES/IX_CTETIENDAH01.sql;
@SCVENTASTIENDA/INDEXES/IX_CTETIENDAH02.sql;
@SCVENTASTIENDA/INDEXES/IX_CTETIENDAH03.sql;
@SCVENTASTIENDA/INDEXES/IX_TAPEDIDOS_01.sql;
@SCVENTASTIENDA/INDEXES/IX_TAPEDIDOS_02.sql;
@SCVENTASTIENDA/INDEXES/IX_TCENCTSTDA01.sql;
@SCVENTASTIENDA/INDEXES/IX_TCENCTSTDA02.sql;
@SCVENTASTIENDA/INDEXES/IX_TCENCTSTDA03.sql;
@SCVENTASTIENDA/INDEXES/IX_TCRDCLTHIST.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDCLCL.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDCLCLHTR.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDCLIENTE.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDCTEHIST.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDINVES.sql;
@SCVENTASTIENDA/INDEXES/PKTACREDSOLICI.sql;
@SCVENTASTIENDA/INDEXES/PKTADETALLEPED.sql;
@SCVENTASTIENDA/INDEXES/PKTADETPREPARAM.sql;
@SCVENTASTIENDA/INDEXES/PKTAESTATUSSOLI.sql;
@SCVENTASTIENDA/INDEXES/PKTAMOVPEDIDOS.sql;
@SCVENTASTIENDA/INDEXES/PKTAPREPARAME.sql;
@SCVENTASTIENDA/INDEXES/PKTASOLICITUDES.sql;
@SCVENTASTIENDA/INDEXES/PK_TACLIENTES.sql;
@SCVENTASTIENDA/INDEXES/PK_TACLIENTESHT.sql;
@SCVENTASTIENDA/INDEXES/PK_TACREDITO.sql;
@SCVENTASTIENDA/INDEXES/PK_TAPEDIDOS.sql;

-- *** DEPENDENCIAS DE OTROS ESQUEMAS NECESARIAS PARA LA COMPILACION ***
PROMPT **************************************************************************************
PROMPT CREACION DE DEPENDENCIAS DE SCVENTASTIENDA CON SCSISGES
PROMPT **************************************************************************************
@SCSISGES/TYPES/OBJDETGES.sql;
@SCSISGES/TYPES/OBJGEOALERTA.sql;
@SCSISGES/TYPES/TBDETGES.sql;
@SCSISGES/TYPES/TBGEOALERTA.sql;
@SCSISGES/TYPES/TYOBGESTIONACUM.sql;
@SCSISGES/TYPES/TYOBGESTIONBRANCH.sql;
@SCSISGES/TYPES/TYOBGESTREGION.sql;
@SCSISGES/TYPES/TYOBGETFUNCTE.sql;
@SCSISGES/TYPES/TYOBGSTCUS.sql;
@SCSISGES/TYPES/TYOBJCALENDARIO.sql;
@SCSISGES/TYPES/TYOBJGEOGRAFIA.sql;
@SCSISGES/TYPES/TYOBJGEOGRAFIAEKT.sql;
@SCSISGES/TYPES/TYOBJLOG.sql;
@SCSISGES/TYPES/TYOBPRODUCTO.sql;
@SCSISGES/TYPES/TYTBCALENDARIO.sql;
@SCSISGES/TYPES/TYTBGEOGRAFIAEKT.sql;
@SCSISGES/TYPES/TYTBGEOGRAFIAS.sql;
@SCSISGES/TYPES/TYTBGESTIONACUM.sql;
@SCSISGES/TYPES/TYTBGESTIONBRANCH.sql;
@SCSISGES/TYPES/TYTBGESTREGION.sql;
@SCSISGES/TYPES/TYTBGSTCU.sql;
@SCSISGES/TYPES/TYTBLOG.sql;
@SCSISGES/TYPES/TYTBPRODUCTO.sql;
@SCSISGES/TYPES/TYTGETFUNCTE.sql;
@SCSISGES/TYPES/TYTPERFILALERTA.sql;
@SCSISGES/SEQUENCES/SEQALERTA.sql;
@SCSISGES/SEQUENCES/SEQCAMBACEO.sql;
@SCSISGES/SEQUENCES/SEQCEVENTO.sql;
@SCSISGES/SEQUENCES/SEQEVENTO.sql;
@SCSISGES/SEQUENCES/SEQGEOALERTA.sql;
@SCSISGES/SEQUENCES/SEQGESTION.sql;
@SCSISGES/SEQUENCES/SEQLOGCOLERR.sql;
@SCSISGES/SEQUENCES/SEQMOMFELICES.sql;
@SCSISGES/SEQUENCES/SEQPARAMETRO.sql;
@SCSISGES/SEQUENCES/SEQTIDELEFONO.sql;
@SCSISGES/SEQUENCES/SEQ_TABUZON.sql;
@SCSISGES/SEQUENCES/SQCAMBACEO.sql;
@SCSISGES/TABLES/TAALERTA.sql;
@SCSISGES/TABLES/TAALERTACLIENTE.sql;
@SCSISGES/TABLES/TAALERTAPERSONA.sql;
@SCSISGES/TABLES/TABUZON.sql;
@SCSISGES/TABLES/TABUZONDETALLE.sql;
@SCSISGES/TABLES/TACAMPANA.sql;
@SCSISGES/TABLES/TACAMPANACTE.sql;
@SCSISGES/TABLES/TACECOGEOGRAFIA.sql;
@SCSISGES/TABLES/TACGESNIVELGEO.sql;
@SCSISGES/TABLES/TACGESOPCIONES.sql;
@SCSISGES/TABLES/TACGESOPTCAMBA.sql;
@SCSISGES/TABLES/TACGESOPTMEDIOS.sql;
@SCSISGES/TABLES/TACGESOPTRESULT.sql;
@SCSISGES/TABLES/TACGESOPTSCRIPT.sql;
@SCSISGES/TABLES/TACGESPERIODOS.sql;
@SCSISGES/TABLES/TACLIENTEFINADO.sql;
@SCSISGES/TABLES/TADATOSMAIL.sql;
@SCSISGES/TABLES/TADATOSTELEFONO.sql;
@SCSISGES/TABLES/TAEMPALERTA.sql;
@SCSISGES/TABLES/TAEMPLEADO.sql;
@SCSISGES/TABLES/TAEMPLEADOPF.sql;
@SCSISGES/TABLES/TAEMPLEADOSEM.sql;
@SCSISGES/TABLES/TAEVENTGEST.sql;
@SCSISGES/TABLES/TAEVENTO.sql;
@SCSISGES/TABLES/TAFOLIOTELEFONO.sql;
@SCSISGES/TABLES/TAFXCAMPANASMKT.sql;
@SCSISGES/TABLES/TAFXCAMPANASPF.sql;
@SCSISGES/TABLES/TAFXCAMPREPPF.sql;
@SCSISGES/TABLES/TAFXCARTERAPF.sql;
@SCSISGES/TABLES/TAFXCLIENTESPF.sql;
@SCSISGES/TABLES/TAFXREGIONES.sql;
@SCSISGES/TABLES/TAFXTERRITORIOS.sql;
@SCSISGES/TABLES/TAFXUSUARIOSPF.sql;
@SCSISGES/TABLES/TAFXZONAS.sql;
@SCSISGES/TABLES/TAGEOALERTA.sql;
@SCSISGES/TABLES/TAGEOALERTAH_TMP.sql;
@SCSISGES/TABLES/TAGEOALERTAOLD.sql;
@SCSISGES/TABLES/TAGEOGRAFBAZEKT.sql;
@SCSISGES/TABLES/TAGESTION.sql;
@SCSISGES/TABLES/TALIGAS.sql;
@SCSISGES/TABLES/TALOGCOLERR.sql;
@SCSISGES/TABLES/TALOGERRORES.sql;
@SCSISGES/TABLES/TAOBJETIVOEMP.sql;
@SCSISGES/TABLES/TAOBJETIVOPAIS.sql;
@SCSISGES/TABLES/TAOBJETIVOREG.sql;
@SCSISGES/TABLES/TAOBJETIVOS.sql;
@SCSISGES/TABLES/TAOBJETIVOSUC.sql;
@SCSISGES/TABLES/TAOBJETIVOTER.sql;
@SCSISGES/TABLES/TAOBJETIVOZON.sql;
@SCSISGES/TABLES/TAPARAMETROS.sql;
@SCSISGES/TABLES/TAPERFALERTA.sql;
@SCSISGES/TABLES/TAPROMOCIONES.sql;
@SCSISGES/TABLES/TAPROMOCIONPASO.sql;
@SCSISGES/TABLES/TAPROMOHIST.sql;
@SCSISGES/TABLES/TASTATALERTA.sql;
@SCSISGES/TABLES/TATELEFONOS.sql;
@SCSISGES/TABLES/TAURL.sql;
@SCSISGES/TABLES/TAUSUARIOMODULO.sql;
@SCSISGES/TABLES/TAVENTASACUM.sql;
@SCSISGES/TABLES/TAVENTASACUMHIST.sql;
@SCSISGES/TABLES/TAVENTASACUMOPE.sql;
@SCSISGES/TABLES/TAVENTASEMANAL.sql;
@SCSISGES/TABLES/TCCALENDARIOEKT.sql;
@SCSISGES/TABLES/TCCAMPANAMKT.sql;
@SCSISGES/TABLES/TCCATBUZON.sql;
@SCSISGES/TABLES/TCCATCAMBACEO.sql;
@SCSISGES/TABLES/TCCONCEPTO.sql;
@SCSISGES/TABLES/TCCONTROLJOBS.sql;
@SCSISGES/TABLES/TCDESCGESTION.sql;
@SCSISGES/TABLES/TCESTATUSBUZON.sql;
@SCSISGES/TABLES/TCESTATUSCATBUZ.sql;
@SCSISGES/TABLES/TCEVENTO.sql;
@SCSISGES/TABLES/TCFXSUCURSAL.sql;
@SCSISGES/TABLES/TCIDCOSTO.sql;
@SCSISGES/TABLES/TCLABORADESC.sql;
@SCSISGES/TABLES/TCLINEA.sql;
@SCSISGES/TABLES/TCMEDIOGESTION.sql;
@SCSISGES/TABLES/TCMODULO.sql;
@SCSISGES/TABLES/TCMOMFELICES.sql;
@SCSISGES/TABLES/TCPAIS.sql;
@SCSISGES/TABLES/TCPERFILESEMP.sql;
@SCSISGES/TABLES/TCPRODUCTO_TMP.sql;
@SCSISGES/TABLES/TCRESULTGESTION.sql;
@SCSISGES/TABLES/TCSCRIPT.sql;
@SCSISGES/TABLES/TCSUCURSAL.sql;
@SCSISGES/TABLES/TCTIPOALCANCE.sql;
@SCSISGES/TABLES/TCTIPOGESTION.sql;
@SCSISGES/TABLES/TCTIPOTELEFONOS.sql;
@SCSISGES/TABLES/TCTIPOUSUARIO.sql;
@SCSISGES/TABLES/TCUSUARIO.sql;
@SCSISGES/TABLES/TCUSUARIOADMIN.sql;
@SCSISGES/TABLES/THEMPLEADOPF.sql;
@SCSISGES/TABLES/THOBJETIVOEMP.sql;
@SCSISGES/TABLES/TTCAMPANACTE.sql;
@SCSISGES/INDEXES/CTGESOPTSCRIPT.sql;
@SCSISGES/INDEXES/IDX01ALERTP.sql;
@SCSISGES/INDEXES/IDX01GEOALERTA.sql;
@SCSISGES/INDEXES/IDX02ALERTP.sql;
@SCSISGES/INDEXES/IDX02CARTAS.sql;
@SCSISGES/INDEXES/IDX02GEOALERTA.sql;
@SCSISGES/INDEXES/IDX02_SCRIPT.sql;
@SCSISGES/INDEXES/IDX03ALERTP.sql;
@SCSISGES/INDEXES/IDX03GEOALERTA.sql;
@SCSISGES/INDEXES/IDX04ALERTP.sql;
@SCSISGES/INDEXES/IDX04GEOALERTA.sql;
@SCSISGES/INDEXES/IDX1TALOGCOLERR.sql;
@SCSISGES/INDEXES/IDX2TALOGCOLERR.sql;
@SCSISGES/INDEXES/IDXPKPERFALERTA.sql;
@SCSISGES/INDEXES/IDXPK_STATALERT.sql;
@SCSISGES/INDEXES/IDX_ALERTAINAC.sql;
@SCSISGES/INDEXES/IDX_ALTAFINADO.sql;
@SCSISGES/INDEXES/IDX_CTEFINADO.sql;
@SCSISGES/INDEXES/IDX_EMPFUN.sql;
@SCSISGES/INDEXES/IDX_EMPGER.sql;
@SCSISGES/INDEXES/IDX_EMPHISFUN.sql;
@SCSISGES/INDEXES/IDX_EMPHISGER.sql;
@SCSISGES/INDEXES/IDX_EMPHISSUC.sql;
@SCSISGES/INDEXES/IDX_EMPLEADO.sql;
@SCSISGES/INDEXES/IDX_EMPLEADOHIS.sql;
@SCSISGES/INDEXES/IDX_EMPNUMFIN.sql;
@SCSISGES/INDEXES/IDX_EMPSUC.sql;
@SCSISGES/INDEXES/IDX_FECHABUZDET.sql;
@SCSISGES/INDEXES/IDX_FECHABUZON.sql;
@SCSISGES/INDEXES/IDX_FICATBUZON.sql;
@SCSISGES/INDEXES/IDX_FIDSUCURSAL.sql;
@SCSISGES/INDEXES/IDX_INACBUZDET.sql;
@SCSISGES/INDEXES/IDX_INACBUZON.sql;
@SCSISGES/INDEXES/IDX_LABORAID.sql;
@SCSISGES/INDEXES/IDX_LABORAINAC.sql;
@SCSISGES/INDEXES/IDX_LOGERROR_01.sql;
@SCSISGES/INDEXES/IDX_MODINAC.sql;
@SCSISGES/INDEXES/IDX_MODULO.sql;
@SCSISGES/INDEXES/IDX_OBJEMP.sql;
@SCSISGES/INDEXES/IDX_OBJEMPH.sql;
@SCSISGES/INDEXES/IDX_OBJFEC.sql;
@SCSISGES/INDEXES/IDX_OBJFECH.sql;
@SCSISGES/INDEXES/IDX_OBJGEO.sql;
@SCSISGES/INDEXES/IDX_OBJGEOH.sql;
@SCSISGES/INDEXES/IDX_OBJPAIFEC.sql;
@SCSISGES/INDEXES/IDX_OBJPAIGEO.sql;
@SCSISGES/INDEXES/IDX_OBJPAISEM.sql;
@SCSISGES/INDEXES/IDX_OBJREGFEC.sql;
@SCSISGES/INDEXES/IDX_OBJREGGEO.sql;
@SCSISGES/INDEXES/IDX_OBJREGSEM.sql;
@SCSISGES/INDEXES/IDX_OBJSEM.sql;
@SCSISGES/INDEXES/IDX_OBJSEMH.sql;
@SCSISGES/INDEXES/IDX_OBJSUC.sql;
@SCSISGES/INDEXES/IDX_OBJSUCFEC.sql;
@SCSISGES/INDEXES/IDX_OBJSUCGEO.sql;
@SCSISGES/INDEXES/IDX_OBJSUCH.sql;
@SCSISGES/INDEXES/IDX_OBJSUCSEM.sql;
@SCSISGES/INDEXES/IDX_OBJSUCSUC.sql;
@SCSISGES/INDEXES/IDX_OBJTERFEC.sql;
@SCSISGES/INDEXES/IDX_OBJTERGEO.sql;
@SCSISGES/INDEXES/IDX_OBJTERSEM.sql;
@SCSISGES/INDEXES/IDX_OBJZONFEC.sql;
@SCSISGES/INDEXES/IDX_OBJZONGEO.sql;
@SCSISGES/INDEXES/IDX_OBJZONSEM.sql;
@SCSISGES/INDEXES/IDX_PLANTILLA.sql;
@SCSISGES/INDEXES/IDX_STATUSFIN.sql;
@SCSISGES/INDEXES/IDX_SUCBUZON.sql;
@SCSISGES/INDEXES/IDX_TABUZON.sql;
@SCSISGES/INDEXES/IDX_TABUZONDET.sql;
@SCSISGES/INDEXES/IDX_TCESTBUZON.sql;
@SCSISGES/INDEXES/IDX_TCESTCATBUZ.sql;
@SCSISGES/INDEXES/IDX_TIPOBUZDET.sql;
@SCSISGES/INDEXES/IDX_TIPOUSRID.sql;
@SCSISGES/INDEXES/IDX_TIPOUSRINAC.sql;
@SCSISGES/INDEXES/IDX_USRINACTIVO.sql;
@SCSISGES/INDEXES/IDX_USRMODINAC.sql;
@SCSISGES/INDEXES/IDX_USUARIO.sql;
@SCSISGES/INDEXES/IDX_USUARIOMOD.sql;
@SCSISGES/INDEXES/IDX_VENEMP.sql;
@SCSISGES/INDEXES/IDX_VENEMPHIST.sql;
@SCSISGES/INDEXES/IDX_VENEMPOPE.sql;
@SCSISGES/INDEXES/IDX_VENFEC.sql;
@SCSISGES/INDEXES/IDX_VENFECHIST.sql;
@SCSISGES/INDEXES/IDX_VENFECOPE.sql;
@SCSISGES/INDEXES/IDX_VENLIN.sql;
@SCSISGES/INDEXES/IDX_VENLINHIST.sql;
@SCSISGES/INDEXES/IDX_VENLINOPE.sql;
@SCSISGES/INDEXES/IDX_VTASEMEMP.sql;
@SCSISGES/INDEXES/IDX_VTASEMJER.sql;
@SCSISGES/INDEXES/IDX_VTASEMSEM.sql;
@SCSISGES/INDEXES/IDX_VTASEMSUC.sql;
@SCSISGES/INDEXES/IX001CGACC.sql;
@SCSISGES/INDEXES/IX002CGACC.sql;
@SCSISGES/INDEXES/IX003CGACC.sql;
@SCSISGES/INDEXES/IX004CGACC.sql;
@SCSISGES/INDEXES/IX005CGACC.sql;
@SCSISGES/INDEXES/IX01CALENDARIOE.sql;
@SCSISGES/INDEXES/IX01CAMPANACTE.sql;
@SCSISGES/INDEXES/IX01CAMPANAMKT.sql;
@SCSISGES/INDEXES/IX01CATPAIS.sql;
@SCSISGES/INDEXES/IX01CECOGEO.sql;
@SCSISGES/INDEXES/IX01CONTROLJOBS.sql;
@SCSISGES/INDEXES/IX01FOLIOTEL.sql;
@SCSISGES/INDEXES/IX01FXCAMPANAPF.sql;
@SCSISGES/INDEXES/IX01FXCAMPREPPF.sql;
@SCSISGES/INDEXES/IX01FXCARTERAPF.sql;
@SCSISGES/INDEXES/IX01FXCTESPF.sql;
@SCSISGES/INDEXES/IX01FXUSUARIOPF.sql;
@SCSISGES/INDEXES/IX01GEOALERTASH.sql;
@SCSISGES/INDEXES/IX01GESTIONES.sql;
@SCSISGES/INDEXES/IX01GESTOPCION.sql;
@SCSISGES/INDEXES/IX01OBJETIVOS.sql;
@SCSISGES/INDEXES/IX01PFCAMPAMKT.sql;
@SCSISGES/INDEXES/IX01TACAMPANA.sql;
@SCSISGES/INDEXES/IX01TAFXREGION.sql;
@SCSISGES/INDEXES/IX01TAFXZONAS.sql;
@SCSISGES/INDEXES/IX01TCAMPANACTE.sql;
@SCSISGES/INDEXES/IX01TCEVENTO.sql;
@SCSISGES/INDEXES/IX01TCFXSUC.sql;
@SCSISGES/INDEXES/IX01TCPERFILES.sql;
@SCSISGES/INDEXES/IX01TELEFONOS.sql;
@SCSISGES/INDEXES/IX01TERRITORIO.sql;
@SCSISGES/INDEXES/IX01TIPOTEL.sql;
@SCSISGES/INDEXES/IX02CALENDARIOE.sql;
@SCSISGES/INDEXES/IX02CAMPANACTE.sql;
@SCSISGES/INDEXES/IX02CAMPANAMKT.sql;
@SCSISGES/INDEXES/IX02CATPAIS.sql;
@SCSISGES/INDEXES/IX02CECOGEO.sql;
@SCSISGES/INDEXES/IX02CONTROLJOBS.sql;
@SCSISGES/INDEXES/IX02FOLIOTEL.sql;
@SCSISGES/INDEXES/IX02FXCAMPANAPF.sql;
@SCSISGES/INDEXES/IX02FXCAMPREPPF.sql;
@SCSISGES/INDEXES/IX02FXCARTERAPF.sql;
@SCSISGES/INDEXES/IX02FXCTESPF.sql;
@SCSISGES/INDEXES/IX02FXUSUARIOPF.sql;
@SCSISGES/INDEXES/IX02GEOALERTASH.sql;
@SCSISGES/INDEXES/IX02GESCOPTMED.sql;
@SCSISGES/INDEXES/IX02GESNIVELGEO.sql;
@SCSISGES/INDEXES/IX02GESOPTRESUL.sql;
@SCSISGES/INDEXES/IX02GESPERIODOS.sql;
@SCSISGES/INDEXES/IX02GESTIONES.sql;
@SCSISGES/INDEXES/IX02OBJETIVOS.sql;
@SCSISGES/INDEXES/IX02PFCAMPAMKT.sql;
@SCSISGES/INDEXES/IX02TAEVENTO.sql;
@SCSISGES/INDEXES/IX02TAFXREGION.sql;
@SCSISGES/INDEXES/IX02TAFXZONAS.sql;
@SCSISGES/INDEXES/IX02TCAMPANACTE.sql;
@SCSISGES/INDEXES/IX02TCEVENTO.sql;
@SCSISGES/INDEXES/IX02TCFXSUC.sql;
@SCSISGES/INDEXES/IX02TCIDCOSTO.sql;
@SCSISGES/INDEXES/IX02TCPERFILES.sql;
@SCSISGES/INDEXES/IX02TCUSUARIO.sql;
@SCSISGES/INDEXES/IX02TELEFONOS.sql;
@SCSISGES/INDEXES/IX02TERRITORIO.sql;
@SCSISGES/INDEXES/IX02TIPOTEL.sql;
@SCSISGES/INDEXES/IX03CAMPANACTE.sql;
@SCSISGES/INDEXES/IX03CAMPANAMKT.sql;
@SCSISGES/INDEXES/IX03CECOGEO.sql;
@SCSISGES/INDEXES/IX03CONTROLJOBS.sql;
@SCSISGES/INDEXES/IX03FOLIOTEL.sql;
@SCSISGES/INDEXES/IX03FXCAMPANAPF.sql;
@SCSISGES/INDEXES/IX03FXCAMPREPPF.sql;
@SCSISGES/INDEXES/IX03FXCARTERAPF.sql;
@SCSISGES/INDEXES/IX03FXCTESPF.sql;
@SCSISGES/INDEXES/IX03FXUSUARIOPF.sql;
@SCSISGES/INDEXES/IX03GESPERIODOS.sql;
@SCSISGES/INDEXES/IX03GESTIONES.sql;
@SCSISGES/INDEXES/IX03GESTOPCION.sql;
@SCSISGES/INDEXES/IX03PFCAMPAMKT.sql;
@SCSISGES/INDEXES/IX03TCAMPANACTE.sql;
@SCSISGES/INDEXES/IX03TCFXSUC.sql;
@SCSISGES/INDEXES/IX03TCIDCOSTO.sql;
@SCSISGES/INDEXES/IX03TCPERFILES.sql;
@SCSISGES/INDEXES/IX03TELEFONOS.sql;
@SCSISGES/INDEXES/IX03TERRITORIO.sql;
@SCSISGES/INDEXES/IX04CAMPANACTE.sql;
@SCSISGES/INDEXES/IX04CAMPANAMKT.sql;
@SCSISGES/INDEXES/IX04CECOGEO.sql;
@SCSISGES/INDEXES/IX04CONTROLJOBS.sql;
@SCSISGES/INDEXES/IX04FXCAMPREPPF.sql;
@SCSISGES/INDEXES/IX04FXCARTERAPF.sql;
@SCSISGES/INDEXES/IX04FXCTESPF.sql;
@SCSISGES/INDEXES/IX04TCAMPANACTE.sql;
@SCSISGES/INDEXES/IX04TCFXSUC.sql;
@SCSISGES/INDEXES/IX04TELEFONOS.sql;
@SCSISGES/INDEXES/IX05CONTROLJOBS.sql;
@SCSISGES/INDEXES/IX05FXCAMPREPPF.sql;
@SCSISGES/INDEXES/IX05FXCARTERAPF.sql;
@SCSISGES/INDEXES/IX05TCAMPANACTE.sql;
@SCSISGES/INDEXES/IX05TCFXSUC.sql;
@SCSISGES/INDEXES/IXEMPLEADO.sql;
@SCSISGES/INDEXES/IXFNLINEA.sql;
@SCSISGES/INDEXES/IXFUNCION.sql;
@SCSISGES/INDEXES/IXGERENTE.sql;
@SCSISGES/INDEXES/IXGESCOPTCAMBA.sql;
@SCSISGES/INDEXES/IXGESOPTSCRIPT.sql;
@SCSISGES/INDEXES/IXMEDIOGESTION.sql;
@SCSISGES/INDEXES/IXTADATOSMAIL.sql;
@SCSISGES/INDEXES/IXTADATOSTEL.sql;
@SCSISGES/INDEXES/IXTAEVENTO.sql;
@SCSISGES/INDEXES/IXTAPROMOCION01.sql;
@SCSISGES/INDEXES/IXTAPROMOHIST01.sql;
@SCSISGES/INDEXES/IXTAPROMOPASO.sql;
@SCSISGES/INDEXES/IXTCIDCOSTOCTRO.sql;
@SCSISGES/INDEXES/IXTCRESULTGEST.sql;
@SCSISGES/INDEXES/IXTCUSUARIO.sql;
@SCSISGES/INDEXES/IX_ALERTASEMP01.sql;
@SCSISGES/INDEXES/IX_ALERTASEMP09.sql;
@SCSISGES/INDEXES/IX_CALERTA01.sql;
@SCSISGES/INDEXES/IX_CALERTAS01.sql;
@SCSISGES/INDEXES/IX_TAPROMOCION02.sql;
@SCSISGES/INDEXES/PKEVENTGEST.sql;
@SCSISGES/INDEXES/PKGESCOPTMEDIOS.sql;
@SCSISGES/INDEXES/PKGESNIVELGEO.sql;
@SCSISGES/INDEXES/PKGESOPCIONES.sql;
@SCSISGES/INDEXES/PKGESOPTRESULT.sql;
@SCSISGES/INDEXES/PKGESPERIODOS.sql;
@SCSISGES/INDEXES/PKGESTIONES.sql;
@SCSISGES/INDEXES/PKLIGAS.sql;
@SCSISGES/INDEXES/PKMEDIOGESTION.sql;
@SCSISGES/INDEXES/PKRESULTGESTION.sql;
@SCSISGES/INDEXES/PKTAEVENTO.sql;
@SCSISGES/INDEXES/PKTCTPALCANCE.sql;
@SCSISGES/INDEXES/PKTIPOGESTION.sql;
@SCSISGES/INDEXES/PK_CAMPANACTE.sql;
@SCSISGES/INDEXES/PK_TCCATIMAGEN.sql;
@SCSISGES/INDEXES/PK_TCSCRIPT.sql;
@SCSISGES/INDEXES/UIDXALERTCLIENT.sql;
@SCSISGES/INDEXES/UIDXDSCGSTN.sql;
@SCSISGES/INDEXES/UIDXLOGCOLERR.sql;

@SCSISGES/PACKAGES/PATYPES.sql
@SCSISGES/PROCEDURES/SPERRORES.sql
@SCSISGES/PACKAGES/PAALERTAS0001.sql
@SCSISGES/PACKAGES/PQSISGESALERTAS.sql
@SCSISGES/PACKAGE_BODIES/PAALERTAS0001.sql
@SCSISGES/PACKAGE_BODIES/PQSISGESALERTAS.sql

PROMPT **************************************************************************************
PROMPT CREACION DE TYPES Y PROCEDURES SCVENTASTIENDA
PROMPT **************************************************************************************
@SCVENTASTIENDA/PACKAGES/PAAPPLICATION.sql;
@SCVENTASTIENDA/PACKAGES/PAFXTRUNCAMAPASVT.sql;
@SCVENTASTIENDA/PACKAGES/PAGOALS.sql;
@SCVENTASTIENDA/PACKAGES/PAPRODUCT.sql;
@SCVENTASTIENDA/PACKAGES/PASUPERVISION.sql;
@SCVENTASTIENDA/PACKAGES/PATYPES.sql;
@SCVENTASTIENDA/PACKAGES/PAUTILERIAS.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PAAPPLICATION.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PAFXTRUNCAMAPASVT.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PAGOALS.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PAPRODUCT.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PASUPERVISION.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PAUTILERIAS.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0010.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0012.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0050.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0060.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0070.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0075.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0100.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0110.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0115.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0120.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0185.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0208.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0210.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0217.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_0220.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4361.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4368.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4380.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4381.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4462.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4633.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_4719.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_5320.sql;
@SCVENTASTIENDA/PROCEDURES/SP01001_7422.sql;
@SCVENTASTIENDA/PROCEDURES/SPINVOCATXNERROR.sql;
@SCVENTASTIENDA/PROCEDURES/SPTRANSACERROR.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_10.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_100.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_110.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_115.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_12.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_120.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_185.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_210.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_217.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_220.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_2320.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_2353.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4361.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4368.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4376.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4381.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4462.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4480.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_4610.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_50.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_60.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_70.sql;
@SCVENTASTIENDA/TYPES/TYHIJOREG_75.sql;
@SCVENTASTIENDA/TYPES/TYOBPEDPENDIENT.sql;
@SCVENTASTIENDA/TYPES/TYOBPRESUPUESTO.sql;
@SCVENTASTIENDA/TYPES/TYTBPEDPENDIENT.sql;
@SCVENTASTIENDA/TYPES/TYTBPRESUPUESTO.sql;
@SCVENTASTIENDA/PACKAGES/PQSBGESTION0010.sql;
@SCVENTASTIENDA/PACKAGE_BODIES/PQSBGESTION0010.sql;


PROMPT **************************************************************************************
PROMPT CREACION DE TYPES SCSISGES
PROMPT **************************************************************************************
@SCSISGES/PACKAGES/PAFICHACLTE.sql;
@SCSISGES/PACKAGES/PAGOALS.sql;
@SCSISGES/PACKAGES/PAINSERTAREPORTES.sql;
@SCSISGES/PACKAGES/PALOGCOLERR.sql;
@SCSISGES/PACKAGES/PALOGIN.sql;
@SCSISGES/PACKAGES/PAMOMENTS.sql;
@SCSISGES/PACKAGES/PAPARAMETROS.sql;
@SCSISGES/PACKAGES/PAREPORTES0002.sql;
@SCSISGES/PACKAGES/PASUPERVISION.sql;
@SCSISGES/PACKAGES/PATYPES.sql;
@SCSISGES/PACKAGES/PQPKLIGAS.sql;
@SCSISGES/PACKAGE_BODIES/PAFICHACLTE.sql;
@SCSISGES/PACKAGE_BODIES/PAGOALS.sql;
@SCSISGES/PACKAGE_BODIES/PAINSERTAREPORTES.sql;
@SCSISGES/PACKAGE_BODIES/PALOGCOLERR.sql;
@SCSISGES/PACKAGE_BODIES/PALOGIN.sql;
@SCSISGES/PACKAGE_BODIES/PAMOMENTS.sql;
@SCSISGES/PACKAGE_BODIES/PAPARAMETROS.sql;
@SCSISGES/PACKAGE_BODIES/PAREPORTES0002.sql;
@SCSISGES/PACKAGE_BODIES/PASUPERVISION.sql;
@SCSISGES/PACKAGE_BODIES/PQPKLIGAS.sql;
@SCSISGES/PROCEDURES/SPCONSULTAPROC.sql;
@SCSISGES/PROCEDURES/SPERRORES.sql;
@SCSISGES/FUNCTIONS/FNCOAGENDADIA.sql;
@SCSISGES/FUNCTIONS/FNCOALERTASDIA.sql;
@SCSISGES/FUNCTIONS/FNCOEVENTOSDIA.sql;
@SCSISGES/FUNCTIONS/FNCOGESTIONDIA.sql;
@SCSISGES/FUNCTIONS/FNCONTROLPROCESOS.sql;
@SCSISGES/FUNCTIONS/FNCOPPXSTDIA.sql;
@SCSISGES/FUNCTIONS/FNCOPRESUTDIA.sql;
@SCSISGES/FUNCTIONS/FNCOPROMOCTDIA.sql;
@SCSISGES/FUNCTIONS/FNCOSINPEDTDIA.sql;
@SCSISGES/FUNCTIONS/FNCOSOLICTDIA.sql;
@SCSISGES/FUNCTIONS/FNFXGETCTESGEST.sql;
@SCSISGES/FUNCTIONS/FNGETGESTDIARIO.sql;
@SCSISGES/FUNCTIONS/FNGETGESTIONES.sql;
@SCSISGES/FUNCTIONS/FNGETPENDXSURTIR.sql;
@SCSISGES/FUNCTIONS/FNGETPRESUPUESTOS.sql;
@SCSISGES/FUNCTIONS/FNGETPROMOCIONES.sql;
@SCSISGES/FUNCTIONS/FNGETREACTIVACIONES.sql;
@SCSISGES/FUNCTIONS/FNGETSOLICITUDES.sql;
@SCSISGES/FUNCTIONS/FNOBTIENESEMANA.sql;
@SCSISGES/PACKAGES/PAALERTAS0001.sql;
@SCSISGES/PACKAGES/PABUZONQYS.sql;
@SCSISGES/PACKAGES/PACAMPAIGN.sql;
@SCSISGES/PACKAGES/PACAMPANASMKT.sql;
@SCSISGES/PACKAGES/PACONTACT.sql;
@SCSISGES/PACKAGES/PAFXGESTIONDIA.sql;
@SCSISGES/PACKAGES/PAGEOGRAFIA.sql;
@SCSISGES/PACKAGES/PAGESTACUMULADO.sql;
@SCSISGES/PACKAGES/PAGESTIONSUCURSAL.sql;
@SCSISGES/PACKAGES/PAGETCAMPANAS.sql;
@SCSISGES/PACKAGES/PAJERARQUIAOBJ.sql;
@SCSISGES/PACKAGES/PAOBJETIVOSSEM.sql;
@SCSISGES/PACKAGES/PAPROCESAOBJETIVOS.sql;
@SCSISGES/PACKAGES/PAREPORTES0001.sql;
@SCSISGES/PACKAGES/PAVTASSEMANALES.sql;
@SCSISGES/PACKAGES/PQCLIENTEFINADO.sql;
@SCSISGES/PACKAGES/PQFXCALENDARIOEKT.sql;
@SCSISGES/PACKAGES/PQFXGEOGRAFIAMXEKT.sql;
@SCSISGES/PACKAGES/PQFXJOBCECOGEOGRAFIA.sql;
@SCSISGES/PACKAGES/PQFXJOBGEOGRAFIA.sql;
@SCSISGES/PACKAGES/PQFXMDGEOGRAFIA.sql;
@SCSISGES/PACKAGES/PQFXVERIFICACIONTEL.sql;
@SCSISGES/PACKAGES/PQFXWFMIGRACIONPF.sql;
@SCSISGES/PACKAGES/PQPLANTILLAEMPLEADOS.sql;
@SCSISGES/PACKAGES/PQSBGESTION0001.sql;
@SCSISGES/PACKAGES/PQSBGESTION0002.sql;
@SCSISGES/PACKAGES/PQSBGESTION0003.sql;
@SCSISGES/PACKAGES/PQSISGESALERTAS.sql;
@SCSISGES/PACKAGE_BODIES/PAALERTAS0001.sql;
@SCSISGES/PACKAGE_BODIES/PABUZONQYS.sql;
@SCSISGES/PACKAGE_BODIES/PACAMPAIGN.sql;
@SCSISGES/PACKAGE_BODIES/PACAMPANASMKT.sql;
@SCSISGES/PACKAGE_BODIES/PACONTACT.sql;
@SCSISGES/PACKAGE_BODIES/PAFXGESTIONDIA.sql;
@SCSISGES/PACKAGE_BODIES/PAGEOGRAFIA.sql;
@SCSISGES/PACKAGE_BODIES/PAGESTACUMULADO.sql;
@SCSISGES/PACKAGE_BODIES/PAGESTIONSUCURSAL.sql;
@SCSISGES/PACKAGE_BODIES/PAGETCAMPANAS.sql;
@SCSISGES/PACKAGE_BODIES/PAJERARQUIAOBJ.sql;
@SCSISGES/PACKAGE_BODIES/PAOBJETIVOSSEM.sql;
@SCSISGES/PACKAGE_BODIES/PAPROCESAOBJETIVOS.sql;
@SCSISGES/PACKAGE_BODIES/PAREPORTES0001.sql;
@SCSISGES/PACKAGE_BODIES/PAVTASSEMANALES.sql;
@SCSISGES/PACKAGE_BODIES/PQCLIENTEFINADO.sql;
@SCSISGES/PACKAGE_BODIES/PQFXCALENDARIOEKT.sql;
@SCSISGES/PACKAGE_BODIES/PQFXGEOGRAFIAMXEKT.sql;
@SCSISGES/PACKAGE_BODIES/PQFXJOBCECOGEOGRAFIA.sql;
@SCSISGES/PACKAGE_BODIES/PQFXJOBGEOGRAFIA.sql;
@SCSISGES/PACKAGE_BODIES/PQFXMDGEOGRAFIA.sql;
@SCSISGES/PACKAGE_BODIES/PQFXVERIFICACIONTEL.sql;
@SCSISGES/PACKAGE_BODIES/PQFXWFMIGRACIONPF.sql;
@SCSISGES/PACKAGE_BODIES/PQPLANTILLAEMPLEADOS.sql;
@SCSISGES/PACKAGE_BODIES/PQSBGESTION0001.sql;
@SCSISGES/PACKAGE_BODIES/PQSBGESTION0002.sql;
@SCSISGES/PACKAGE_BODIES/PQSBGESTION0003.sql;
@SCSISGES/PACKAGE_BODIES/PQSISGESALERTAS.sql;
@SCSISGES/PACKAGES/PAEVENTS.sql;
@SCSISGES/PACKAGE_BODIES/PAEVENTS.sql;

PROMPT **************************************************************************************
PROMPT CREACION DE TYPES SCACTUALIZADORVT
PROMPT **************************************************************************************

@SCACTUALIZADORVT/TYPES/TYPTRANCRECAB.sql;
@SCACTUALIZADORVT/TYPES/TYPTRANCREDET.sql;
@SCACTUALIZADORVT/TYPES/TYPTRANDETALLE.sql;
@SCACTUALIZADORVT/TYPES/TYP_ESTRUCTURA_TAEST.sql;
@SCACTUALIZADORVT/TYPES/TYP_TRANCRECAB.sql;
@SCACTUALIZADORVT/TYPES/TYP_TRANCREDET.sql;
@SCACTUALIZADORVT/TABLES/TACATTRANSACCION.sql;
@SCACTUALIZADORVT/TABLES/TACAT_ERROR.sql;
@SCACTUALIZADORVT/TABLES/TACAT_SP.sql;
@SCACTUALIZADORVT/TABLES/TACTRLERRORES.sql;
@SCACTUALIZADORVT/TABLES/TACTRLSUC.sql;
@SCACTUALIZADORVT/TABLES/TACTRLTIPTRANS.sql;
@SCACTUALIZADORVT/TABLES/TAERRORHIST_LOG.sql;
@SCACTUALIZADORVT/TABLES/TAERROR_LOG.sql;
@SCACTUALIZADORVT/TABLES/TAERROR_LOG_TMP.sql;
@SCACTUALIZADORVT/TABLES/TAREGISTRO.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCB.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBE.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBEHIST.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBE_TMP.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBH.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBHL.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRCBH_TMP.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDT.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTE.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTEHIST.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTE_TMP.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTH.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTHL.sql;
@SCACTUALIZADORVT/TABLES/TATRNCRDTH_TMP.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0001.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0002.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0003.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0004.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0005.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0006.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0007.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0008.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0010.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0011.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0012.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0013.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0014.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0015.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0016.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANCBE01.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANCBE02.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANCBE03.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANDET01.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANDET02.sql;
@SCACTUALIZADORVT/INDEXES/IDXTATRANDET03.sql;
@SCACTUALIZADORVT/INDEXES/IX001CRECABHIST.sql;
@SCACTUALIZADORVT/INDEXES/IX001CREDETHIST.sql;
@SCACTUALIZADORVT/INDEXES/IX_TATRANCRECAB_ERR_02.sql;
@SCACTUALIZADORVT/INDEXES/IX_TATRANCREDET_ERR_02.sql;
@SCACTUALIZADORVT/PACKAGES/PADEPURACION.sql;
@SCACTUALIZADORVT/PACKAGES/PATYPES.sql;
@SCACTUALIZADORVT/PACKAGES/PAUTIL.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PADEPURACION.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAUTIL.sql;
@SCACTUALIZADORVT/TYPES/ARR_ESTRUCTURA_TAEST.sql;
@SCACTUALIZADORVT/TYPES/TBTRANCREDET.sql;
@SCACTUALIZADORVT/TYPES/TB_STRUC_TAEST.sql;
@SCACTUALIZADORVT/TABLES/TACATESTRUCTURA.sql;
@SCACTUALIZADORVT/INDEXES/IDXACT0009.sql;
@SCACTUALIZADORVT/INDEXES/PK_ESTRU.sql;
@SCACTUALIZADORVT/PACKAGES/PAACTUALIZADOR.sql;
@SCACTUALIZADORVT/PACKAGES/PADISTRIBUCIONTRANSAC.sql;
@SCACTUALIZADORVT/PACKAGES/PAESTRUCTURA.sql;
@SCACTUALIZADORVT/PACKAGES/PAMONITOREO0001.sql;
@SCACTUALIZADORVT/PACKAGES/PAMONITOREO0002.sql;
@SCACTUALIZADORVT/PACKAGES/PAMONITOREO0003.sql;
@SCACTUALIZADORVT/PACKAGES/PAMONITOREO0004.sql;
@SCACTUALIZADORVT/PACKAGES/PAMONITOREO0005.sql;
@SCACTUALIZADORVT/PACKAGES/PAREGISTRO.sql;
@SCACTUALIZADORVT/PACKAGES/PATRANSACCION.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAACTUALIZADOR.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PADISTRIBUCIONTRANSAC.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAESTRUCTURA.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAMONITOREO0001.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAMONITOREO0002.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAMONITOREO0003.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAMONITOREO0004.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAMONITOREO0005.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAREGISTRO.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PATRANSACCION.sql;
@SCACTUALIZADORVT/PACKAGES/PAACTUALIZA0002.sql;
@SCACTUALIZADORVT/PACKAGES/PADETALLETRANERROR.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAACTUALIZA0002.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PADETALLETRANERROR.sql;
@SCACTUALIZADORVT/PACKAGES/PAACTUALIZA0001.sql;
@SCACTUALIZADORVT/PACKAGES/PAACTUALIZAERRORES.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAACTUALIZA0001.sql;
@SCACTUALIZADORVT/PACKAGE_BODIES/PAACTUALIZAERRORES.sql;

PROMPT **************************************************************************************
PROMPT SPRINT 31
PROMPT **************************************************************************************
/*
@SCACTUALIZADORVT/PACKAGES/PACATESTRUCTURA.sql
@SCACTUALIZADORVT/PACKAGE_BODIES/PACATESTRUCTURA.sql
@SCSISGES/TYPES/TYOBGESTIONACUM.sql
@SCSISGES/TYPES/TYOBGESTIONES.sql
@SCSISGES/TYPES/TYTBGESTIONACUM.sql
@SCSISGES/TYPES/TYTBGESTIONES.sql
@SCSISGES/INDEXES/IDX02_CONTGESXEMP.sql
@SCSISGES/INDEXES/IDX02_CONTGESXREGION.sql
@SCSISGES/INDEXES/IDX02_CONTGESXSUC.sql
@SCSISGES/INDEXES/IDX02_CONTGESXZONA.sql
@SCSISGES/INDEXES/IDX_CONTGESXEMP.sql
@SCSISGES/INDEXES/IDX_CONTGESXPAIS.sql
@SCSISGES/INDEXES/IDX_CONTGESXREGION.sql
@SCSISGES/INDEXES/IDX_CONTGESXSUC.sql
@SCSISGES/INDEXES/IDX_CONTGESXZONA.sql
@SCSISGES/INDEXES/IDX_OBJEMP.sql
@SCSISGES/INDEXES/IDX_OBJEMPH.sql
@SCSISGES/INDEXES/IDX_OBJFEC.sql
@SCSISGES/INDEXES/IDX_OBJFECH.sql
@SCSISGES/INDEXES/IDX_OBJGEO.sql
@SCSISGES/INDEXES/IDX_OBJGEOH.sql
@SCSISGES/INDEXES/IDX_OBJPAIFEC.sql
@SCSISGES/INDEXES/IDX_OBJPAIGEO.sql
@SCSISGES/INDEXES/IDX_OBJPAISEM.sql
@SCSISGES/INDEXES/IDX_OBJREGFEC.sql
@SCSISGES/INDEXES/IDX_OBJREGGEO.sql
@SCSISGES/INDEXES/IDX_OBJREGSEM.sql
@SCSISGES/INDEXES/IDX_OBJSEM.sql
@SCSISGES/INDEXES/IDX_OBJSEMH.sql
@SCSISGES/INDEXES/IDX_OBJSUC.sql
@SCSISGES/INDEXES/IDX_OBJSUCFEC.sql
@SCSISGES/INDEXES/IDX_OBJSUCGEO.sql
@SCSISGES/INDEXES/IDX_OBJSUCH.sql
@SCSISGES/INDEXES/IDX_OBJSUCSEM.sql
@SCSISGES/INDEXES/IDX_OBJSUCSUC.sql
@SCSISGES/INDEXES/IDX_OBJTERFEC.sql
@SCSISGES/INDEXES/IDX_OBJTERGEO.sql
@SCSISGES/INDEXES/IDX_OBJTERSEM.sql
@SCSISGES/INDEXES/IDX_OBJZONFEC.sql
@SCSISGES/INDEXES/IDX_OBJZONGEO.sql
@SCSISGES/INDEXES/IDX_OBJZONSEM.sql
@SCSISGES/INDEXES/IDX_VENEMPHIST.sql
@SCSISGES/INDEXES/IDX_VENEMPOPE.sql
@SCSISGES/INDEXES/IDX_VENFECHIST.sql
@SCSISGES/INDEXES/IDX_VENFECOPE.sql
@SCSISGES/INDEXES/IDX_VENLINHIST.sql
@SCSISGES/INDEXES/IDX_VENLINOPE.sql
@SCSISGES/INDEXES/IDX_VTASEMEMP.sql
@SCSISGES/INDEXES/IDX_VTASEMJER.sql
@SCSISGES/INDEXES/IDX_VTASEMSEM.sql
@SCSISGES/INDEXES/IDX_VTASEMSUC.sql
@SCSISGES/INDEXES/PK_OBJETIVOREG.sql
@SCSISGES/INDEXES/PK_OBJETIVOSUC.sql
@SCSISGES/INDEXES/PK_OBJETIVOZON.sql




@SCSISGES/FUNCTIONS/FNCOAGENDADIA.sql
@SCSISGES/FUNCTIONS/FNCOALERTASDIA.sql
@SCSISGES/FUNCTIONS/FNCOEVENTOSDIA.sql
@SCSISGES/FUNCTIONS/FNCOGESTIONDIA.sql
@SCSISGES/FUNCTIONS/FNCOPPXSTDIA.sql
@SCSISGES/FUNCTIONS/FNCOPRESUTDIA.sql
@SCSISGES/FUNCTIONS/FNCOPROMOCTDIA.sql
@SCSISGES/FUNCTIONS/FNCOSINPEDTDIA.sql
@SCSISGES/FUNCTIONS/FNCOSOLICTDIA.sql
@SCSISGES/PACKAGES/PAACUMULAGESTIONES.sql
@SCSISGES/PACKAGES/PAFXGESTIONDIA.sql
@SCSISGES/PACKAGES/PAFXGESTSEMANAL.sql
@SCSISGES/PACKAGES/PAGEOGRAFIA.sql
@SCSISGES/PACKAGES/PAPOCOBJETIVOS.sql
@SCSISGES/PACKAGES/PAPROCESAOBJETIVOS.sql
@SCSISGES/PACKAGES/PQPFSISGESTION.sql
@SCSISGES/PACKAGES/TEST_PAFXGESTIONDIA.sql
@SCSISGES/PACKAGES/TEST_PAFXGESTSEMANAL.sql
@SCSISGES/PACKAGES/TEST_PAGEOGRAFIA.sql
@SCSISGES/PACKAGES/TEST_PAOBJETIVOS.sql
@SCSISGES/PACKAGES/TEST_PAPROCESAOBJETIVOS.sql
@SCSISGES/PACKAGES/TEST_PAVTASSEMANALES.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAACUMULAGESTIONES.sql
@SCSISGES/PACKAGE_BODIES/PAACUMULAGESTIONES.sql
@SCSISGES/PACKAGE_BODIES/PAFXGESTIONDIA.sql
@SCSISGES/PACKAGE_BODIES/PAFXGESTSEMANAL.sql
@SCSISGES/PACKAGE_BODIES/PAGEOGRAFIA.sql
@SCSISGES/PACKAGE_BODIES/PAPOCOBJETIVOS.sql
@SCSISGES/PACKAGE_BODIES/PAPROCESAOBJETIVOS.sql
@SCSISGES/PACKAGE_BODIES/PQPFSISGESTION.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAACUMULAGESTIONES.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAFXGESTIONDIA.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAFXGESTSEMANAL.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAGEOGRAFIA.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAOBJETIVOS.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAPROCESAOBJETIVOS.sql
@SCSISGES/PACKAGE_BODIES/TEST_PAVTASSEMANALES.sql
@SCSISGES/CONSTRAINTS/TACONTGESXEMP.sql
@SCSISGES/CONSTRAINTS/TACONTGESXPAIS.sql
@SCSISGES/CONSTRAINTS/TACONTGESXREGION.sql
@SCSISGES/CONSTRAINTS/TACONTGESXSUC.sql
@SCSISGES/CONSTRAINTS/TACONTGESXZONA.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOEMP.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOPAIS.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOREG.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOSRESP.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOSUC.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOTER.sql
@SCSISGES/CONSTRAINTS/TAOBJETIVOZON.sql
@SCSISGES/CONSTRAINTS/TAVENDVTASEMANAL.sql
@SCSISGES/CONSTRAINTS/TAVENTASACUMHIST.sql
@SCSISGES/CONSTRAINTS/TAVENTASACUMOPE.sql
@SCSISGES/CONSTRAINTS/TAVENTASACUMRESPALDO.sql
@SCSISGES/CONSTRAINTS/THOBJETIVOEMP.sql
@SCVENTASTIENDA/TABLES/TATXNERROR_TMP.sql
@SCVENTASTIENDA/TYPES/TYCABTXNGEN.sql
@SCVENTASTIENDA/TYPES/TYDETTXNGEN.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_2320.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4361.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4368.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4376.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4380.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4381.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4462.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_4480.sql
@SCVENTASTIENDA/TYPES/TYHIJOREG_60.sql
@SCVENTASTIENDA/TYPES/TYTABCABTXNGEN.sql
@SCVENTASTIENDA/TYPES/TYTABDETTXNGEN.sql
@SCVENTASTIENDA/INDEXES/IDX_CENLINEA1.sql
@SCVENTASTIENDA/INDEXES/IDX_CENLINEA2.sql
@SCVENTASTIENDA/INDEXES/IDX_CENLINEAC3.sql
@SCVENTASTIENDA/INDEXES/IDX_CRECTEPD2.sql
@SCVENTASTIENDA/INDEXES/IDX_CRECTEPD3.sql
@SCVENTASTIENDA/INDEXES/IDX_CREDLINE02.sql
@SCVENTASTIENDA/INDEXES/IDX_CREDLINE03.sql
@SCVENTASTIENDA/INDEXES/IDX_PKCRECTEP1.sql
@SCVENTASTIENDA/INDEXES/IDX_PKCREDLIN01.sql
@SCVENTASTIENDA/INDEXES/IDX_PREPARM002.sql
@SCVENTASTIENDA/INDEXES/IDX_PREPARM004.sql
@SCVENTASTIENDA/INDEXES/IDX_TATXNERR01.sql
@SCVENTASTIENDA/INDEXES/IDX_TATXNERR02.sql
@SCVENTASTIENDA/INDEXES/IDX_TATXNERR03.sql
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED01.sql
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED02.sql
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED03.sql
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED04.sql
@SCVENTASTIENDA/INDEXES/IXD_PEDCRED05.sql
@SCVENTASTIENDA/INDEXES/IXTACREDSOLST.sql
@SCVENTASTIENDA/INDEXES/IXTACREDSOLSTAT.sql
@SCVENTASTIENDA/INDEXES/IXTAPREPARAME02.sql
@SCVENTASTIENDA/INDEXES/IXTAPREPARAME03.sql
@SCVENTASTIENDA/INDEXES/IXTASOLICITUEMP.sql
@SCVENTASTIENDA/PROCEDURES/SPINVOCATXNERROR.sql
@SCVENTASTIENDA/PROCEDURES/SPMUEVETRANSACERROR.sql
@SCVENTASTIENDA/PROCEDURES/SPPROCESAERRTXN.sql
@SCVENTASTIENDA/CONSTRAINTS/TATXNERROR_TMP.sql

*/