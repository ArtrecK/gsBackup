package mx.com.elektra.timermanagement.src;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Files;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import oracle.jdbc.OracleTypes;

public class ReportWriterV2 {

	public static String createReport(String store, String sourceJdbc,
		String username, String password, int timeout,String fileName) {
		CallableStatement cstm = null;
		Connection conn = null;
		ResultSet rs = null;
		File tmpFile = null;
		RandomAccessFile stream = null;
		FileChannel channel = null;
		final String cursorType = "{c}";
		final String varcharType = "{v}";
		final String integerType = "{i}";
		final String numberType = "{n}";
		final String cursorTypePattern = "[{]c[}]";
		final String varcharTypePattern = "[{]v[}]";
		final String integerTypePattern = "[{]i[}]";
		final String numberTypePattern = "[{]n[}]";
		final String storedParameterPattern = "\\?";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(sourceJdbc, username, password);
			Integer numSalidas = countSubCads(store, cursorType)+ countSubCads(store, varcharType) + countSubCads(store, integerType)+
					countSubCads(store, numberType);
			Integer[] opers =orden(store, numSalidas);
			store = store.replaceAll(cursorTypePattern, storedParameterPattern).replaceAll(varcharTypePattern, storedParameterPattern).replaceAll(integerTypePattern, storedParameterPattern).replaceAll(numberTypePattern, storedParameterPattern).replaceAll("\r", "");
			cstm = conn
					.prepareCall(store);
			cstm.setQueryTimeout(timeout);
			for(int op=0; op <opers.length; op++){
				if(opers[op].equals(1)){
					cstm.registerOutParameter( (op+1), OracleTypes.CURSOR);		
				}else if(opers[op].equals(2)){
					cstm.registerOutParameter( (op+1), OracleTypes.VARCHAR);
				}else if(opers[op].equals(3)){
					cstm.registerOutParameter( (op+1), OracleTypes.INTEGER);
				}else if(opers[op].equals(4)){
					cstm.registerOutParameter( (op+1), OracleTypes.NUMERIC);
				}
			}
			
			cstm.execute();

			for(int op1=0; op1 < opers.length; op1++){
				if(opers[op1].equals(1)){
						rs = (ResultSet) cstm.getObject(op1+1);
						break;
				}
			}
			tmpFile = File.createTempFile(fileName, ".csv");
			stream = new RandomAccessFile(tmpFile, "rw");
			channel = stream.getChannel();
			final ResultSetMetaData rsmd = rs.getMetaData();
			final int columnCount = rsmd.getColumnCount();
			final String DELIMITER = ",";
			final String NEWLINE = "\n";
			for (int headerNumber = 1; headerNumber <= columnCount; headerNumber++) {
			      channel.write(toByteBuffer(rsmd.getColumnName(headerNumber)));
			      if (headerNumber != columnCount) {
			        channel.write(toByteBuffer(DELIMITER));
			      }
			    }
			channel.write(toByteBuffer(NEWLINE));
			while (rs.next()) {
				 for (int columnNumber = 1; columnNumber <= columnCount; columnNumber++) {
			          final Object columnValue = rs.getObject(columnNumber);
			          String value = columnValue == null ? "" : columnValue.toString();
			          if (columnNumber == columnCount) {
			        	    value = "\"" +  value + "\"";
				      }
			          channel.write(toByteBuffer(value));
			          if (columnNumber != columnCount) {
			            channel.write(toByteBuffer(DELIMITER));
			          }
			      }
			      channel.write(toByteBuffer(NEWLINE));
			}

		} catch (SQLException sqlE) {
			sqlE.printStackTrace();
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		} finally {
			closeAllStore(rs, cstm, conn);
			try {
				channel.close();
				stream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		try {
			String reportFilePath = createZip(tmpFile.getAbsolutePath());
			return reportFilePath;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public static void closeAllStore(ResultSet rs, CallableStatement cstm,
			Connection conn) {
		if (rs != null) {
			try {
				rs.close();
				rs = null;
			} catch (SQLException sqlE) {
			}
		}
		if (cstm != null) {
			try {
				cstm.close();
				cstm = null;
			} catch (SQLException sqlE) {
			}

		}
		if (conn != null) {
			try {
				conn.close();
				conn = null;
			} catch (SQLException sqlE) {
			}
		}
	}

	public static ByteBuffer toByteBuffer(String convert) {
		byte[] strBytes = convert.getBytes();
		ByteBuffer buffer = ByteBuffer.allocate(strBytes.length);
		buffer.put(strBytes);
		buffer.flip();
		return buffer;
	}

	public static String createZip(String zipFilePath) throws Exception {
		File f = File.createTempFile("report", ".zip");
		FileOutputStream fos = new FileOutputStream(f);
		File csvFile = new File(zipFilePath);
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String dateString = format.format(new Date());
		try (ZipOutputStream zos = new ZipOutputStream(fos)) {
			zos.putNextEntry(new ZipEntry("reporte_" + dateString + ".csv"));
			Files.copy(csvFile.toPath(), zos);
			Files.deleteIfExists(csvFile.toPath());
		}
		File file = new File(zipFilePath);
		file.delete();
		return f.getAbsolutePath();
	}

	public static int countSubCads(String cadena, String strBusca){
		int count = 0;

		if(cadena!=null){
			int lngCadena = cadena.length();
			int lngBusca = strBusca.length();

			if(lngCadena >= lngBusca){

				for(int i=0; i< lngCadena ;i++){
					if(i <=(lngCadena-lngBusca)){
						String substr = cadena.substring(i, i+lngBusca);

						if(substr.equalsIgnoreCase(strBusca)){
							count++;
						}
					}
				}
			}
		}

		return count;
	}

	public static Integer[] orden(String cadena, int longitud){
		Integer[] order = new Integer[longitud];
		int counter = 0;

		if(cadena!=null){
			int lngCadena = cadena.length();
			int lngBusca = 3;

			if(lngCadena >= lngBusca){

				for(int i=0; i< lngCadena ;i++){
					if(i <=(lngCadena-lngBusca)){
						String substr = cadena.substring(i, i+lngBusca);
						if(substr.equalsIgnoreCase("{c}")){
							order[counter] = 1;
							counter++;
						}else if(substr.equalsIgnoreCase("{v}")){
							order[counter] = 2;
							counter++;
						}else if(substr.equalsIgnoreCase("{i}")){
							order[counter] = 3;
							counter++;
						}else if(substr.equalsIgnoreCase("{n}")){
							order[counter] = 4;
							counter++;
						}else if(substr.equalsIgnoreCase("{d}")){
							order[counter] = 5;
							counter++;
						}
					}
				}
			}
		}
		return order;
	}
	
	public static void main(String args) {
		//createReport(null, null, null, null, 0);
	}
}
