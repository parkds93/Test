<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
	<form action="modify.do" method="post">
		<input type="hidden" value="${bList[0].boardIdx}" name="boardIdx">
			<input type="button" value="연습">
			<table border="1" style="text-align: center; margin: 100px auto;">
			<tr>
				<td>글제목</td>
				<td><input type="text" name="boardTitle" value="${bList[0].boardTitle }"></td>
			</tr>
			<tr>
				<td>글작성자</td>
				<td><input type="text" name="boardWriter" value="${bList[0].boardWriter }"></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="boardContents" style="width: 500px; height: 500px;">${bList[0].boardContents}</textarea>
				</td>
			</tr>
			<tr >
				<td colspan="2">
					<input type="submit" value="수정하기">
					<input type="button" value="삭제하기" onclick="location.href='delete.do?boardIdx=${bList[0].boardIdx}'">
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>