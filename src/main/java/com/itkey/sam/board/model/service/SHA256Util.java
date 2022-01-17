package com.itkey.sam.board.model.service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class SHA256Util {
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : USER
	* @메소드 이름 : makeSalt 
	* @메소드 설명 : 비밀번호 들어갈 소금을 만듭니다
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	public static String makeSalt() throws NoSuchAlgorithmException {
		// 소금만들기
		SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		byte[] bytes = new byte[16];
		random.nextBytes(bytes);
		String salt = new String(Base64.getEncoder().encode(bytes));
		
		
		return salt;
	}
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : USER
	* @메소드 이름 : getHashPw 
	* @메소드 설명 : 비밀번호와 salt를 가져와서 해쉬화합니다.
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	public static String getHashPw(String salt, String pw) throws NoSuchAlgorithmException{
		// 염장하기
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt.getBytes());
		md.update(pw.getBytes());
		String hex = String.format("%064x", new BigInteger(1, md.digest()));
		
		return hex;
	}

}
