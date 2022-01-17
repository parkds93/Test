package com.itkey.sam.board.model.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itkey.sam.board.dto.WriterFileDTO;
import com.itkey.sam.board.model.dao.FileDao;

public class SocketHandler extends TextWebSocketHandler {

	private static Logger logger = LoggerFactory.getLogger(SocketHandler.class);
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	@Autowired FileDao fileDao;
	/**
	 * 클라이언트 연결 이후에 실행되는 메소드
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.info("{} 연결됨", session.getAttributes().get("id"));
		
	}

	/**
	 * 클라이언트가 웹소켓서버로 메시지를 전송했을 때 실행되는 메소드
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session,	TextMessage message) throws Exception {
		
		String id = (String)session.getAttributes().get("id");
		//전송한사람 프로필사진 fileIdx 가져오기
		WriterFileDTO sender = new WriterFileDTO();
		sender.setBoardWriter(id);
		sender = fileDao.getSenderInfo(sender);
		sender.setMessage(message.getPayload());
		String json = new ObjectMapper().writeValueAsString(sender);
		
		
		logger.info("{}로 부터 {} 받음", session.getAttributes().get("id"), message.getPayload());
		logger.info("보내줄 json ->" + json);
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(json));
		}
	}

	/**
	 * 클라이언트가 연결을 끊었을 때 실행되는 메소드
	 */

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		logger.info("{} 연결 끊김", session.getAttributes().get("id"));
	}

}
