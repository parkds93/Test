package com.itkey.sam.board.model.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;


@Repository
public class LoginDaoImpl implements LoginDAO {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public List<WriterDTO> chekLogin(WriterDTO confirm) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + confirm.toString());
		List<WriterDTO> out = sqlSession.selectList("selectWriter", confirm);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + out.toString());
		return out;
	}

	@Override
	public int register(WriterDTO user) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + user.toString());
		int result  = sqlSession.insert("insertWriter", user);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	

	
	@Override
	public int updateWriter(WriterDTO writer) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + writer);
		int result = sqlSession.update("updateWriter", writer);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public int deleteWriter(WriterDTO writer) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + writer);
		int result = sqlSession.update("deleteWriter", writer);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return 0;
	}
	
	@Override
	public List<WriterDTO> getWriterList(WriterDTO wDTO) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + wDTO);
		List<WriterDTO> result = sqlSession.selectList("selectWriter", wDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result.size());
		return result;
	}
	
	@Override
	public int selectDelWriter(String[] array) {
		logger.debug("* [DAO] Input < (Service) : "+ array.length);
		int result = sqlSession.update("selectDelWriter",array);
		logger.debug("* [DAO] Output < (Mybatis) : "+ result);
		return result;
	}
}
