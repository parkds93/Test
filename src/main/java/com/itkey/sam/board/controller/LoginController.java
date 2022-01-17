package com.itkey.sam.board.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.LoginService;
import com.itkey.sam.board.model.service.SHA256Util;



@Controller
public class LoginController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// Dependency Injection With BoardService
	@Autowired LoginService loginService;

	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2021. 12. 27. 
	* @작성자 : PDS
	* @메소드 이름 : loginForm 
	* @메소드 설명 : 로그인폼
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="/login.do")
	public ModelAndView loginForm(@RequestParam Map<String, Object> requestParam,
								  @CookieValue(name = "memberId", required = false) Long memberId,
								  HttpServletRequest request) {
		request.getSession().invalidate();
		logger.debug("Login Page Response");
		ModelAndView mv = new ModelAndView("login");
		
		mv.addObject("memberId",memberId);
		
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @throws NoSuchAlgorithmException 
	* @파일명 : LoginController.java
	* @작성일자 : 2021. 12. 27. 
	* @작성자 : PDS
	* @메소드 이름 : login 
	* @메소드 설명 : 로그인 ajax
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="/login.do" , method=RequestMethod.POST)
	@ResponseBody
	public WriterDTO login(@RequestParam Map<String, Object> requestParam, 
						   HttpServletResponse response,
						   HttpServletRequest request) throws NoSuchAlgorithmException {
		
		String id = (String)requestParam.get("id");
		String pw = (String)requestParam.get("pw");
		String checked = (String)requestParam.get("rememberId");
	
		WriterDTO writer = new WriterDTO();
		writer.setBoardWriter(id);
		
		List<WriterDTO> rWriter = loginService.getWriterList(writer);
		
		// 접속 pw 해쉬화해서 데이터베이스 pw 와 비교
		String hashpw = SHA256Util.getHashPw(rWriter.get(0).getSalt(), pw);
		logger.debug("해쉬된 pw 확인"+hashpw);
		logger.debug("저장된 비밀번호 확인"+rWriter.get(0).getBoardWriterPw());
		// 0 아이디불일치-1 비밀번호불일치 1 로그인성공 
		
		if(rWriter.isEmpty()) {
			System.out.println("아이디틀림");
			writer.setCheck(0);
		}else if(rWriter.get(0).getBoardWriterPw().equals(hashpw)) {
			logger.debug(id+"님 로그인");
			writer.setCheck(1);
			request.getSession().setAttribute("id", id);
			
			if(checked.equals("on")) {
				logger.debug("쿠키만듬!!");
				Cookie cookie = new Cookie("memberId", id);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24);
				response.addCookie(cookie);
				
				
			}else if(checked == null || checked.equals("")){
				logger.debug("쿠키삭제함!!");
				Cookie cookie = new Cookie("memberId", null);
				cookie.setPath("/");
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			
		}else {
			logger.debug("비밀번호틀림");
			writer.setCheck(-1);
		}
		
		return writer;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : PDS
	* @메소드 이름 : registerForm 
	* @메소드 설명 : 회원가입 폼으로 이동합니다
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="/register.do")
	public ModelAndView registerForm(@RequestParam Map<String, Object> requestParam) {
		logger.debug("registerForm Page Response");
		ModelAndView mv = new ModelAndView("register");
		
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : PDS
	* @메소드 이름 : register 
	* @메소드 설명 : 회원가입이 실행됩니다.
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public ModelAndView register(@RequestParam Map<String, Object> requestParam,
								 WriterDTO user, HttpServletRequest request) throws NoSuchAlgorithmException {
		
		
		logger.debug("registerForm Page Response");
		ModelAndView mv = new ModelAndView("redirect:main.do");
		
		String pw = user.getBoardWriterPw();

		String salt =  SHA256Util.makeSalt();
		String hashPw = SHA256Util.getHashPw(salt,pw);
		// 염장하기

		user.setBoardWriterPw(hashPw);
		user.setSalt(salt);
		
		int result = loginService.register(user);
		
		//아이디 세션 저장
		if(result==1) {
			request.getSession().setAttribute("id", user.getBoardWriter());
		}
		
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : PDS
	* @메소드 이름 : checkId 
	* @메소드 설명 : 아이디를 체크합니다
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="checkId.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> checkId(WriterDTO confirm){
		Map<String,Object> map = new HashMap<String, Object>();
		List<WriterDTO> check = loginService.checkLogin(confirm);
		
		if(check.isEmpty()) {
			map.put("check", "true");
		}else {
			map.put("check", "false");
		}
		
		return map;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : USER
	* @메소드 이름 : userModifyForm 
	* @메소드 설명 : 회원정보 수정폼으로 이동합니다
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="userModify.do")
	public ModelAndView userModifyForm(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("userModify");
		String id = (String)request.getSession().getAttribute("id");
		WriterDTO writer = new WriterDTO();
		writer.setBoardWriter(id);
		List<WriterDTO> result = loginService.checkLogin(writer);
		
		mv.addObject("writer",result.get(0));
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : USER
	* @메소드 이름 : userModify 
	* @메소드 설명 : 회원정보를 수정합니다.
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="userModify.do", method=RequestMethod.POST)
	public ModelAndView userModify(HttpServletRequest request, WriterDTO writer) throws NoSuchAlgorithmException {
		ModelAndView mv = new ModelAndView("redirect:main.do");
		String salt = SHA256Util.makeSalt();
		String hashPw = SHA256Util.getHashPw(salt, writer.getBoardWriterPw());
		writer.setSalt(salt);
		writer.setBoardWriterPw(hashPw);
		
		int result = loginService.updateWriter(writer);
		
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : LoginController.java
	* @작성일자 : 2022. 1. 5. 
	* @작성자 : USER
	* @메소드 이름 : deleteWriter 
	* @메소드 설명 : 회원을 삭제합니다
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="deleteWriter.do")
	public ModelAndView deleteWriter(WriterDTO writer) {
		ModelAndView mv = new ModelAndView("redirect:main.do");
		int result = loginService.deleteWriter(writer);
		
		return mv;
	}

}
