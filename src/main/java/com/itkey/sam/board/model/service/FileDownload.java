/*package com.itkey.sam.board.model.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownload extends AbstractView {
	public void Download() {
		setContentType("application/download; utf-8");
	} // 파일 다운로드 
	@Override protected void renderMergedOutputModel(Map paramMap, HttpServletRequest request, HttpServletResponse response)throws Exception
	{
		File file = (File) paramMap.get("downloadFile");
		response.setContentType(getContentType());
		response.setContentLength((int) file.length());
		Map map = new HashMap();
		map.put("fileNm", file.getName());
		String temp_fileName = fileService.getFileOrigNm(map);
		String ori_fileName = getDisposition(temp_fileName, getBrowser(request));
		response.setHeader("Content-Disposition", "attachment; filename=\"" + ori_fileName + "\";"); // 이부분에 파일이름 파라미터를
																										// 넣어주면 된다.
		response.setHeader("Content-Transfer-Encoding", "binary");
		OutputStream out = response.getOutputStream();
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(file);
			FileCopyUtils.copy(fis, out);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}
		}
		out.flush();
	}
}
*/