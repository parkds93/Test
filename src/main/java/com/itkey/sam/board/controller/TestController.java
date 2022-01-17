package com.itkey.sam.board.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.model.service.SHA256Util;

@Controller
public class TestController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="exception.do")
	public ModelAndView exception() {
		ModelAndView mv = new ModelAndView("exception");
		return mv;
	}
	
	public String makeSalt() throws NoSuchAlgorithmException {
		// 소금만들기
		SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
		byte[] bytes = new byte[16];
		random.nextBytes(bytes);
		String salt = new String(Base64.getEncoder().encode(bytes));
		
		
		return salt;
	}
	
	public String getHashPw(String salt, String pw) throws NoSuchAlgorithmException{
		// 염장하기
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt.getBytes());
		md.update(pw.getBytes());
		String hex = String.format("%064x", new BigInteger(1, md.digest()));
		
		return hex;
	}
}
