package com.itkey.sam.board.model.dao;

import java.util.List;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.dto.WriterFileDTO;

public interface FileDao {

	/**
	 * 파일 저장
	 * @param file 저장될 파일 정보
	 * @return 성공시 file idx리턴
	 */
	FileDTO saveFile(FileDTO file);

	/**
	 * 파일 가져오기
	 * @param fileIdx 가져올 파일 인덱스s
	 * @return List<FileDTO> 일치하는 파일리스트
	 */
	List<FileDTO> getFile(String[] fileIdx);
	
	/**
	 * 송신자 정보 가져오기
	 * @param wfDTO (boardWriter)
	 * @return List<WriterFileDTO> 일치하는 파일리스트
	 */
	WriterFileDTO getSenderInfo(WriterFileDTO wfDTO);

}
