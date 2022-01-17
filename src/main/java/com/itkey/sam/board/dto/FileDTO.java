package com.itkey.sam.board.dto;

public class FileDTO {
	
	private String fileIdx;
	private String fileOriginalName;
	private String fileChangedName;
	private String FilePath;
	
	public String getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(String fileIdx) {
		this.fileIdx = fileIdx;
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
