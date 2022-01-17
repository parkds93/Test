package com.itkey.sam.board.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterFileDTO;
import com.itkey.sam.board.model.dao.FileDao;

@Service
public class FileServiceImpl implements FileService {
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired FileDao fileDao;
	
	
	@Override
	public List<FileDTO> saveFile(List<MultipartFile> files) throws IllegalStateException, IOException {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + files.toString());
		
		String uploadPath = "C:\\Spring\\ExProject\\src\\main\\webapp\\resources\\images\\upload/";
		FileDTO fileDTO = null;
		List<FileDTO> savedFiles = new ArrayList<FileDTO>();
		
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdirs();
		}
		
		for (MultipartFile file : files) {
			UUID uid = UUID.randomUUID();

			logger.info("originalName: " + file.getOriginalFilename());
			logger.info("size: " + file.getSize());
			logger.info("contentType: " + file.getContentType());
			logger.info("uploadPath: " + uploadPath);

			String savedName = uid.toString() + "_" + file.getOriginalFilename();
			logger.info("UUID savedName: " + savedName);

			File target = new File(uploadPath, savedName);

			file.transferTo(target);
			
			fileDTO = new FileDTO();
			fileDTO.setFileChangedName(savedName);
			fileDTO.setFileOriginalName(file.getOriginalFilename());
			fileDTO.setFilePath(uploadPath);
			
			fileDTO = fileDao.saveFile(fileDTO);
			savedFiles.add(fileDTO);
			
		}
		
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + savedFiles.size());
		return savedFiles;
	}
	
	@Override
	public List<FileDTO> getFiles(String[] fileIdx) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + fileIdx.length);
		List<FileDTO> out = fileDao.getFile(fileIdx);
		logger.debug("* [SERVICE] Output ◀ (DAO) : " + out.size());
		return out;
	}

	@Override
	public WriterFileDTO getSenderInfo(WriterFileDTO wfDTO) {
		logger.debug("* [SERVICE] Input  ◀ (Controller) : " + wfDTO.getBoardWriter());
		wfDTO = fileDao.getSenderInfo(wfDTO);
		logger.debug("* [SERVICE] Output ◀ (DAO) : : " + wfDTO.toString());
		return wfDTO;
	}
}
