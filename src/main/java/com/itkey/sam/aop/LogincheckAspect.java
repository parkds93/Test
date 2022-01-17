package com.itkey.sam.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;



@Aspect
@Component
public class LogincheckAspect {

	@Before("@annotation(com.itkey.sam.aop.Logincheck)")
	public void loginCheck(HttpServletRequest request) {
		String id = (String)request.getSession().getAttribute("id");
		System.out.println("id ->" + id);
		if (id == null || id =="") {
			throw new HttpClientErrorException(HttpStatus.UNAUTHORIZED);
		}
	}
}
