package com.itkey.sam.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.WriterDTO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {
	
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// Mybatis SqlSessionTemplate
	@Autowired private SqlSessionTemplate sqlSession;
	
	public List<BoardDTO> selectBoardList(BoardDTO eDTO) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		List<BoardDTO> out = sqlSession.selectList("selectBoard", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + out.toString());
		return out;
	};

	public int selectBoardCount(BoardDTO eDTO) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		int result = sqlSession.selectOne("selectBoardCount", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};

	public int insertBoard(BoardDTO eDTO) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		int result = sqlSession.update("insertBoard", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};

	public int updateBoard(BoardDTO eDTO) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO.toString());
		int result = sqlSession.update("updateBoard", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};

	public int deleteBoard(String keyId) throws Exception {
		logger.debug("* [DAO] Input  ◀ (Service) : " + keyId);
		int result = sqlSession.update("deleteBoard", keyId);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	};
	
	@Override
	public int getTodayBoardListCnt() {
		int result = sqlSession.selectOne("selectTodayBoardListCnt");
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public int getTodayWriterCnt() {
		int result = sqlSession.selectOne("selectTodayWriterCnt");
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public int getWriterTotalCnt(WriterDTO wDTO) {
		int result = sqlSession.selectOne("selectTotalWriterCnt",wDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public WriterDTO getWriter(WriterDTO id) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + id);
		WriterDTO result = sqlSession.selectOne("selectWriter", id);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public List<BoardDTO> getBoardDetail(BoardDTO eDTO) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + eDTO);
		List<BoardDTO> result = sqlSession.selectList("detailBoard", eDTO);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + result);
		return result;
	}
	
	@Override
	public int selectDelBoard(String[] array) {
		logger.debug("* [DAO] Input < (Service) : "+ array.length);
		int result = sqlSession.update("selectDelBoard",array);
		logger.debug("* [DAO] Output < (Mybatis) : "+ result);
		return result;
	}
/*	@Override
	public List<BoardDTO> getSearchBoardList(Map<String, Object> searchMap) {
		logger.debug("* [DAO] Input  ◀ (Service) : " + searchMap);
		List<BoardDTO> returnList = sqlSession.selectList("selectSearchBoardList", searchMap);
		logger.debug("* [DAO] Output ◀ (Mybatis) : " + returnList);
		return returnList;
	}
*/
}