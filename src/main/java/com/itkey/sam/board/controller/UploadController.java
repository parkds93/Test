package com.itkey.sam.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.LoginService;

@Controller
public class UploadController {
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	@Autowired
	FileService fileService;

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : UploadController.java
	 * @작성일자 : 2022. 1. 10.
	 * @작성자 : USER
	 * @메소드 이름 : uploadForm
	 * @메소드 설명 : 업로드 수행, 업로드한 파일list 리턴
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "upload.do", method = RequestMethod.POST)
	@ResponseBody
	public List<FileDTO> uploadForm(MultipartRequest multipartRequest) throws Exception {

		/*
		 * String uploadPath = ((HttpServletRequest)
		 * multipartRequest).getSession().getServletContext().getRealPath(
		 * "resource/images/upload/");
		 */
		List<MultipartFile> files = multipartRequest.getFiles("file");
		List<FileDTO> savedFiles = fileService.saveFile(files);

		return savedFiles;
	}

	@RequestMapping(value = "download.do")
	public void downloadFile(@RequestParam Map<String, Object> requestParam, HttpServletRequest request,
							HttpServletResponse response) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		String fileIdx = (String)requestParam.get("fileIdx");
		String[] fileIdxs = { fileIdx };
		FileDTO fDTO = null;
		List<FileDTO> f = fileService.getFiles(fileIdxs);
		fDTO = f.get(0);

		File file = new File(fDTO.getFilePath(), fDTO.getFileChangedName());

		BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));

		// User-Agent : 어떤 운영체제로 어떤 브라우저를 서버( 홈페이지 )에 접근하는지 확인함
		String header = request.getHeader("User-Agent");
		String fileName;

		if ((header.contains("MSIE")) || (header.contains("Trident")) || (header.contains("Edge"))) {
			// 인터넷 익스플로러 10이하 버전, 11버전, 엣지에서 인코딩
			fileName = URLEncoder.encode(fDTO.getFileOriginalName(), "UTF-8");
		} else {
			// 나머지 브라우저에서 인코딩
			fileName = new String(fDTO.getFileOriginalName().getBytes("UTF-8"), "iso-8859-1");
		}
		// 형식을 모르는 파일첨부용 contentType
		response.setContentType("application/octet-stream");
		// 다운로드와 다운로드될 파일이름
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		// 파일복사
		FileCopyUtils.copy(in, response.getOutputStream());
		in.close();
		response.getOutputStream().flush();
		response.getOutputStream().close();
		}
}