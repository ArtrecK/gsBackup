package com.elektra.portafoliomanagement.sms;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptionAes {
	
public static String encrypt(String value, String keyEncrypt, String ivEncript) {
		
		try {	
			IvParameterSpec iv = new IvParameterSpec(ivEncript.getBytes("UTF-8"));
			SecretKeySpec skeySpec = new SecretKeySpec(keyEncrypt.getBytes("UTF-8"), "AES");
			
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
			
			System.out.println("Algoritmo: " + cipher.getAlgorithm());
			
			byte[] encrypted = cipher.doFinal(value.getBytes());
			
			return Base64.getEncoder().encodeToString(encrypted);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return null;
	}
	
	public static String decrypt(String encryted, String keyDecrypt, String ivDecrypt ) {
		
		try {
			IvParameterSpec iv = new IvParameterSpec(ivDecrypt.getBytes("UTF-8"));
			SecretKeySpec skeySpec = new SecretKeySpec(keyDecrypt.getBytes("UTF-8"), "AES");
			
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			
			return new String(cipher.doFinal(Base64.getDecoder().decode(encryted)));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
