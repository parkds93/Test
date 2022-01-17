package com.itkey.sam.board.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WriterDTO {
	private int boardWriterIdx			= 0;
	private String boardWriter			= null;
	private String boardWriterName		= null;
	private String boardWriterPw		= null;
	private String boardWriterPhone		= null;
	private String boardWriterEmail		= null;
	private int fileIdx					= 0;
	private String boardWriterJoinDate	= null;
	private String salt					= null;;
	private String delVN				= null;
	//아이디 체크용
	private int check					= 0;
	//paging
	private int row						= 0;
	private int offset					= 0;
	//검색
	private String searchText			=null;
	private String searchTag			=null;
	//file정보
	private String filepath				=null;
	private String fileChangedName		=null;
	
	
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getFileChangedName() {
		return fileChangedName;
	}
	public void setFileChangedName(String fileChangedName) {
		this.fileChangedName = fileChangedName;
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
	public int getBoardWriterIdx() {
		return boardWriterIdx;
	}
	public void setBoardWriterIdx(int boardWriterIdx) {
		this.boardWriterIdx = boardWriterIdx;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardWriterName() {
		return boardWriterName;
	}
	public void setBoardWriterName(String boardWriterName) {
		this.boardWriterName = boardWriterName;
	}
	public String getBoardWriterPw() {
		return boardWriterPw;
	}
	public void setBoardWriterPw(String boardWriterPw) {
		this.boardWriterPw = boardWriterPw;
	}
	public String getBoardWriterPhone() {
		return boardWriterPhone;
	}
	public void setBoardWriterPhone(String boardWriterPhone) {
		this.boardWriterPhone = boardWriterPhone;
	}
	public String getBoardWriterEmail() {
		return boardWriterEmail;
	}
	public void setBoardWriterEmail(String boardWriterEmail) {
		this.boardWriterEmail = boardWriterEmail;
	}
	public int getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(int fileIdx) {
		this.fileIdx = fileIdx;
	}
	public String getBoardWriterJoinDate() {
		return boardWriterJoinDate;
	}
	public void setBoardWriterJoinDate(String boardWriterJoinDate) {
		this.boardWriterJoinDate = boardWriterJoinDate;
	}
	public String getSalt() {
		return salt;
	}
	public void setSalt(String salt) {
		this.salt = salt;
	}
	public String getDelVN() {
		return delVN;
	}
	public void setDelVN(String delVN) {
		this.delVN = delVN;
	}
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	};
	
	
}
