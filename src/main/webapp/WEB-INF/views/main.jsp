<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ITKey 게시판</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="resources/css/table.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">

<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
<script type="text/javascript">
	window.onload=function(){
		if(${pg.currentPage<10}){
			$("#pageNum:nth-child(${(pg.currentPage-pg.startPage)+1})" ).attr('class','active');
		}else
			$("#pageNum:nth-child(${(pg.currentPage-pg.startPage)+2})" ).attr('class','active');
	};
	
	function searchStart(){
		var searchText = $("#searchText").val();
		var searchTag = $("#searchTag").val();
		if(searchText.length<2){
			alert("검색어는 2글자 이상 작성하셔야 합니다.");
			return false;
		}
		location.href= "main.do?searchText="+searchText+"&searchTag="+searchTag;;
	}
	
 	function detail(writer, privacy, boardIdx) {
		alert(writer);
		alert(privacy);
		alert(boardIdx);
		
		if(privacy == 'Y'){
			location.href="detail.do?boardIdx="+boardIdx+"&boardPublicFl="+privacy;
		}else{
			if('${id}' != writer){
				alert("비공개 글은 관리자와 본인을 제외한 다른 사용자는 접근이 불가합니다.");
			}else{
				
				location.href= "detail.do?boardIdx="+boardIdx+"&boardPublicFl="+privacy;
			}
		}
	} 
	
/* 	function detail(list) {
		alert(list);
		alert(list['boardPublicFl']);
		alert(list['boardWriter']);
		alert(list['boardIdx']);
		
		if(list.boardPublicFl == 'Y'){
			location.href="detail.do?boardIdx="+boardIdx;
		}else{
			if(${id} != list.boardWriter){
				alert("비공개 글은 관리자와 본인을 제외한 다른 사용자는 접근이 불가합니다.");
			}else{
				location.href="detail.do?boardIdx="+list.boardIdx;
			}
		}
	} */
	
</script>
</head>

<body>

	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today"/>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div>
							<h3 style="float: left">
								[안녕하세요. <b>${writerName }</b>님]
							</h3>
							<div align="right">
								<button type="button" class="btn btn-default" id="logOut" onclick="location.href='login.do'">로그아웃</button>
							</div>
						</div> 
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content">${btotCnt }</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content">${wTotCnt }</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content">${tbTotCnt }</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content">${twTotCnt }</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default" onclick="location.href='write.do'">
								<i class="fas fa-plus"></i> 새글 추가
							</button>
							<button type="button" class="btn btn-default" onclick="location.href='chat.do'">채팅하기</button>
							<button type="button" class="btn btn-default" onclick="location.href='userModify.do'">정보수정</button>
						</div>
						<div class="col-sm-2"></div>

						<div class="col-sm-2">
							<select class="form-control" id="searchTag">
								<option value="all">전체</option>
								<option value="boardWriter">작성자</option>
								<option value="boardContents">글내용</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="searchText" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full" onclick="searchStart()">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>

						
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 8%;">조회수</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="board" items="${list}">
									<fmt:formatDate value="${board.boardWriteDate }" var="boardWrite" pattern="yyyy-MM-dd" />
									<tr>
										<td>${board.boardIdx }</td>
										<td>${board.boardWriter }</td>
										<td>
											<c:if test="${board.boardPublicFl == 'Y'}">
												<i class="fas fa-lock-open"></i>
											</c:if>
											<c:if test="${board.boardPublicFl == 'N'}">
												<i class="fas fa-lock"></i>
											</c:if>
										</td>
										<td>
											<a href="#" onclick="detail('${board.boardWriter}','${board.boardPublicFl}',${board.boardIdx})">${board.boardTitle }</a>
											<%-- <a href="#" onclick="detail('${board}')">${board.boardTitle }</a> --%>
											<c:if test="${today == boardWrite }">
												<i class="far fa-eye"></i>
											</c:if>
										</td>
										<td><fmt:formatDate value="${board.boardWriteDate }" pattern="yyyy-MM-dd" />
										</td>
										
										<td>${board.boardViewCount }</td>
									</tr>
									</c:forEach>
<!-- 									<tr>
										<td>1</td>
										<td>테스트</td>
										<td>
											<i class="fas fa-lock-open"></i>
										</td>
										<td>하이하이</td>
										<td>2019-10-13</td>
										<td>2</td>
									</tr> -->

								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">							
							<ul class="pagination" id="pagination">
								<c:if test="${pg.startPage > pg.pageBlock }">
									<li><a href="main.do?currentPage=${pg.startPage-pg.pageBlock}&searchText=${searchText}&searchTag=${searchTag}">이전</a></li>
								</c:if>
								<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">
									<li id="pageNum"><a href="main.do?currentPage=${i}&searchText=${searchText}&searchTag=${searchTag}">${i}</a></li>
								</c:forEach>
								<c:if test="${pg.endPage < pg.totalPage }">
									<li><a href="main.do?currentPage=${pg.startPage+pg.pageBlock}&searchText=${searchText}&searchTag=${searchTag}">다음</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>
</html>