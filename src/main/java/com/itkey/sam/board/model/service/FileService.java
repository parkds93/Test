package com.itkey.sam.board.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterFileDTO;

public interface FileService {
	/**
	 * 파일 저장
	 * @param files 저장될 파일 정보
	 * @return 성공시 file idx리턴
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	List<FileDTO> saveFile(List<MultipartFile> files) throws IllegalStateException, IOException;
	
	/**
	 * 파일 가져오기
	 * @param fileIdx 가져올 파일 인덱스s
	 * @return List<FileDTO> 일치하는 파일리스트
	 */
	List<FileDTO> getFiles(String[] fileIdx);
	
	/**
	 * 송신자 정보 가져오기
	 * @param wfDTO (boardWriter)
	 * @return List<WriterFileDTO> 일치하는 파일리스트
	 */
	WriterFileDTO getSenderInfo(WriterFileDTO wfDTO);

}
