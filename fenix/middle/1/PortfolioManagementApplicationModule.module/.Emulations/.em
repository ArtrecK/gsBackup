<?xml version="1.0" encoding="ASCII"?>
<emulation:EmulationData xmlns:emulation="http:///emulation.ecore" isBW="true" location="PortfolioManagementApplicationModule.module">
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.activities.ActivitiesQuery" Name="mx.com.elektra.portfoliomanagement.activities.ActivitiesQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.activities.ActivitiesQuery">
      <Inputs Id="901cfb15-7655-4182-8a7d-bd582edea6a0PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.activities.ActivitiesQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertRecord" Name="mx.com.elektra.portfoliomanagement.alerts.AlertRecord" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertRecord">
      <Inputs Id="a77a29e8-ae06-43ea-af2a-be59d52e1c6ePortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertRecord_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertWatchUpdate" Name="mx.com.elektra.portfoliomanagement.alerts.AlertWatchUpdate" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertWatchUpdate">
      <Inputs Id="f4b3fa64-a81a-4289-afa9-1ed8b261c74cPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertWatchUpdate_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertsCreation" Name="mx.com.elektra.portfoliomanagement.alerts.AlertsCreation" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertsCreation">
      <Inputs Id="67c88e0d-7f7e-4bf4-a09d-63cbb3953370PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertsCreation_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertsDeletion" Name="mx.com.elektra.portfoliomanagement.alerts.AlertsDeletion" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertsDeletion">
      <Inputs Id="d6fdcb50-a5a2-4b8d-836a-c19dc6ed3f07PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertsDeletion_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertsQuery" Name="mx.com.elektra.portfoliomanagement.alerts.AlertsQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertsQuery">
      <Inputs Id="fd866f01-a0ca-49e3-97cf-9d83c485576aPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertsQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.AlertsUpdate" Name="mx.com.elektra.portfoliomanagement.alerts.AlertsUpdate" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.AlertsUpdate">
      <Inputs Id="c7e2da5f-1aed-45cc-b502-06a3974d17e0PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.AlertsUpdate_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.alerts.CopyOfAlertsQuery" Name="mx.com.elektra.portfoliomanagement.alerts.CopyOfAlertsQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.alerts.CopyOfAlertsQuery">
      <Inputs Id="0e58dd0e-539c-4c4d-ae3e-a1492c168535PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.alerts.CopyOfAlertsQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="http://xmlns.example.com/Alerts/headerParameters">
          <nameSpaces prefix="tns" nameSapce="http://xmlns.example.com/Alerts/headerParameters"/>
          <nameSpaces prefix="tns0" nameSapce="http://tns.tibco.com/bw/REST"/>
          <Parameter Name="tns:alertsGetParameters">
            <parameters Name="employeeNumber" Value="362423" type="string" canDelete="true"/>
            <parameters Name="countryId" Value="0" type="string" canDelete="true"/>
            <parameters Name="territoryId" Value="0" type="string" canDelete="true"/>
            <parameters Name="zoneId" Value="0" type="string" canDelete="true"/>
            <parameters Name="regionId" Value="0" type="string" canDelete="true"/>
            <parameters Name="branchId" Value="2024" type="string" canDelete="true"/>
            <parameters Name="role" Value="500" type="string" canDelete="true"/>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.ActiveCampaigns" Name="mx.com.elektra.portfoliomanagement.campaigns.ActiveCampaigns" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.ActiveCampaigns">
      <Inputs Id="b269464e-0ae6-4953-ae08-f04582dccb7fPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.ActiveCampaigns_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.ManagemetCampaign" Name="mx.com.elektra.portfoliomanagement.campaigns.ManagemetCampaign" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.ManagemetCampaign">
      <Inputs Id="1d222286-8898-474a-818d-6d17346e2fcfPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.ManagemetCampaign_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.v2.ActiveCampaignsV2" Name="mx.com.elektra.portfoliomanagement.campaigns.v2.ActiveCampaignsV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.v2.ActiveCampaignsV2">
      <Inputs Id="d03e0e5e-bba9-4c14-9468-526ac681bf89PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.v2.ActiveCampaignsV2_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema">
          <nameSpaces prefix="tns" nameSapce="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
          <Parameter Name="tns:EmployeeNumber">
            <parameters Name="tns:branchOffice" Value="2024" type="string" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema" canDelete="true">
              <parent Name="EmployeeNumber" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
            </parameters>
            <parameters Name="tns:employeeNumber" type="string" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema" canDelete="true">
              <parent Name="EmployeeNumber" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.v2.CamapignsBySeller" Name="mx.com.elektra.portfoliomanagement.campaigns.v2.CamapignsBySeller" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.v2.CamapignsBySeller">
      <Inputs Id="b3a558e8-7998-44b5-b704-4859c3d889e9PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.v2.CamapignsBySeller_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.v2.CampaignsByCustomer" Name="mx.com.elektra.portfoliomanagement.campaigns.v2.CampaignsByCustomer" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.v2.CampaignsByCustomer">
      <Inputs Id="d38b339f-6d02-4ace-9682-4ee0367defd9PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.v2.CampaignsByCustomer_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCampaignsByCustomer" Name="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCampaignsByCustomer" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCampaignsByCustomer">
      <Inputs Id="9e59fbc8-c986-440e-b3ea-583016f4ba24PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.v2.GetCampaignsByCustomer_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCustomersBySeller" Name="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCustomersBySeller" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.campaigns.v2.GetCustomersBySeller">
      <Inputs Id="8ea3e240-5063-4190-80b6-90922b28f6afPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.campaigns.v2.GetCustomersBySeller_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS">
        <informations Name="input" tnsName="tns:" nameSpace="xmlns:tns">
          <nameSpaces prefix="tns" nameSapce="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
          <Parameter Name="tns:EmployeeNumber" Value="&#xA;  ">
            <parameters Name="tns:branchOffice" Value="&quot;2024&quot;" type="string" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema" canDelete="true">
              <parent Name="EmployeeNumber" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
            </parameters>
            <parameters Name="tns:employeeNumber" Value="&quot;358997&quot;" type="string" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema" canDelete="true">
              <parent Name="EmployeeNumber" nameSpace="/api/v1/portfolio/T1530054322052Converted/JsonSchema"/>
            </parameters>
          </Parameter>
        </informations>
      </Inputs>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.BestOffer" Name="mx.com.elektra.portfoliomanagement.customersfile.BestOffer" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.BestOffer">
      <Inputs Id="6109b970-b299-4426-83b2-3684a2db7389PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.BestOffer_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.CustomersFiles" Name="mx.com.elektra.portfoliomanagement.customersfile.CustomersFiles" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.CustomersFiles">
      <Inputs Id="7189cd76-ad95-47f9-9ebb-545736e9b66fPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.CustomersFiles_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.OffersCustomer" Name="mx.com.elektra.portfoliomanagement.customersfile.OffersCustomer" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.OffersCustomer">
      <Inputs Id="0be4172d-9a48-42f7-90ad-dede1360d80cPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.OffersCustomer_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.ProductsHistory" Name="mx.com.elektra.portfoliomanagement.customersfile.ProductsHistory" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.ProductsHistory">
      <Inputs Id="88f8da0e-379c-4d7e-9ad2-4becf34b8df1PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.ProductsHistory_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.v2.CustomersFilesV2" Name="mx.com.elektra.portfoliomanagement.customersfile.v2.CustomersFilesV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.v2.CustomersFilesV2">
      <Inputs Id="b2947dcd-438c-4c28-92ef-37cf077b1591PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.v2.CustomersFilesV2_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.customersfile.v2.OffersCustomerV2" Name="mx.com.elektra.portfoliomanagement.customersfile.v2.OffersCustomerV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.customersfile.v2.OffersCustomerV2">
      <Inputs Id="5a7f6a40-ec57-4026-a1c9-261f7003e018PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.customersfile.v2.OffersCustomerV2_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.datebook.DatebookCreate" Name="mx.com.elektra.portfoliomanagement.datebook.DatebookCreate" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.datebook.DatebookCreate">
      <Inputs Id="79488fae-36cb-4e8f-9b24-dcd5c6c77aa2PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.datebook.DatebookCreate_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.datebook.DatebookDelete" Name="mx.com.elektra.portfoliomanagement.datebook.DatebookDelete" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.datebook.DatebookDelete">
      <Inputs Id="27113f6d-08e5-4688-b046-02feba483c13PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.datebook.DatebookDelete_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.datebook.DatebookInfoQuery" Name="mx.com.elektra.portfoliomanagement.datebook.DatebookInfoQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.datebook.DatebookInfoQuery">
      <Inputs Id="0b48c4df-cb2c-4873-8bc3-6daee96ca8bePortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.datebook.DatebookInfoQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.datebook.DatebookQuery" Name="mx.com.elektra.portfoliomanagement.datebook.DatebookQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.datebook.DatebookQuery">
      <Inputs Id="12166e51-ca22-46ca-8770-bb2353e9f79ePortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.datebook.DatebookQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.datebook.DatebookUpdate" Name="mx.com.elektra.portfoliomanagement.datebook.DatebookUpdate" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.datebook.DatebookUpdate">
      <Inputs Id="e8e5d034-e93d-4731-b93e-da881a289cd6PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.datebook.DatebookUpdate_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.geography.GeographyCountriesQuery" Name="mx.com.elektra.portfoliomanagement.geography.GeographyCountriesQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.geography.GeographyCountriesQuery">
      <Inputs Id="92810f90-d8c2-47cf-a769-fde5f45d3617PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.geography.GeographyCountriesQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.geography.GeographyQuery" Name="mx.com.elektra.portfoliomanagement.geography.GeographyQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.geography.GeographyQuery">
      <Inputs Id="8678a2dd-39f4-4e78-9b77-e24a7b5b15a6PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.geography.GeographyQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.gestion.EventsDayGestion" Name="mx.com.elektra.portfoliomanagement.gestion.EventsDayGestion" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.gestion.EventsDayGestion">
      <Inputs Id="32b8dcdb-7db4-4bd6-9d77-c8a47017ca71PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.gestion.EventsDayGestion_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.gestion.GetCatalogThirdCombo" Name="mx.com.elektra.portfoliomanagement.gestion.GetCatalogThirdCombo" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.gestion.GetCatalogThirdCombo">
      <Inputs Id="6e156d87-4345-4e57-852c-f4fae2ae4181PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.gestion.GetCatalogThirdCombo_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.gestion.StatusGestion" Name="mx.com.elektra.portfoliomanagement.gestion.StatusGestion" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.gestion.StatusGestion">
      <Inputs Id="98f5d12c-1097-4ae2-ac6b-b9814ce0722fPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.gestion.StatusGestion_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.management.ManagementCreation" Name="mx.com.elektra.portfoliomanagement.management.ManagementCreation" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.management.ManagementCreation">
      <Inputs Id="526a4645-9213-48d8-9fb8-e0079644484bPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.management.ManagementCreation_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.management.ManagementDelete" Name="mx.com.elektra.portfoliomanagement.management.ManagementDelete" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.management.ManagementDelete">
      <Inputs Id="ff526a16-fbb1-454d-a575-f8f9cbf182b3PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.management.ManagementDelete_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.management.ManagementQuery" Name="mx.com.elektra.portfoliomanagement.management.ManagementQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.management.ManagementQuery">
      <Inputs Id="55fb021e-c78a-4b3b-a132-0f80655c2fddPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.management.ManagementQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.management.ManagementUpdate" Name="mx.com.elektra.portfoliomanagement.management.ManagementUpdate" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.management.ManagementUpdate">
      <Inputs Id="b09eead1-41db-4716-81e6-a2944c64bc50PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.management.ManagementUpdate_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.management.managementcatalogue" Name="mx.com.elektra.portfoliomanagement.management.managementcatalogue" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.management.managementcatalogue">
      <Inputs Id="08655498-d1a9-4af7-a402-6addfc84dee5PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.management.managementcatalogue_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.moment.MomentQuery" Name="mx.com.elektra.portfoliomanagement.moment.MomentQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.moment.MomentQuery">
      <Inputs Id="475ffc62-2dcb-4eb4-b814-af51a20d4b5fPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.moment.MomentQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.parameterization.GetParameterValue" Name="mx.com.elektra.portfoliomanagement.parameterization.GetParameterValue" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.parameterization.GetParameterValue">
      <Inputs Id="91fa6677-6660-47fd-9ba5-944f3de93943PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.parameterization.GetParameterValue_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersCreateContact" Name="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersCreateContact" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersCreateContact">
      <Inputs Id="5970845c-fa84-4698-99b7-bd0396aa9c6aPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersCreateContact_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersViewContact" Name="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersViewContact" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersViewContact">
      <Inputs Id="04e555de-8006-42e4-9275-7eac235114e4PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.portfolio.customers.CustomersViewContact_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.portfolio.customers.count.CountPortfolioCustomers" Name="mx.com.elektra.portfoliomanagement.portfolio.customers.count.CountPortfolioCustomers" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.portfolio.customers.count.CountPortfolioCustomers">
      <Inputs Id="161fdcc1-4b66-48a3-875e-4659779aeaa1PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.portfolio.customers.count.CountPortfolioCustomers_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.purse.PurseClients" Name="mx.com.elektra.portfoliomanagement.purse.PurseClients" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.purse.PurseClients">
      <Inputs Id="d7739a3c-69bc-4c06-a4c8-ce7b5a531886PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.purse.PurseClients_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.purseOverview.PortfolioManagementDetail" Name="mx.com.elektra.portfoliomanagement.purseOverview.PortfolioManagementDetail" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.purseOverview.PortfolioManagementDetail">
      <Inputs Id="e6e5f103-ec78-4a34-9793-5a52227d594ePortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.purseOverview.PortfolioManagementDetail_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.reactivations.ReactivationsQuery" Name="mx.com.elektra.portfoliomanagement.reactivations.ReactivationsQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.reactivations.ReactivationsQuery">
      <Inputs Id="30fd6060-dc67-4ce6-919c-aab2de9b6a0bPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.reactivations.ReactivationsQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.routes.RoutesQuery" Name="mx.com.elektra.portfoliomanagement.routes.RoutesQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.routes.RoutesQuery">
      <Inputs Id="3ed51efb-6200-44d6-8bd2-eada15cb548aPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.routes.RoutesQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.schedule.ScheduleQuery" Name="mx.com.elektra.portfoliomanagement.schedule.ScheduleQuery" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.schedule.ScheduleQuery">
      <Inputs Id="fc91d50e-f046-45be-9ebd-1c60d6dd73a1PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.schedule.ScheduleQuery_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ActiveCampaignsResource" Name="mx.com.elektra.portfoliomanagement.services.ActiveCampaignsResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="post" serviceName="campaigns">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ActiveCampaignsResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="campaigns">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ActiveCampaignsResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ActivitiesResource" Name="mx.com.elektra.portfoliomanagement.services.ActivitiesResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="dailyActivities">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ActivitiesResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.AlertsResource" Name="mx.com.elektra.portfoliomanagement.services.AlertsResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="post" serviceName="alerts">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="alerts">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="put" serviceName="alerts">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_put_putInput" Name="putInput" isDefault="true"/>
    </Operation>
    <Operation Name="delete" serviceName="alerts">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_delete_deleteInput" Name="deleteInput" isDefault="true"/>
    </Operation>
    <Operation Name="post" serviceName="alerts-watch">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="alerts-record">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.AlertsResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ClientFileManagement" Name="mx.com.elektra.portfoliomanagement.services.ClientFileManagement" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="customerfile">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ClientFileManagement_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.CustomerContactManagement" Name="mx.com.elektra.portfoliomanagement.services.CustomerContactManagement" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="post" serviceName="customer-detail-contact">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.CustomerContactManagement_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="customer-detail-contact">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.CustomerContactManagement_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.CustomerCounterPortfolio" Name="mx.com.elektra.portfoliomanagement.services.CustomerCounterPortfolio" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="portfolio-customers-count">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.CustomerCounterPortfolio_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.DatebookManagementResource" Name="mx.com.elektra.portfoliomanagement.services.DatebookManagementResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="post" serviceName="datebook-events">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.DatebookManagementResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="put" serviceName="datebook-events">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.DatebookManagementResource_put_putInput" Name="putInput" isDefault="true"/>
    </Operation>
    <Operation Name="delete" serviceName="datebook-events">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.DatebookManagementResource_delete_deleteInput" Name="deleteInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="datebook-events-info">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.DatebookManagementResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="datebook-events">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.DatebookManagementResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.EventsDayResource" Name="mx.com.elektra.portfoliomanagement.services.EventsDayResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="gestion-eventsday">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.EventsDayResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.GeographyResource" Name="mx.com.elektra.portfoliomanagement.services.GeographyResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="geography-countries">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.GeographyResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="geography">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.GeographyResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.GestionAdminResource" Name="mx.com.elektra.portfoliomanagement.services.GestionAdminResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="gestion-getthirdcombo">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.GestionAdminResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.GestionResource" Name="mx.com.elektra.portfoliomanagement.services.GestionResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="statusGestion">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.GestionResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ManagementResource" Name="mx.com.elektra.portfoliomanagement.services.ManagementResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="post" serviceName="management">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ManagementResource_post_postInput" Name="postInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="management">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ManagementResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="put" serviceName="management">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ManagementResource_put_putInput" Name="putInput" isDefault="true"/>
    </Operation>
    <Operation Name="delete" serviceName="management">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ManagementResource_delete_deleteInput" Name="deleteInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="management-catalogue">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ManagementResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.MomentsManagement" Name="mx.com.elektra.portfoliomanagement.services.MomentsManagement" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="moments">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.MomentsManagement_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.Parameterizationfrontmodules" Name="mx.com.elektra.portfoliomanagement.services.Parameterizationfrontmodules" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="parameterization-front-modules">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.Parameterizationfrontmodules_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.PurseResource" Name="mx.com.elektra.portfoliomanagement.services.PurseResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="purse-management">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.PurseResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="purse-overview-portfolioManagement">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.PurseResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ReactivationsResource" Name="mx.com.elektra.portfoliomanagement.services.ReactivationsResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="reactivations">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ReactivationsResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.RoutesManagement" Name="mx.com.elektra.portfoliomanagement.services.RoutesManagement" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="routes">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.RoutesManagement_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.ScheduleResource" Name="mx.com.elektra.portfoliomanagement.services.ScheduleResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="seller-scheduled">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.ScheduleResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.SupervisorResource" Name="mx.com.elektra.portfoliomanagement.services.SupervisorResource" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="supervisor-overview-alerts">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-pendingOrders">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-estimations">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-pendingRequest">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-reactivations">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-campaignsManaged">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-reactivationsManaged">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="supervisor-overview-campaigns">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.SupervisorResource_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.v2.ActiveCampaignsResourceV2" Name="mx.com.elektra.portfoliomanagement.services.v2.ActiveCampaignsResourceV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="campaignsV2">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.v2.ActiveCampaignsResourceV2_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.v2.ClientFileManagementV2" Name="mx.com.elektra.portfoliomanagement.services.v2.ClientFileManagementV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="customerfileV2">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.v2.ClientFileManagementV2_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.services.v2.PurseResourceV2" Name="mx.com.elektra.portfoliomanagement.services.v2.PurseResourceV2" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="get" serviceName="purse-overview-portfolioManagementV2">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.v2.PurseResourceV2_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
    <Operation Name="get" serviceName="purse-managementV2">
      <Inputs Id="PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.services.v2.PurseResourceV2_get_getInput" Name="getInput" isDefault="true"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountAlertsNotSeen" Name="mx.com.elektra.portfoliomanagement.supervisor.CountAlertsNotSeen" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountAlertsNotSeen">
      <Inputs Id="31edc5cc-8bb2-4928-bd36-4f0e22d78294PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountAlertsNotSeen_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountCampaigns" Name="mx.com.elektra.portfoliomanagement.supervisor.CountCampaigns" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountCampaigns">
      <Inputs Id="7ac2fe84-e8c6-47b5-9aac-bd6c0f73a3b0PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountCampaigns_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountManagedCampaigns" Name="mx.com.elektra.portfoliomanagement.supervisor.CountManagedCampaigns" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountManagedCampaigns">
      <Inputs Id="3ad61d3b-9349-46a2-8655-8b18763a9603PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountManagedCampaigns_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountManagedEstimations" Name="mx.com.elektra.portfoliomanagement.supervisor.CountManagedEstimations" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountManagedEstimations">
      <Inputs Id="cdfa0fb0-ef0e-4053-946a-10ffde4311b1PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountManagedEstimations_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingOrder" Name="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingOrder" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingOrder">
      <Inputs Id="15ca15b7-5614-4fa5-8605-81d8b9f5ffccPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingOrder_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingRequest" Name="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingRequest" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingRequest">
      <Inputs Id="e3342f04-5b7d-4dbd-a422-8090609c602cPortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountManagedPendingRequest_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountManagedReactivations" Name="mx.com.elektra.portfoliomanagement.supervisor.CountManagedReactivations" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountManagedReactivations">
      <Inputs Id="f593c669-d1d6-423b-bd3a-2b9f088eb8e0PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountManagedReactivations_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="mx.com.elektra.portfoliomanagement.supervisor.CountReactivations" Name="mx.com.elektra.portfoliomanagement.supervisor.CountReactivations" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="callProcess" serviceName="mx.com.elektra.portfoliomanagement.supervisor.CountReactivations">
      <Inputs Id="d4a06895-2efa-4161-a7a8-f8d089865fe5PortfolioManagementApplicationModule.module_mx.com.elektra.portfoliomanagement.supervisor.CountReactivations_callProcess_Start" Name="Start" isDefault="true" type="CALLPROCESS"/>
    </Operation>
  </ProcessNode>
  <ProcessNode Id="portfoliomanagementapplicationmodule.module.Activator" Name="portfoliomanagementapplicationmodule.module.Activator" ModelType="BW" moduleName="PortfolioManagementApplicationModule.module">
    <Operation Name="onStartup" serviceName="ModuleActivator">
      <Inputs Id="PortfolioManagementApplicationModule.module_portfoliomanagementapplicationmodule.module.Activator_onStartup_Request" Name="Request" isDefault="true"/>
    </Operation>
    <Operation Name="onShutdown" serviceName="ModuleActivator">
      <Inputs Id="PortfolioManagementApplicationModule.module_portfoliomanagementapplicationmodule.module.Activator_onShutdown_Request" Name="Request" isDefault="true"/>
    </Operation>
  </ProcessNode>
</emulation:EmulationData>
