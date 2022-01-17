package com.itkey.sam.board.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itkey.sam.board.dto.BoardDTO;
import com.itkey.sam.board.dto.WriterDTO;
import com.itkey.sam.board.model.service.BoardService;
import com.itkey.sam.board.model.service.FileService;
import com.itkey.sam.board.model.service.LoginService;
import com.itkey.sam.board.model.service.Paging;

@Controller
public class AdminController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// Dependency Injection With BoardService
	@Autowired
	BoardService boardService;
	@Autowired
	LoginService loginService;
	@Autowired
	FileService fileService;

	@RequestMapping(value = "adminBoard.do")
	public ModelAndView adminBoard(@RequestParam Map<String, Object> requestParam, BoardDTO bDTO) throws Exception {
		ModelAndView mv = new ModelAndView("adminBoard");
		String currentPage = (String) requestParam.get("currentPage");
		String searchText = (String) requestParam.get("searchText");
		String searchTag = (String) requestParam.get("searchTag");
		// 총 갯수
		int bTotCnt = boardService.getBoardCount(bDTO);

		bDTO.setSearchTag(searchTag);
		bDTO.setSearchText(searchText);

		Paging pg = new Paging(bTotCnt, currentPage);

		bDTO.setOffset(pg.getOffset());
		bDTO.setRow(pg.getRow());
		// 보여질 총 갯수
		int rTotCnt = boardService.getBoardCount(bDTO);
		WriterDTO wDTO = new WriterDTO();
		int wTotCnt = boardService.getWriterTotalCnt(wDTO);
		int twTotCnt = boardService.getTodayWriterTotalCnt();
		int tbTotCnt = boardService.getTodayBoardListCnt();

		List<BoardDTO> bList = boardService.getBoardList(bDTO);

		mv.addObject("pg", pg);
		mv.addObject("bList", bList);
		mv.addObject("rTotCnt", rTotCnt);
		mv.addObject("bTotCnt", bTotCnt);
		mv.addObject("wTotCnt", wTotCnt);
		mv.addObject("twTotCnt", twTotCnt);
		mv.addObject("tbTotCnt", tbTotCnt);
		mv.addObject("searchText",searchText);
		mv.addObject("searchTag",searchTag);

		return mv;
	}

	@RequestMapping(value = "adminMember.do")
	public ModelAndView adminMember(@RequestParam Map<String, Object> requestParam, WriterDTO wDTO) throws Exception {
		ModelAndView mv = new ModelAndView("adminMember");

		String currentPage = (String) requestParam.get("currentPage");
		String searchText = (String) requestParam.get("searchText");
		String searchTag = (String) requestParam.get("searchTag");

		int wTotCnt = boardService.getWriterTotalCnt(wDTO);

		wDTO.setSearchTag(searchTag);
		wDTO.setSearchText(searchText);

		int rTotCnt = boardService.getWriterTotalCnt(wDTO);
		BoardDTO bDTO = new BoardDTO();
		int bTotCnt = boardService.getBoardCount(bDTO);
		int twTotCnt = boardService.getTodayWriterTotalCnt();
		int tbTotCnt = boardService.getTodayBoardListCnt();

		Paging pg = new Paging(rTotCnt, currentPage);

		wDTO.setRow(pg.getRow());
		wDTO.setOffset(pg.getOffset());

		List<WriterDTO> wList = loginService.getWriterList(wDTO);

		mv.addObject("pg", pg);
		mv.addObject("wList", wList);
		mv.addObject("rTotCnt", rTotCnt);
		mv.addObject("bTotCnt", bTotCnt);
		mv.addObject("wTotCnt", wTotCnt);
		mv.addObject("twTotCnt", twTotCnt);
		mv.addObject("tbTotCnt", tbTotCnt);
		mv.addObject("searchText",searchText);
		mv.addObject("searchTag",searchTag);
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "deleteB.do", method = RequestMethod.POST)
	public String deleteB(String[] array) {

		for (int i = 0; i < array.length; i++)
			logger.debug("array[" + i + "] = " + array[i]);

		int result = boardService.selectDelBoard(array);
		String str = "";
		if (result > 0)
			str = "삭제된 게시글 갯수 ->" + result;
		else
			str = "삭제된 게시글이 없습니다";

		return str;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteW.do", method = RequestMethod.POST)
	public String deleteW(String[] array) {

		for (int i = 0; i < array.length; i++)
			logger.debug("array[" + i + "] = " + array[i]);

		int result = loginService.selectDelWriter(array);
		
		String str = "";
		if (result > 0)
			str = "삭제된 회원수 ->" + result;
		else
			str = "삭제된 회원이 없습니다";

		return str;
	}
}
