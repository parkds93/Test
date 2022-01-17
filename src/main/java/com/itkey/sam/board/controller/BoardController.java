package com.itkey.sam.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.aop.Logincheck;
import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.FileDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.LoginService;
import com.itkey.sam.board.model.service.Paging;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class BoardController {
	// Logback logger (package : org.slf4j.Logger & org.slf4j.LoggerFactory)
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// Dependency Injection With BoardService
	@Autowired
	BoardService boardService;
	@Autowired
	LoginService loginService;
	@Autowired
	FileService fileService;

	/**
	 * @param requestParam
	 * @Method Post
	 * @return ModelAndView
	 * @url [default] http://localhost:8080/sam/main.do
	 * @throws Exception
	 */
	@Logincheck
	@RequestMapping(value = "/main.do")
	public ModelAndView sample(@RequestParam Map<String, Object> requestParam, String currentPage, String searchText,
			String searchTag, HttpServletRequest request) throws Exception {

		String id = (String) request.getSession().getAttribute("id");

			WriterDTO writer = new WriterDTO();
			writer.setBoardWriter(id);
			writer = boardService.getWriter(writer);
		// Logger
		logger.debug("Board List Page Response");

		ModelAndView mv = new ModelAndView("main");
		BoardDTO eDTO = new BoardDTO();
		// 총갯수 보여줄 Cnt
		int bTotCnt = boardService.getBoardCount(eDTO);

		// 검색어 들어왔을때
		eDTO.setSearchTag(searchTag);
		eDTO.setSearchText(searchText);

		// 실제 보여질 갯수 Cnt
		int rTotCnt = boardService.getBoardCount(eDTO);
		// Paging
		Paging pg = new Paging(rTotCnt, currentPage);

		eDTO.setRow(pg.getRow());
		eDTO.setOffset(pg.getOffset());

		logger.debug("* [CONTROLLER] Input �뼳 (Service) : " + eDTO.toString());

		List<BoardDTO> bList = boardService.getBoardList(eDTO);

		int tbTotCnt = boardService.getTodayBoardListCnt();
		WriterDTO wDTO = new WriterDTO();
		int wTotCnt = boardService.getWriterTotalCnt(wDTO);
		int twTotCnt = boardService.getTodayWriterTotalCnt();

		mv.addObject("pg", pg);
		mv.addObject("list", bList);
		mv.addObject("tbTotCnt", tbTotCnt);
		mv.addObject("wTotCnt", wTotCnt);
		mv.addObject("twTotCnt", twTotCnt);
		mv.addObject("btotCnt", bTotCnt);
		mv.addObject("writerName", writer.getBoardWriterName());
		mv.addObject("searchText", searchText);
		mv.addObject("searchTag", searchTag);
		return mv;
	}

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : BoardController.java
	 * @작성일자 : 2021. 12. 27.
	 * @작성자 : 박대성
	 * @메소드 이름 : writeForm
	 * @메소드 설명 : 글작성 페이지로 갑니다
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "/write.do")
	public ModelAndView writeForm() {

		ModelAndView mv = new ModelAndView("write");

		return mv;
	}

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : BoardController.java
	 * @작성일자 : 2021. 12. 27.
	 * @작성자 : 박대성
	 * @메소드 이름 : write
	 * @메소드 설명 : 실제로 글작성이 되는 메서드입니다
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String write(BoardDTO eDTO) throws Exception {

		int result = boardService.addBoard(eDTO);

		return "redirect:main.do";
	}

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : BoardController.java
	 * @작성일자 : 2021. 12. 27.
	 * @작성자 : 박대성
	 * @메소드 이름 : detail
	 * @메소드 설명 : 글 상세정보를 보러갑니다
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "/detail.do")
	public ModelAndView detail(@RequestParam Map<String, Object> requestParam) throws Exception {

		ModelAndView mv = new ModelAndView("detail");
		BoardDTO eDTO = new BoardDTO();
		BoardDTO pre, current, next;

		String boardIdx = (String) requestParam.get("boardIdx");
		eDTO.setBoardIdx(boardIdx);
		List<BoardDTO> bList = boardService.getBoardDetail(eDTO);

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
		List<FileDTO> files = null;
		
		if (current.getFileIdx() != null) {
			String[] fileIdx = current.getFileIdx().split(",");
			for (int i = 0; i < fileIdx.length; i++) {
				logger.debug("fileIdx" + i + "->" + fileIdx[i]);
			}
			files = fileService.getFiles(fileIdx);
		}
		
		mv.addObject("files", files);
		mv.addObject("pre", pre);
		mv.addObject("next", next);
		mv.addObject("current", current);

		return mv;
	}

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : BoardController.java
	 * @작성일자 : 2021. 12. 27.
	 * @작성자 : USER
	 * @메소드 이름 : modify
	 * @메소드 설명 : 수정 메서드
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "/boardModify.do")
	public ModelAndView modify(Model model, BoardDTO eDTO) throws Exception {
		ModelAndView mv = new ModelAndView("boardModify");
		List<BoardDTO> board = boardService.getBoardList(eDTO);
		
		List<FileDTO> files = null;
		
		if (board.get(0).getFileIdx() != null) {
			String[] fileIdx = board.get(0).getFileIdx().split(",");
			for (int i = 0; i < fileIdx.length; i++) {
				logger.debug("fileIdx" + i + "->" + fileIdx[i]);
			}
			files = fileService.getFiles(fileIdx);
		}
		
		mv.addObject("files", files);
		mv.addObject("board", board.get(0));

		return mv;
	}
	
	@RequestMapping(value = "/boardModify.do", method=RequestMethod.POST)
	public ModelAndView modify(BoardDTO eDTO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:main.do");
		
		int result = boardService.chgBoard(eDTO);

		return mv;
	}

	/**
	 * =======================[ Method ]=======================
	 * 
	 * @파일명 : BoardController.java
	 * @작성일자 : 2021. 12. 27.
	 * @작성자 : USER
	 * @메소드 이름 : delete
	 * @메소드 설명 : 삭제 메서드
	 * @변경이력 : =======================[ ITKey ]========================
	 */
	@RequestMapping(value = "/deleteBoard.do")
	public String delete(Model model, @RequestParam Map<String, Object> requestParam) throws Exception {
		String keyId = (String) requestParam.get("boardIdx");
		int result = boardService.delBoard(keyId);

		model.addAttribute("result", result);
		return "redirect:main.do";
	}
	
	@RequestMapping(value = "/chat.do")
	public ModelAndView delete(@RequestParam Map<String, Object> requestParam) {
		ModelAndView mv = new ModelAndView("chat");

		return mv;
	}

}
