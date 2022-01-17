package com.itkey.sam.board.dto;

public class WriterFileDTO {
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
	
	private String fileOriginalName;
	private String fileChangedName;
	private String FilePath;
	
	private String message;
	
	private int check;
	
	
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
	public String getFileOriginalName() {
		return fileOriginalName;
	}
	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	public String getFileChangedName() {
		return fileChangedName;
	}
	public void setFileChangedName(String fileChangedName) {
		this.fileChangedName = fileChangedName;
	}
	public String getFilePath() {
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	
	
}
