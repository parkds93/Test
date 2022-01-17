package com.itkey.sam.board.model.service;

import java.util.List;
import java.util.Map;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.WriterDTO;

/**
 * Service for SAMPLE_BOARD_TB table : 게시판 정보
**/
public interface BoardService {

	/**
	 * 게시판 정보 조회
	 * @param eDTO 조회 조건
	 * @return 결과 목록
	 */
	public List<BoardDTO> getBoardList(BoardDTO eDTO) throws Exception;

	
	/**
	 * 게시판 정보 데이터 갯수 조회
	 * @param eDTO 조회 조건
	 * @return  데이터 갯수
	 */
	public int getBoardCount(BoardDTO eDTO) throws Exception;

	/**
	 * 게시판 정보 추가
	 * @param eDTO 생성할 데이터
	 * @return 입력 데이터 개수 (selectKey 를 사용하여 key 를 딴 경우 입력 DTO에 해당 key 사용)
	 * @throws Exception
	 */
	public int addBoard(BoardDTO eDTO) throws Exception;

	/**
	 * 게시판 정보 수정
	 * @param eDTO 수정할 데이터
	 * @return 성공여부 (수정된 데이터 개수)
	 * @throws Exception
	 */
	public int chgBoard(BoardDTO eDTO) throws Exception;

	/**
	 * 게시판 정보 삭제
	 * @param eDTO 삭제할 데이터 키값
	 * @return 성공여부 (삭제된 데이터 개수)
	 * @throws Exception
	 */
	public int delBoard(String keyId) throws Exception;

	/**
	 * 오늘 올라온 글 갯수 조회
	 * @return 오늘 올라온 게시글 갯수
	 * @throws Exception
	 */
	public int getTodayBoardListCnt();

	/**
	 * 총 회원수 조회
	 * @param wDTO 
	 * @return 총 회원수
	 * @throws Exception
	 */
	public int getWriterTotalCnt(WriterDTO wDTO);

	/**
	 * 오늘 가입한 회원수 조회
	 * @return 오늘 가입한 회원수 조회
	 * @throws Exception
	 */
	public int getTodayWriterTotalCnt();

	/**
	 * 아이디 통해서 회원정보 가져오기
	 * @param 회원id
	 * @return 회원 정보
	 */
	public WriterDTO getWriter(WriterDTO writer);

	/**
	 * 보드 디테일정보 가져오기
	 * @param boardDTO(boardIdx)
	 * @return boardIdx 해당글 이전글 다음글 
	 */
	public List<BoardDTO> getBoardDetail(BoardDTO eDTO);


	/**
	 * 선택한 게시물 삭제
	 * @return 삭제된 행수
	 * @param String[] boardIdx
	 *
	 */
	public int selectDelBoard(String[] array);

/*	*//**
	 * [검색]보드 리스트 조회
	 * @return 검색된 게시판 리스트
	 * @param searchTag 검색 종류,searchText 검색 명
	 * @throws Exception
	 *//*
	public List<BoardDTO> getSearchBoardList(Map<String, Object> searchMap);*/


}
