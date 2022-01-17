package com.itkey.sam.board.model.service;

import java.util.List;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;

/**
 * Service for SAMPLE_WRITER_TB table : 회원 정보
**/
public interface LoginService {

	/**
	 * 회원 유무 확인
	 * @param Writer(boardIdx) 확인 조건
	 * @return 일치하는 회원
	 */
	List<WriterDTO> checkLogin(WriterDTO confirm);


	/**
	 * 회원 유무 확인
	 * @param WriterDTO 회원가입 정보
	 * @return 성공시 리턴값 1
	 */
	int register(WriterDTO user);




	/**
	 * 유저 정보 수정
	 * @param 수정할 유저 정보
	 * @return 성공시 리턴값 1
	 */
	int updateWriter(WriterDTO writer);

	/**
	 * 유저 삭제
	 * @param 삭제할 유저 정보(boardWriter)
	 * @return 성공시 리턴값 1
	 */
	int deleteWriter(WriterDTO writer);

	/**
	 * 유저 리스트 출력
	 * @param wDTO 검색조건
	 * @return List<WriterDTO> 검색조건 리스트목록
	 */
	List<WriterDTO> getWriterList(WriterDTO wDTO);

	/**
	 * 선택한 멤버 삭제
	 * @return 삭제된 행수
	 * @param String[] boardWriter
	 *
	 */
	int selectDelWriter(String[] array);
}
