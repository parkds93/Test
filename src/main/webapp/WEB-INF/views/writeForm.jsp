<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>
	<div class="container" style="text-align: center;">
	<form action="write.do" method="post">
		<h2 style="margin:30px auto;">글작성하기</h2>
		<table border="1" style="text-align: center; margin:auto;">
			<tr>
				<td>글제목</td>
				<td><input type="text" name="boardTitle"></td>
			</tr>
			<tr>
				<td>글작성자</td>
				<td><input type="text" name="boardWriter"></td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="boardContents" style="width: 500px; height: 500px;"></textarea>
				</td>
			</tr>
			<tr >
				<td colspan="2">
					<input type="submit" value="작성하기">
					<input type="reset" value="다시작성">
				</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>