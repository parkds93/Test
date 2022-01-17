package com.itkey.sam.board.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
@RestController
public class MyExceptionHandler {
    
	@ExceptionHandler(value = Exception.class)
    public ModelAndView handleException(Exception e) {
		ModelAndView mv = new ModelAndView("exception");
		String errorCode = "500";
		String message = "알 수 없는 오류가 발생했습니다 ";
		
		mv.addObject("exception",e);
		mv.addObject("errorCode",errorCode);
		mv.addObject("message",message);
		return mv;
    }
	
	@ExceptionHandler(RuntimeException.class)
	public ModelAndView errorException(Exception e) {
		ModelAndView mv = new ModelAndView("exception");
		String errorCode = "400";
		String message = "데이터 처리중 문제발생";
		
		mv.addObject("exception",e);
		mv.addObject("errorCode",errorCode);
		mv.addObject("message",message);
		return mv;
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	public ModelAndView NoHandlerFoundException(Exception e) {
		ModelAndView mv = new ModelAndView("exception");
		String errorCode = "404";
		String message = "요청한 페이지를 찾을 수 업습니다.";
		
		mv.addObject("exception",e);
		mv.addObject("errorCode",errorCode);
		mv.addObject("message",message);
		return mv;
	}
	
}