<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="FenixTestsApplication">
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.marketing.ActiveCampaingsV2" Name="mx.com.elektra.fenixtestsapplication.marketing.ActiveCampaingsV2" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.marketing.ActiveCampaingsV2">
      <Inputs Id="c8985010-da4d-4b5d-af1f-e0719b441f2eFenixTestsApplication_mx.com.elektra.fenixtestsapplication.marketing.ActiveCampaingsV2_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/TAZSchema">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/TAZSchema"/>
          <Parameter Name="tns:branchId" type="string" nameSpace="http://www.example.org/TAZSchema"/>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.marketing.GetCampaignByCustomers" Name="mx.com.elektra.fenixtestsapplication.marketing.GetCampaignByCustomers" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.marketing.GetCampaignByCustomers">
      <Inputs Id="9e951f6a-b48b-40b0-9a8d-1f0a7ae322f2FenixTestsApplication_mx.com.elektra.fenixtestsapplication.marketing.GetCampaignByCustomers_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.module.Activator" Name="mx.com.elektra.fenixtestsapplication.module.Activator" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="onStartup" serviceName="ModuleActivator">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.module.Activator_onStartup_Request" Name="Request" isDefault="true"/>
    </Operation>
    <Operation Name="onShutdown" serviceName="ModuleActivator">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.module.Activator_onShutdown_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.sender.ProcessXMLTYPE" Name="mx.com.elektra.fenixtestsapplication.sender.ProcessXMLTYPE" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.sender.ProcessXMLTYPE">
      <Inputs Id="065e2fef-a84c-44e3-9220-57764d95af86FenixTestsApplication_mx.com.elektra.fenixtestsapplication.sender.ProcessXMLTYPE_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.Customer360" Name="mx.com.elektra.fenixtestsapplication.service.Customer360" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="post" serviceName="aiwendil-consulta-datos-cliente-tarjeta-1">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="post" serviceName="aiwendil-consulta-datos-cliente-cliente-unico-1">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="post" serviceName="aiwendil-consulta-foto-cliente-1">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="post" serviceName="aiwendil-busqueda-datos-cliente-nombre-completo-1">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="aiwendil-busqueda-datos-cliente-datos-basicos-1">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.Customer360Token" Name="mx.com.elektra.fenixtestsapplication.service.Customer360Token" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="post" serviceName="auth-v4-oauth-token">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Customer360Token_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.EmployeesHR" Name="mx.com.elektra.fenixtestsapplication.service.EmployeesHR" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="getEmpleadoGeneral" serviceName="EmpleadoGeneralSoap">
      <Inputs Id="ef71e319-a784-4ca5-a6a0-36793a21c0c9FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.EmployeesHR_getEmpleadoGeneral_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.Marketing" Name="mx.com.elektra.fenixtestsapplication.service.Marketing" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="post" serviceName="portfolio-client-campaigns">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Marketing_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="prd-portfolio-campaigns">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.Marketing_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.RegionalCredit" Name="mx.com.elektra.fenixtestsapplication.service.RegionalCredit" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="post" serviceName="wsregionalcobranza-sobregirodeconsumo-sobregirodeconsumo">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.RegionalCredit_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.service.TAZ" Name="mx.com.elektra.fenixtestsapplication.service.TAZ" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="get" serviceName="servlet-adn-EjeqQuery">
      <Inputs Id="FenixTestsApplication_mx.com.elektra.fenixtestsapplication.service.TAZ_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCU" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCU" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCU">
      <Inputs Id="97388138-0065-4c87-9c7c-a4087f4cd6a3FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCU_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" tnsName="tns:" nameSpace="xmlns:tns">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/Customer360Schema"/>
          <Parameter Name="tns:GetCustomerRequest" Value="&#xA;  ">
            <parameters Name="tns:pais" Value="1" type="string" nameSpace="http://www.example.org/Customer360Schema" canDelete="true"/>
            <parameters Name="tns:canal" Value="1" type="string" nameSpace="http://www.example.org/Customer360Schema" canDelete="true"/>
            <parameters Name="tns:sucursal" Value="1" type="string" nameSpace="http://www.example.org/Customer360Schema" canDelete="true"/>
            <parameters Name="tns:folio" Value="1" type="string" nameSpace="http://www.example.org/Customer360Schema" canDelete="true"/>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCard" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCard" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCard">
      <Inputs Id="5a0d736a-f4c8-45f9-ad01-3349f4c71a4fFenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForCard_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForName" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForName" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForName">
      <Inputs Id="0768555b-d34e-417b-935b-870e4aea5c77FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerForName_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerPhoto" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerPhoto" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerPhoto">
      <Inputs Id="844c23bf-b4b6-4117-bbe9-4e455db3e200FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerPhoto_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerSearch" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerSearch" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerSearch">
      <Inputs Id="ef65d573-fa82-42ec-a0fd-33f19732f549FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360.GetCustomerSearch_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.c360token.CreateC360Token" Name="mx.com.elektra.fenixtestsapplication.subprocesses.c360token.CreateC360Token" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.c360token.CreateC360Token">
      <Inputs Id="1e00d124-3202-45ca-a100-f82f9075df47FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.c360token.CreateC360Token_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.employees.InvokeEmployeeRH" Name="mx.com.elektra.fenixtestsapplication.subprocesses.employees.InvokeEmployeeRH" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.employees.InvokeEmployeeRH">
      <Inputs Id="f4d12506-e047-41d7-99ed-fda30e0beb5cFenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.employees.InvokeEmployeeRH_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.regionalcredit.OverdrawCollection" Name="mx.com.elektra.fenixtestsapplication.subprocesses.regionalcredit.OverdrawCollection" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.regionalcredit.OverdrawCollection">
      <Inputs Id="1db78c6e-13b7-4106-8017-8718c1770aa9FenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.regionalcredit.OverdrawCollection_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.subprocesses.taz.CreditServlet" Name="mx.com.elektra.fenixtestsapplication.subprocesses.taz.CreditServlet" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.subprocesses.taz.CreditServlet">
      <Inputs Id="3b90705f-d2fb-4e65-aa46-12764e0c5feaFenixTestsApplication_mx.com.elektra.fenixtestsapplication.subprocesses.taz.CreditServlet_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.ActiveCampaignsV2" Name="pruebas.ActiveCampaignsV2" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.ActiveCampaignsV2">
      <Inputs Id="3bbfdad2-1192-4452-ae9d-e9ca6541d2f7FenixTestsApplication_pruebas.ActiveCampaignsV2_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.example.org/TAZSchema">
          <nameSpaces prefix="tns" nameSapce="http://www.example.org/TAZSchema"/>
          <Parameter Name="tns:branchId" Value="2024" type="string" nameSpace="http://www.example.org/TAZSchema"/>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.CreateC360Token" Name="pruebas.CreateC360Token" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.CreateC360Token">
      <Inputs Id="12f9b583-eba3-43a4-b7d7-21ff46b99783FenixTestsApplication_pruebas.CreateC360Token_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCampaignsByCustomer" Name="pruebas.GetCampaignsByCustomer" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCampaignsByCustomer">
      <Inputs Id="c087c0fe-67d4-4ef2-87c7-9ec3f03ba181FenixTestsApplication_pruebas.GetCampaignsByCustomer_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCustomerForCU" Name="pruebas.GetCustomerForCU" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCustomerForCU">
      <Inputs Id="07b7c972-80d2-4616-a6bd-e0cf1750321aFenixTestsApplication_pruebas.GetCustomerForCU_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCustomerForCart" Name="pruebas.GetCustomerForCart" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCustomerForCart">
      <Inputs Id="154c4e20-d07d-4da8-84b6-dd58656acb3dFenixTestsApplication_pruebas.GetCustomerForCart_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCustomerForName" Name="pruebas.GetCustomerForName" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCustomerForName">
      <Inputs Id="4f12c2b2-4f35-48ca-a666-e426a4fa491cFenixTestsApplication_pruebas.GetCustomerForName_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCustomerPhoto" Name="pruebas.GetCustomerPhoto" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCustomerPhoto">
      <Inputs Id="27d25ed3-d895-42b9-9db1-dc34e0bb629cFenixTestsApplication_pruebas.GetCustomerPhoto_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.GetCustomerSearch" Name="pruebas.GetCustomerSearch" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.GetCustomerSearch">
      <Inputs Id="562c358c-c8d8-4065-886e-3b414ecde59dFenixTestsApplication_pruebas.GetCustomerSearch_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="pruebas.OverdrawCollection" Name="pruebas.OverdrawCollection" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="pruebas.OverdrawCollection">
      <Inputs Id="82f5ef15-b830-4e30-bdb3-93adbcc5eebcFenixTestsApplication_pruebas.OverdrawCollection_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.sender.SenderSimulator" Name="mx.com.elektra.fenixtestsapplication.sender.SenderSimulator" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.sender.SenderSimulator">
      <Inputs Id="67da11b3-e36b-4d59-a8f7-736d5091b801FenixTestsApplication_mx.com.elektra.fenixtestsapplication.sender.SenderSimulator_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.fenixtestsapplication.sender.SendBranch" Name="mx.com.elektra.fenixtestsapplication.sender.SendBranch" ModelType="BW" moduleName="FenixTestsApplication">
    <Operation Name="callProcess" serviceName="mx.com.elektra.fenixtestsapplication.sender.SendBranch">
      <Inputs Id="33670590-7706-4d14-8e40-230a20a3f5a3FenixTestsApplication_mx.com.elektra.fenixtestsapplication.sender.SendBranch_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
