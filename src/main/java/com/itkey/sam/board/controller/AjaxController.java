package com.itkey.sam.board.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.LoginService;
import com.itkey.sam.board.model.service.Paging;
import com.itkey.sam.board.model.service.SHA256Util;

@Controller
public class AjaxController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired LoginService loginService;
	@Autowired BoardService boardService;
	@Autowired FileService fileService;
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : PDS
	* @메소드 이름 : ajaxMain 
	* @메소드 설명 : 메인페이지
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@RequestMapping(value="ajaxMain.do")
	public ModelAndView ajaxMain(@RequestParam Map<String,Object> requestParam,
								  HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("ajaxMain");
		return mv;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : PDS
	* @메소드 이름 : ajaxLogin 
	* @메소드 설명 : 로그인
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	
	@ResponseBody
	@RequestMapping(value="ajaxLogin.do", method=RequestMethod.POST)
	public WriterDTO ajaxLogin(@RequestParam Map<String,Object> requestParam,
								HttpServletRequest request) throws NoSuchAlgorithmException{
		String id = (String)requestParam.get("id");
		String pw = (String)requestParam.get("pw");
		String hashpw = "";
		logger.debug("Login ID -> " + id);
		logger.debug("Login PW -> " + pw);
		WriterDTO writer = new WriterDTO();
		writer.setBoardWriter(id);
		List<WriterDTO> wDTO = loginService.getWriterList(writer);
		// 접속 pw 해쉬화해서 데이터베이스 pw 와 비교
		if(!wDTO.isEmpty()) {
			String salt = wDTO.get(0).getSalt();
			hashpw = SHA256Util.getHashPw(salt,pw);
			// 파일 이름 가져오기
			String[] fileIdx = new String[] {wDTO.get(0).getFileIdx()+""};
			List<FileDTO> fileDTO = fileService.getFiles(fileIdx);
			writer.setFileChangedName(fileDTO.get(0).getFileChangedName());
			
			logger.debug("해쉬된 pw 확인"+hashpw);
			logger.debug("저장된 비밀번호 확인"+wDTO.get(0).getBoardWriterPw());

		}
		// 0 아이디불일치-1 비밀번호불일치 1 로그인성공 
		if(wDTO.isEmpty()) {
			System.out.println("아이디틀림");
			writer.setCheck(0);
		}else if(wDTO.get(0).getBoardWriterPw().equals(hashpw)) {
			System.out.println("통과");
			writer.setCheck(1);
			request.getSession().setAttribute("id", id);
			request.getSession().setAttribute("currentView", "board");
			request.getSession().setAttribute("fileChangedName", writer.getFileChangedName());
		}else {
			System.out.println("비밀번호틀림");
			writer.setCheck(-1);
		}
		
		return writer;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : USER
	* @메소드 이름 : ajaxLogout 
	* @메소드 설명 : 현재 세션 가져오기.
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@ResponseBody
	@RequestMapping(value="ajaxLogout.do")
	public void ajaxLogout(HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession().setAttribute("currentView", "main");
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : USER
	* @메소드 이름 : ajaxBoardList 
	* @메소드 설명 : 게시판 리스트 가져오기.
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@ResponseBody
	@RequestMapping(value="ajaxBoardList.do")
	public List<BoardDTO> ajaxBoardList(@RequestParam Map<String,Object> requestParam,
										HttpServletRequest request) throws Exception {
		String currentPage = (String)requestParam.get("currentPage");
		String searchText = (String)requestParam.get("searchText");
		String searchTag = (String)requestParam.get("searchTag");
		logger.debug("searchText ->"+searchText);
		logger.debug("searchTag ->"+searchTag);
		
		BoardDTO bDTO = new BoardDTO();
		bDTO.setSearchTag(searchTag);
		bDTO.setSearchText(searchText);
		int bTotCnt = boardService.getBoardCount(bDTO);
		 
		Paging pg = new Paging(bTotCnt,currentPage);
		bDTO.setRow(pg.getRow());
		bDTO.setOffset(pg.getOffset());
		
		List<BoardDTO> bList = boardService.getBoardList(bDTO);
		return bList;
		
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : USER
	* @메소드 이름 : ajaxRegister 
	* @메소드 설명 : 회원가입
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@ResponseBody
	@RequestMapping(value="ajaxRegister.do")
	public WriterDTO ajaxRegister(WriterDTO writer, HttpServletRequest request) throws NoSuchAlgorithmException {
		logger.debug("ajaxRegisterForm Page Response");
		
		String pw = writer.getBoardWriterPw();
		// 염장하기
		String salt =  SHA256Util.makeSalt();
		String hashPw = SHA256Util.getHashPw(salt,pw);


		writer.setBoardWriterPw(hashPw);
		writer.setSalt(salt);
		
		int result = loginService.register(writer);
		
		//아이디 세션 저장
		if(result==1) {
			request.getSession().setAttribute("id", writer.getBoardWriter());
		}
		
		return writer;
	}
	
	/**
	* =======================[ Method ]=======================
	* @파일명 : AjaxController.java
	* @작성일자 : 2022. 1. 10. 
	* @작성자 : USER
	* @메소드 이름 : ajaxCount 
	* @메소드 설명 : 
	* @변경이력 : 
	* =======================[ ITKey ]========================
	*/
	@ResponseBody
	@RequestMapping(value="ajaxCount.do")
	public Map<String,String> ajaxCount() throws Exception {
		Map<String,String> map = new HashMap<String, String>();
		WriterDTO wDTO = new WriterDTO();
		BoardDTO bDTO = new BoardDTO();;
		
		int bTotCnt = boardService.getBoardCount(bDTO);
		int wTotCnt = boardService.getWriterTotalCnt(wDTO);
		int tbTotCnt = boardService.getTodayBoardListCnt();
		int twTotCnt = boardService.getTodayWriterTotalCnt();
		
		map.put("bTotCnt", bTotCnt+"");
		map.put("wTotCnt", wTotCnt+"");
		map.put("tbTotCnt", tbTotCnt+"");
		map.put("twTotCnt", twTotCnt+"");
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxGetSession.do")
	public Map<String,String> ajaxGetSession(HttpServletRequest request) throws Exception {
		Map<String,String> map = new HashMap<String, String>();
		
		map.put("id",(String)request.getSession().getAttribute("id"));
		map.put("currentView",(String)request.getSession().getAttribute("currentView"));
		map.put("fileChangedName",(String)request.getSession().getAttribute("fileChangedName"));
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxWriterModify.do")
	public Map<String,Object> ajaxWriterModify(WriterDTO writer, HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		String salt = SHA256Util.makeSalt();
		String hashPw = SHA256Util.getHashPw(salt, writer.getBoardWriterPw());
		writer.setBoardWriterPw(SHA256Util.getHashPw(salt, writer.getBoardWriterPw()));
		writer.setSalt(salt);
		writer.setBoardWriterPw(hashPw);
		int result = loginService.updateWriter(writer);
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxDetail.do")
	public Map<String,Object> ajaxDetail(@RequestParam Map<String,Object> requestParam,
										HttpServletRequest request) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		String boardIdx = (String)requestParam.get("boardIdx");
		BoardDTO bDTO = new BoardDTO();
		BoardDTO current,next,pre;
		bDTO.setBoardIdx(boardIdx);
		List<BoardDTO> bList = boardService.getBoardDetail(bDTO);
		
		if (bList.size() < 3) {
			if (bList.get(0).getBoardIdx() == boardIdx) {
				current = bList.get(0);
				next = bList.get(1);
				pre = null;
			} else
				current = bList.get(1);
				pre = bList.get(0);
				next = null;
		} else {
			pre = bList.get(0);
			current = bList.get(1);
			next = bList.get(2);
		}
		if(current.getFileIdx() != null) {
			String fileIdx = current.getFileIdx();
			String[] files = fileIdx.split(",");
			List<FileDTO> fDTO = fileService.getFiles(files);
			
			map.put("files", fDTO);
			
			for(FileDTO file : fDTO) {
				logger.debug("fileNmae -> "+file.getFileOriginalName());
			}
		}
		
		map.put("current", current);
		map.put("pre", pre);
		map.put("next", next);
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxWriterBoard.do")
	public Map<String,Object> ajaxWriterBoard(BoardDTO bDTO, MultipartHttpServletRequest multipartRequest) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		/*fileIdx 추출*/
		String fileIdxs = "";
		List<MultipartFile> files = multipartRequest.getFiles("file");
		if(files.size()>0) {
			List<FileDTO> savedFiles = fileService.saveFile(files);
			
			for(int i=0 ; i < savedFiles.size() ; i++) {
				fileIdxs += savedFiles.get(i).getFileIdx();
				if(i+1==savedFiles.size()) {	
					break;
				}else {
					fileIdxs += ",";
				}
			}
			logger.debug(fileIdxs);
			bDTO.setFileIdx(fileIdxs);
		}
		

		int result =boardService.addBoard(bDTO);
		map.put("result", result);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value="ajaxBoardModify.do")
	public Map<String,Object> ajaxzBoardModify(@RequestParam Map<String,Object> requestParam,
												MultipartHttpServletRequest multiRequest,
												BoardDTO bDTO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		/*파일저장*/
		List<MultipartFile> files = multiRequest.getFiles("file");
		
		if(files.size()>0) {
			List<FileDTO> fDTO = fileService.saveFile(files);
			bDTO.setFileIdx(fDTO.get(0).getFileIdx());
		}
		int result = boardService.chgBoard(bDTO);
		
		map.put("result", result);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="ajaxBoardDelete.do")
	public Map<String,Object> ajaxBoardDelete(@RequestParam Map<String,Object> requestParam,
												MultipartHttpServletRequest multiRequest,
												BoardDTO bDTO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		String boardIdx = (String)requestParam.get("boardIdx");
		int result = boardService.delBoard(boardIdx);
		
		map.put("result", result);
		return map;
	}
}
