package com.elektra.portfoliomanagement.endpoints;

import java.io.InputStream;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

public class EndpointsReader {
	private final static String bwmFilePath = "META-INF/module.bwm";
	//private final static String bwmFilePath = "/home/ldriveram/gitrepos/Gestion/middleware-PortfolioManagement/PortfolioManagementApplicationModule.module/META-INF/module.bwm";
	public static String[] getServiceEndpoints() throws Exception{
		//Serializer with JRE SUN XML (avoid error on deployed apps)
		/*System.setProperty("javax.xml.stream.XMLInputFactory", "com.sun.xml.internal.stream.XMLInputFactoryImpl");
		System.setProperty("javax.xml.stream.XMLOutputFactory", "com.sun.xml.internal.stream.XMLOutputFactoryImpl");
		System.setProperty("javax.xml.parsers.SAXParserFactory", "com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl");
		System.setProperty("javax.xml.transform.TransformerFactory","com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl");*/
		System.setProperty("javax.xml.parsers.DocumentBuilderFactory","com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl");
		//System.setProperty("javax.xml.xpath.XPathFactory","com.sun.org.apache.xpath.internal.jaxp.XPathFactoryImpl");
		InputStream moduleInputStream = EndpointsReader.class.getClassLoader()
        	.getResourceAsStream(bwmFilePath);
		//InputStream moduleInputStream = (InputStream)new FileInputStream("/home/ldriveram/gitrepos/Gestion/middleware-PortfolioManagement/PortfolioManagementApplicationModule.module/META-INF/module.bwm");
			DocumentBuilderFactory factory = DocumentBuilderFactory
					.newInstance();
			factory.setNamespaceAware(true);
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(moduleInputStream);
			Element composite = (Element) doc.getDocumentElement();
			// System.out.println(composite.getChildNodes().getLength());
			NodeList services = composite.getElementsByTagNameNS("http://www.osoa.org/xmlns/sca/1.0","service");
			int length=services.getLength();
			// System.out.println("Nodos Service: " + length +"    "+ services);
			ArrayList<String> outputArray= new ArrayList<String>();
			for( int i=0; i<length; i++) {
			   Element service = (Element) services.item(i);
			   Element binding = (Element) service.getElementsByTagNameNS("http://xsd.tns.tibco.com/amf/models/sca/extensions","binding").item(0);
			   if (binding !=null)
				   outputArray.add(binding.getAttribute("path").replaceAll("\\{(.*?)\\}", "*"));
			}
			String[] output = outputArray.toArray(new String[outputArray.size()]);
			// System.out.println(output.length);
			return output;
	}


	/* public static void main(String[] args)
	{
		try {
			getServiceEndpoints();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String test="/geography/{businessUnit}/{countryId}";
		System.out.println(test.replaceAll("\\{(.*?)\\}", "*"));
	}*/

}
