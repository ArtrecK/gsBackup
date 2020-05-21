<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="TimerManagementApplication.module">
  <ProcessNode Id="mx.com.elektra.timermanagement.ceco.ExecuteSP" Name="mx.com.elektra.timermanagement.ceco.ExecuteSP" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.ceco.ExecuteSP">
      <Inputs Id="dc286528-e7fa-46d3-a4aa-7751975b11e3TimerManagementApplication.module_mx.com.elektra.timermanagement.ceco.ExecuteSP_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.ceco.ProcessRecord" Name="mx.com.elektra.timermanagement.ceco.ProcessRecord" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.ceco.ProcessRecord">
      <Inputs Id="a17ad255-c223-4317-b26e-1b12afcd146dTimerManagementApplication.module_mx.com.elektra.timermanagement.ceco.ProcessRecord_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.ceco.StatusQuery" Name="mx.com.elektra.timermanagement.ceco.StatusQuery" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.ceco.StatusQuery">
      <Inputs Id="c02faae9-4de6-4038-b2fa-b50adfe7b8e7TimerManagementApplication.module_mx.com.elektra.timermanagement.ceco.StatusQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.nextbestoffer.UpdateData" Name="mx.com.elektra.timermanagement.nextbestoffer.UpdateData" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.nextbestoffer.UpdateData">
      <Inputs Id="13835f09-aaa1-4e1f-ad8c-7204de3720efTimerManagementApplication.module_mx.com.elektra.timermanagement.nextbestoffer.UpdateData_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.portfolio.CollectionManagement" Name="mx.com.elektra.timermanagement.portfolio.CollectionManagement" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.portfolio.CollectionManagement">
      <Inputs Id="cbd9bf03-70b0-4507-b8e4-5a650a7e0a68TimerManagementApplication.module_mx.com.elektra.timermanagement.portfolio.CollectionManagement_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.InsertReports" Name="mx.com.elektra.timermanagement.reports.InsertReports" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.InsertReports">
      <Inputs Id="586e4190-fc62-4a0e-bd6b-826b8bc03b58TimerManagementApplication.module_mx.com.elektra.timermanagement.reports.InsertReports_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPInterface" Name="mx.com.elektra.timermanagement.reports.SPInterface" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPInterface">
      <Inputs Id="4c936d00-a22d-4baa-a052-43589097fac7TimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPInterface_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPPENDXSURTIR" Name="mx.com.elektra.timermanagement.reports.SPPENDXSURTIR" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPPENDXSURTIR">
      <Inputs Id="d4d42402-93d7-46ef-b7be-657ea3a8ffabTimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPPENDXSURTIR_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPPRESUPUESTOS" Name="mx.com.elektra.timermanagement.reports.SPPRESUPUESTOS" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPPRESUPUESTOS">
      <Inputs Id="b3eceace-c379-4f6b-892d-991fac66c58aTimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPPRESUPUESTOS_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPPROMOCIONES" Name="mx.com.elektra.timermanagement.reports.SPPROMOCIONES" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPPROMOCIONES">
      <Inputs Id="0db1c414-e5f0-40b5-8e96-9e8f1b468471TimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPPROMOCIONES_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPREACTIVACIONES" Name="mx.com.elektra.timermanagement.reports.SPREACTIVACIONES" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPREACTIVACIONES">
      <Inputs Id="68e3ddd0-2907-4d0e-9d1f-8d1bbc260450TimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPREACTIVACIONES_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.reports.SPSOLICITUDES" Name="mx.com.elektra.timermanagement.reports.SPSOLICITUDES" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.reports.SPSOLICITUDES">
      <Inputs Id="b8669b85-dc2f-48a2-ade8-d476876cc0b8TimerManagementApplication.module_mx.com.elektra.timermanagement.reports.SPSOLICITUDES_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.services.SchedulerResource" Name="mx.com.elektra.timermanagement.services.SchedulerResource" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="post" serviceName="scheduler-ceco">
      <Inputs Id="82c7c25b-542d-417c-b821-0e59d584095cTimerManagementApplication.module_mx.com.elektra.timermanagement.services.SchedulerResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="post" serviceName="scheduler-reports">
      <Inputs Id="7c11dc06-3654-49be-8114-4f874b9b22f9TimerManagementApplication.module_mx.com.elektra.timermanagement.services.SchedulerResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.transaction.Transaction" Name="mx.com.elektra.timermanagement.transaction.Transaction" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.transaction.Transaction">
      <Inputs Id="c552c261-9f49-4ecb-bc06-2e95f6066314TimerManagementApplication.module_mx.com.elektra.timermanagement.transaction.Transaction_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.timermanagement.utility.ValidateExecution" Name="mx.com.elektra.timermanagement.utility.ValidateExecution" ModelType="BW" moduleName="TimerManagementApplication.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.timermanagement.utility.ValidateExecution">
      <Inputs Id="56f631cd-7f73-4d04-9b6e-b4fd85e62cf2TimerManagementApplication.module_mx.com.elektra.timermanagement.utility.ValidateExecution_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://www.elektra.com.mx/processes/ValidateExecution">
          <nameSpaces prefix="tns" nameSapce="http://www.elektra.com.mx/processes/ValidateExecution"/>
          <Parameter Name="tns:ValidateExecutionStart">
            <parameters Name="tns:validationDateTime" Value="2019-01-31T18:48:00.000" type="dateTime" nameSpace="http://www.elektra.com.mx/processes/ValidateExecution"/>
            <parameters Name="tns:ThresholdInMinutes" Value="60" type="integer" nameSpace="http://www.elektra.com.mx/processes/ValidateExecution"/>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
