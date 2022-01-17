package com.itkey.sam.board.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class BoardDTO {
	
	private String boardIdx          = null;
	private String boardWriter       = null;
	private String boardTitle        = null;
	private String boardContents     = null;
	private String boardViewCount    = null;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date   boardWriteDate	 = null;
	private String boardPublicFl	 = null;
	private String boardDelYn		 = null;
	private String fileIdx           = null;
	
	private int row           	= 0;
	private int offset           = 0;
	
	private String searchText		 = null;
	private String searchTag		 = null;
	
	public String getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(String boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContents() {
		return boardContents;
	}
	public void setBoardContents(String boardContents) {
		this.boardContents = boardContents;
	}
	public String getBoardViewCount() {
		return boardViewCount;
	}
	public void setBoardViewCount(String boardViewCount) {
		this.boardViewCount = boardViewCount;
	}
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public Date getBoardWriteDate() {
		return boardWriteDate;
	}
	public void setBoardWriteDate(Date boardWriteDate) {
		this.boardWriteDate = boardWriteDate;
	}
	public String getBoardPublicFl() {
		return boardPublicFl;
	}
	public void setBoardPublicFl(String boardPublicFl) {
		this.boardPublicFl = boardPublicFl;
	}
	public String getBoardDelYn() {
		return boardDelYn;
	}
	public void setBoardDelYn(String boardDelYn) {
		this.boardDelYn = boardDelYn;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getSearchTag() {
		return searchTag;
	}
	public void setSearchTag(String searchTag) {
		this.searchTag = searchTag;
	}
	
}