package com.itkey.sam.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterFileDTO;

@Repository
public class FileDaoImpl implements FileDao {

	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;
	
	@Override
	public FileDTO saveFile(FileDTO file) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + file.toString());
		int result = sqlSession.insert("insertFile", file);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + file.getFileIdx());
		return file;
	}
	
	@Override
	public List<FileDTO> getFile(String[] fileIdx) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + fileIdx.length);
		List<FileDTO> out = sqlSession.selectList("selectFile", fileIdx);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + out.size());
		return out;	
	}
	
	@Override
	public WriterFileDTO getSenderInfo(WriterFileDTO wfDTO) {
		logger.debug("* [DAO] input < [SocketHandler] : " + wfDTO.getBoardWriter());
		wfDTO = sqlSession.selectOne("selectSenderInfo",wfDTO);
		logger.debug("* [SocketHandler] Output < [DAO] : " + wfDTO.toString());
		return wfDTO;
	}
}
