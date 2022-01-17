package com.itkey.sam.board.model.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.dao.LoginDAO;


@Service
public class LoginServiceImpl implements LoginService {
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
		private final Logger logger = LoggerFactory.getLogger(this.getClass());
		
	@Autowired LoginDAO loginDao; 
	
	@Override
	public List<WriterDTO> checkLogin(WriterDTO confirm) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + confirm.toString());
		List<WriterDTO> out = loginDao.chekLogin(confirm);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + out.toString());
		return out;
	}

	@Override
	public int register(WriterDTO user) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + user.toString());
		int result = loginDao.register(user);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		return result;
	}
	

	
	@Override
	public int updateWriter(WriterDTO writer) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + writer.toString());
		int result = loginDao.updateWriter(writer);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		return result;
	}
	
	@Override
	public int deleteWriter(WriterDTO writer) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + writer.toString());
		int result = loginDao.deleteWriter(writer);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result);
		return result;
	}
	
	@Override
	public List<WriterDTO> getWriterList(WriterDTO wDTO) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + wDTO.toString());
		List<WriterDTO> result = loginDao.getWriterList(wDTO);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + result.size());
		return result;
	}
	
	@Override
	public int selectDelWriter(String[] array) {
		logger.debug("* [SERVICE] Input < (Controller) : " + array.length);
		int result = loginDao.selectDelWriter(array);
		logger.debug("* [SERVICE] Output < (DAO) : " + result);
		return result;
	}
}
