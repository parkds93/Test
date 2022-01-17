<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" type="text/css" href="resources/css/chat.css">
<link rel="stylesheet" type="text/css" href="resources/css/ajax.main.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">

<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/0.3.4/sockjs.min.js"></script>
<script src="resources/vendor/animsition/js/animsition.min.js"></script>
<script src="resources/vendor/bootstrap/js/popper.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/vendor/select2/select2.min.js"></script>
<script src="resources/vendor/daterangepicker/moment.min.js"></script>
<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
<script src="resources/vendor/countdowntime/countdowntime.js"></script>
<script src="resources/js/main.js"></script>
<script>
	$(document).ready(function() {
		var session = getSession();
		if(session.id != null){
			boardList(1);
			afterLoginSet();
		}else{
			viewPage($("#main"));
		}
		$("#btn-chat").click(function() {
			if($("#btn-input").val()==""){
				alert("내용을 입력해주세요");
				$("#btn-input").focus();
			}else{
				sendMessage();
				$("#btn-input").val("");
				$("#btn-input").focus();
			}
		});	
	});
	
	var sock;
	//웸소켓을 지정한 url로 연결한다.
	sock = new SockJS("<c:url value="/chat"/>");
	
	//자바스크립트 안에 function을 집어넣을 수 있음.
	//데이터가 나한테 전달되읐을 때 자동으로 실행되는 function
	sock.onmessage = onMessage;
	
	//데이터를 끊고싶을때 실행하는 메소드
	sock.onclose = onClose;
	
	/* sock.onopen = function(){
	    sock.send($("#message").val());
	}; */
	function sendMessage() {
		/*소켓으로 보내겠다.  */
		sock.send($("#btn-input").val());
	}
	
	//evt 파라미터는 웹소켓을 보내준 데이터다.(자동으로 들어옴)
	function onMessage(evt) {
		var currentSender = '${id}';
		var data = JSON.parse(evt.data);
		var today = new Date();
		let month = today.getMonth() + 1; // 월
		let date = today.getDate(); // 날짜
		// 내가보낸 메세지
		if (data.boardWriter == currentSender) {
			appendText ="<div class='row msg_container base_sent'>"
					   +"<div class='col-md-10 col-xs-10'>"
					   +"<div class='messages msg_sent'>"
					   +"<p>"+data.message+"</p>"
					   +"<time datetime='2009-11-13T20:00'>"+today+"</time>"
					   +"</div></div>"
					   +"<div class='col-md-2 col-xs-2 avatar'>"
					   +"<img src='resources/images/upload/"+data.fileChangedName +"' class=' img-responsive '>"
					   +"</div>	</div>";
						$("#messageContainer").append(appendText);
						$('#messageContainer').scrollTop($('#messageContainer')[0].scrollHeight);
		} else { // 상대방이 보낸 메세지
			appendText = "<div class='row msg_container base_receive'>"
					   + "<div class='col-md-2 col-xs-2 avatar'>"
					   + "<img src='resources/images/upload/"+data.fileChangedName +"' class='img-responsive'>"
					   + "</div><div class='col-md-10 col-xs-10'><div class='messages msg_receive'>"
					   + "<p>"+data.message+"</p>"
					   + "<time datetime='2009-11-13T20:00'>"+today+"</time>"
					   + "</div></div></div>";
						$("#messageContainer").append(appendText);
						$('#messageContainer').scrollTop($('#messageContainer')[0].scrollHeight); // 메세지 전송시 스크롤 맨밑으로 개쩐다

		}
		//sock.close();
	
	}
	
	function onClose(evt) {
		$("#messageContainer").append("연결 끊김");
	}
	
	const today = new Date().toLocaleDateString();
	
	
	function fn_chat_toggle() {
		$(".panel-whole-body").slideToggle();
	}
	function getSession(){
		var session = "";
		$.ajax({
			url:"ajaxGetSession.do",
			dataType:"json",
			type:"POST",
			async: false,
			success:function(data){
				session = data;
			}
		});
		return session;
	}
	
	function viewPage(div) {
		$("#main").hide();
		$("#board").hide();
		$("#adminBoard").hide();
		$("#adminMember").hide();
		div.show();
	}
	
	function afterLoginSet(){
		var session = getSession();
		if(session.id != null){
			var result = ""
			result += "<ul class='nav navbar-nav navbar-right navbar-logout' id='loginInfo'>"					
			+"<li class='login-img'><img src='resources/images/upload/"+session.fileChangedName+ "' class='img-circle img-loginer' style='width: 35px; height: 35px;'></li>"
			+"<li><h5 class='h5-nav'><u>"+session.id+"</u><font style='color: #cacaca'> 님 안녕하세요.</font></h5></li>"
			+"<li><a href='#' data-toggle='modal' data-target='#memModiModal'><i class='fas fa-user'></i> 정보수정</a></li>"
			+"<li><a href='#' onclick='logout()'><i class='fas fa-sign-out-alt'></i> 로그아웃</a></li></ul>";
			$("#myNavbar").html(result);
			
			$("#modi_boardWriter").val(session.id);
			$("#modi_boardWriter").attr("readonly","readonly");
			$("#modi_profile").attr("src","resources/images/upload/"+session.fileChangedName);
			
			$("#Writer").html(session.id);
			$("#WriteDay").html(today);
			

		}else{
			var result = "";
			result += "<ul class='nav navbar-nav navbar-right navbar-login' id='loginForm'>"
			+"<li class='li-login'><input type='text' class='form-control nav-login' id='loginId' name='loginId' placeholder='로그인 아이디'></li>"
			+"<li class='li-login'><input type='password' class='form-control nav-login' id='loginPw' name='loginPw' placeholder='비밀번호'></li>"
			+"<li><a href='#' onclick='login()'><i class='fas fa-sign-in-alt'></i> 로그인</a></li>"
			+"<li><a href=''#' data-toggle='modal' data-target='#joinModal' ><i class='fas fa-user-plus'></i> 회원가입</a></li></ul>";
			$("#myNavbar").html(result);
		}
		
		
	}
	function login() {
		var vid = $("#loginId").val();
		var vpw = $("#loginPw").val();
		if (vid == "" || vpw == "") {
			alert("아이디와 비밀번호를 모두 입력해주세요.");
			return false;
		}
		$.ajax({
			url : "ajaxLogin.do",
			type : "POST",
			data : {id : vid,
					pw : vpw},
			dataType : "json",
			success : function(data) {
				var check = data.check;

				if (check == 0) { /* 아이디 X */
					var result = confirm("아이디가 존재하지 않습니다. 회원가입 하시겠습니까?");
					if (result)
						location.href = "register.do";
				} else if (check == -1) { /* 비밀번호 X  */
					alert("비밀번호가 틀렸습니다. 다시 입력해주세요.");
				} else { /* 로그인성공 */
					afterLoginSet();
					boardList(1);
				}
			}
		});
	}

	function logout() {
		$.ajax({
			url : "ajaxLogout.do",
			success : function(data) {
				afterLoginSet(data);
				viewPage($("#main"));
			}
		});
	}

	function count() {
		$.ajax({
			url : "ajaxCount.do",
			type: "POST",
			dataType : "json",
			success : function(data) {
				$("#bTotCnt").html(data.bTotCnt);
				$("#tbTotCnt").html(data.tbTotCnt);
				$("#wTotCnt").html(data.wTotCnt);
				$("#twTotCnt").html(data.twTotCnt);
			}
		});
	}
	// init 1 = boardLsit 초기화 ,
	//		2 = boardList 더보기 ,
	
	function boardList(init) {
		var currentPage	= "";
		var searchText	= $("#searchText").val();
		var searchTag	= $("#searchTag").val();
		
		if	(init==1) $("#currentPage").val(1);
		currentPage = $("#currentPage").val();
		
		$.ajax({
					url : "ajaxBoardList.do",
					type : "POST",
					data : {currentPage : currentPage,
							searchText	: searchText ,
							searchTag	: searchTag },
					dataType : "json",
					success : function(data) {
						var result = "";
						$.each(	data,function(index, item) {
							result += "<tr><td>"+ item.boardIdx+ "</td>"
									+ "<td>"+ item.boardWriter+ "</td>"
									+ "<td><i class='fas fa-lock'></i></td>"
									+ "<td><a href='javascript:void(0);' data-toggle='modal' data-target='#modiModal' onclick='detail("+item.boardIdx+")'>"
									+ item.boardTitle+ "</a></td>" 
									+ "<td>"+ item.boardWriteDate + "</td></tr>";
						});
						count();
						(init==1) ? $("#boardList").html(result) : $("#boardList").append(result) ;
						viewPage($("#board"));
					}
				});
	}
	function down(fileIdx) {
		$.ajax({
			url:"download.do",
			data:{fileIdx:fileIdx},
			dataType:"json",
			type:"post",
			success:function(){
				alert("download~");
			}
		});
	}
	
	function detail(vboardIdx){
		$.ajax({
			url:"ajaxDetail.do",
			type:"POST",
			data:{boardIdx : vboardIdx},
			dataType:"json",
			success:function(data){
				var result = "";
				if(data.next==null){
					$("#nextTitle").html("마지막 게시글입니다.");
				}else{
					$("#nextTitle").html(data.next.boardTitle);
					$("#nextWriteDate").text(data.next.boardWriteDate);
				}
				if(data.pre==null){
					$("#preTitle").html("첫번째 게시글입니다.");
				}else{
					$("#preTitle").html(data.pre.boardTitle);
					$("#preWriteDate").text(data.pre.boardWriteDate);
				}
				result +="<tbody><tr><th>제목</th>"
						+"<input type='hidden' id='boardIdx' value='"+data.current.boardIdx+"'>"
						+"<td>"+data.current.boardContents+"</td>"
						+"<th>조회수</th><td>"+data.current.boardViewCount+"</td></tr>"
						+"<tr><th>작성자</th><td>"+data.current.boardWriter+"</td>"
						+"<th>작성일자</th>	<td>"+data.current.boardWriteDate+"</td></tr></tbody>"
						+"<tr><td colspan='4'><div class='detail-content'>"+data.current.boardContents+"</div></td></tr>";
						if(data.files != null){
							for(var file of data.files){
								result += "<tr><th>첨부파일</th><td colspan='3'>"
										+ "<a href='download.do?fileIdx="+file.fileIdx+"'>"+file.fileOriginalName+"</a></td></tr></tbody>";
							}
						}
				$("#detailContents").html(result);		
			}
		});
	}
	
	function boardModifyInit(){
		var vboardIdx= $("#boardIdx").val();
		
		$.ajax({
			url:"ajaxDetail.do",
			type:"POST",
			data:{boardIdx : vboardIdx},
			dataType:"json",
			success:function(data){
				$("#bModiContents").html(data.current.boardContents);
				$("#bModiTitle").val(data.current.boardTitle);
				$("#bModiWriter").html(data.current.boardWriter);
				$("#bModiWriteDay").html(data.current.boardWriteDate);
				$("#detailCancle").click();
				$("#boardModifyForm").append(boardIdx);
			}
		});
	}
	
	function boardModify() {
		var formData = new FormData($("#boardModifyForm")[0]);
		var vboardIdx= $("#boardIdx").val();
		
		formData.append("boardIdx",vboardIdx);
		$.ajax({
			url:"ajaxBoardModify.do",
			data:formData,
			processData : false,
			contentType : false,
			dataType:"json",
			type:"post",
			success:function(){
				alert("수정성공~");	
			}
		});	
	}
	
	function boardDel(){
		var vboardIdx= $("#boardIdx").val();
		
		$.ajax({
			url:"ajaxBoardDelete.do",
			data:{boardIdx:vboardIdx},
			dataType:"json",
			type:"post",
			success:function(){
				alert("삭제성공~");	
			}
		});	
	}
	/*  더보기시 게시판 확장 */
	function nextPage() {
		var NextPage = Number($("#currentPage").val()) + 1;
		$("#currentPage").val(NextPage);
		boardList(2);
/* 		window.scrollTo(0, document.body.scrollHeight); */
	}

	function readURL(file,profile,formName) {
		/* 확장자 제한  */
		var ext = $(file).val().split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'png', 'jpg' ]) == -1) {
			alert("지정된 파일만 올려주세요 ( png jpg)")
			$(file).val("");
			return false;
		}
		/*  */
		var formData = new FormData($("#"+formName)[0]);
		alert(formData.get("file"));
		var fileReader = new FileReader(file);
		fileReader.readAsDataURL(file.files[0]);
		fileReader.onload = function(){
			$("#"+profile).attr('src', fileReader.result);
		}
		$.ajax({
			url : 'upload.do',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			dataType : 'json',
			enctype : 'multipart/form-data',
			success : function(data) {
				var fileSrc = "resources\\images\\upload\\"
						+ data[0].fileChangedName;
				$("#imgURL").val(fileSrc);
				alert("success fileIdx -> " + data[0].fileIdx);
				$("#fileIdx").val(data[0].fileIdx);
				/* $("#profile").attr('src', fileSrc); */
			}
		});
	}

	function checkid() {
		var id = $("#boardWriter").val();
		var result = null;
		$.ajax({
			url : "checkId.do",
			type : 'POST',
			async : false,
			data : {
				boardWriter : id
			},
			dataType : 'json',
			success : function(data) {
				if (data.check == "false") {
					result = "false";
				} else
					result = "true";
			}
		});
		return result;
	}

	function checkEmpty(where) {
		var result = "noEmpty";
		$("#"+where).find('input').each(function() {
			if ($(this).val() == "") {
				alert("모든항목을 빈칸없이 작성해 주시기 바랍니다.");
				result = "Empty";
				return false;
			}
		});
		return result;
	}
	
	function checkInfo() {
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
		// 아이디 중복검사
		var checkId = checkid();
		if ($("#file").val() == "") {
			alert("프로필 사진을 등록해주세요.");
			return false;
		}
		// 공백 검사
		if (checkEmpty("joinModal") == "noEmpty") {
			if (checkId == "false") {
				alert("중복된 아이디입니다.");
				return false;
			}

			if (!(phoneJ.test($("#phone").val()))) {
				alert("전화번호 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}
			if (!(mailJ.test($("#mail").val()))) {
				alert("이메일 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}
			if ($("#mail").val() != $("#mailConfirm").val()) {
				alert("작성된 이메일이 다릅니다. 이메일을 다시 확인하여 주시기 바랍니다.");
				return false;
			}

			var result = confirm("작성한 내용으로 가입이 진행됩니다. 계속하시겠습니까?");
			if (result) {
				var form = $("#registerForm").serialize();
				alert(form);
				$.ajax({
					url : "ajaxRegister.do",
					type : 'POST',
					data : form,
					dataType : 'json',
					success : function(data) {
						afterLoginSet(data);
						boardList(1);
						$("#joinCancle").click();
						
					}
				});
			}
		}
	}

	
	function WriterModify(){
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;
		if(checkEmpty("modifyForm")=="noEmpty"){
			if($("#modi_boardWriterPw").val() != $("#modi_boardWriterPwConfirm").val()){
				alert("암호가 서로 다릅니다. 암호를 다시 확인하여 주시기 바랍니다.");
				return false;
			}
			if (!(phoneJ.test($("#modi_boardWriterPhone").val()))) {
				alert("전화번호 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}
			if (!(mailJ.test($("#modi_boardWriterEmail").val()))) {
				alert("이메일 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}

			result=confirm("작성한 내용으로 수정합니다. 계속 하시겠습니까?");
			if(result){
				var form = $("#modifyForm").serialize();
				$.ajax({
					url:"ajaxWriterModify.do",
					data:form,
					type:"POST",
					success:function(data){
						viewPage($("#main"));
						$("#modCancle").click();
					}
				});
			}else
				$("#modi_boardWriter").focus();
		}
	}
	
	function writeBoard() {
		var session = getSession();
		var formData = new FormData($("#writeForm")[0]);
		formData.append("boardWriter",session.id);
		
		$.ajax({
			url:"ajaxWriterBoard.do",
			data:formData,
			type:"post",
			processData : false,
			contentType : false,
			dataType:"json",
			success:function(){
				alert("게시글 작성 성공~");
			}
		});
		
	}
</script>
</head>
<body>
	<input type="hidden" id="currentPage" value="1"/>
	<input type="hidden" id="imgURL"/>
	<nav class="navbar navbar-inverse navbar-fixed-top" id="header">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ITKey Education</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right navbar-login" id="loginForm">
						<li class="li-login"><input type="text" class="form-control nav-login" id="loginId" name="loginId" placeholder="로그인 아이디"></li>
						<li class="li-login"><input type="password" class="form-control nav-login" id="loginPw" name="loginPw" placeholder="비밀번호"></li>
						<li><a href="#" onclick="login()"><i class="fas fa-sign-in-alt"></i> 로그인</a></li>
						<li><a href="#" data-toggle="modal" data-target="#joinModal" ><i class="fas fa-user-plus"></i> 회원가입</a></li>
					</ul>
			</div>
		</div>
	</nav>
	<div class="limiter iframe-before-login" id="main">
		<div class="container-login100">
			<div class="wrap-login100 warp-iframe">
				<div class="login100-form">
					<div class="row">
						<div class="col-sm-12 col-sm-iframe">
							<iframe src="http://itkey.co.kr" width="100%" height="750px"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="limiter table-after-login-user" id="board">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title" >총 게시글 수</h5>
								<h1 class="overview-content"id="bTotCnt">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content"id="wTotCnt">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content"id="tbTotCnt">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content"id="twTotCnt">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default" data-toggle="modal" data-target="#writeModal">
								<i class="fas fa-plus"></i> 새글 추가
							</button>

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
							<button type="button" class="btn btn-default btn-full" onclick="boardList(1)">
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
									</tr>
								</thead>
								<tbody id="boardList">
								
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li><a href="#" onclick="nextPage()">더보기</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="limiter table-after-login-admin" id="adminBoard">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content" id="bTotCnt">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content" id="wTotCnt">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content" id="tbTotCnt">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content" id="twTotCnt">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default">선택삭제</button>
							<button type="button" class="btn btn-default">회원관리</button>
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="">
								<option>전체</option>
								<option>작성자</option>
								<option>글내용</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input type="checkbox" /></th>
										<th style="width: 7%;">순번</th>
										<th style="width: 9%;">작성자</th>
										<th style="width: 5%;">공개</th>
										<th>제목</th>
										<th style="width: 10%;">작성일자</th>
										<th style="width: 10%;">삭제</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>1</td>
										<td>테스트</td>
										<td>
											<i class="fas fa-lock-open"></i>
										</td>
										<td>하이하이</td>
										<td>2019-10-13</td>
										<td>
											<button class="btn btn-default btn-full">삭제</button>
										</td>
									</tr>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>1</td>
										<td>테스트</td>
										<td>
											<i class="fas fa-lock"></i>
										</td>
										<td>하이하이</td>
										<td>2019-10-13</td>
										<td>
											<button class="btn btn-default btn-full">삭제</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li><a href="#">이전</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="limiter table-after-login-admin" id="adminMember">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 class="overview-content">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 class="overview-content">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 class="overview-content">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 class="overview-content">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<button type="button" class="btn btn-default">선택탈퇴</button>
							<button type="button" class="btn btn-default">게시판관리</button>
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="">
								<option>전체</option>
								<option>아이디</option>
								<option>이름</option>
							</select>
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="" placeholder="문자열을 입력해주세요.">
						</div>
						<div class="col-sm-1 text-right">
							<button type="button" class="btn btn-default btn-full">
								<i class="fas fa-search"></i> 검색
							</button>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width: 5%;"><input type="checkbox" /></th>

										<th style="width: 5%;">아이디</th>
										<th style="width: 5%;">이름</th>
										<th style="width: 10%;">핸드폰</th>
										<th style="width: 10%;">이메일</th>
										<th style="width: 5%;">탈퇴</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>TEST</td>
										<td>테스트</td>
										<td>010-1234-1234</td>
										<td>test@test.com</td>
										<td>탈퇴완료</td>
									</tr>
									<tr>
										<td>
											<input type="checkbox" />
										</td>
										<td>TEST</td>
										<td>테스트</td>
										<td>010-1234-1234</td>
										<td>test@test.com</td>
										<td>
											<button class="btn btn-default btn-full">탈퇴</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination">
								<li><a href="#">이전</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row chat-window col-xs-5 col-md-3" id="chat_window_1" style="margin-left: 10px;">
			<div class="col-xs-12 col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading top-bar">
						<div class="col-md-8 col-xs-8">
							<h3 class="panel-title">
								<i class="fas fa-comments"></i> ITKey 전체 채팅
							</h3>
						</div>
						<div class="col-md-4 col-xs-4" style="text-align: right;">
							<a href="javascript:void(0);" onclick="fn_chat_toggle();"><i class="fas fa-window-minimize" style="color: white"></i></a>
						</div>
					</div>
				</div>
				<div class="panel-whole-body" style="display: none;">
					<div class="panel-body msg_container_base" id="messageContainer">
						<div class="row msg_container base_sent">
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_sent">
									<p>내가 보낸 내용입니다.</p>
									<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
								</div>
							</div>
							<div class="col-md-2 col-xs-2 avatar">
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>
						</div>
						<div class="row msg_container base_receive">
							<div class="col-md-2 col-xs-2 avatar">
								<img src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg" class=" img-responsive ">
							</div>
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_receive">
									<p>다른사람이 보낸 내용입니다.</p>
									<time datetime="2009-11-13T20:00">2019-06-24 13:22</time>
								</div>
							</div>
						</div>

					</div>
					<div class="panel-footer">
						<div class="input-group">
							<input id="btn-input" type="text" class="form-control input-sm chat_input" placeholder="Write your message here..." />
							<span class="input-group-btn">
								<button class="btn btn-default btn-sm" id="btn-chat">보내기</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	
	<!--Join Modal -->
	<div class="modal fade" id="joinModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<img src="images/noImage.png" id="profile" class="img-circle" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<form enctype="multipart/form-data" method="post" id="uploadForm">
									<span class="fileUpload btn login100-form-btn login-file-btn"> <span class="upl" id="upload">업로드</span> 
									<input type="file" class="upload up" id="joinFile" name="file" onchange="readURL(this,'profile','uploadForm');" />
								</span>
								</form>
								<!-- btn-orange -->
							</div>
							<!-- btn -->
						</div>
						<!-- group -->
					</div>
					<!-- form-group -->
					<form id="registerForm">
					<div class="row">
					<input type="hidden" id="fileIdx" name="fileIdx">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriter" id="boardWriter" placeholder="ID">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter password">
								<input class="input100" type="password" name="boardWriterPw" id="pass" placeholder="Password">
								<span class="focus-input100" data-placeholder="&#xf191;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterName" id="boardWriterName" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterPhone" id="phone" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="text" name="boardWriterEmail" id="mail" placeholder="이메일을 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf15a;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="text" name="mailConfirm" id="mailConfirm" placeholder="이메일을 다시한번 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf159;"></span>
					</div>
					</form>

					<div class="container-login100-form-btn">
						<a href="#" class="login100-form-btn" onclick="checkInfo()">가입</a> <a href="" data-dismiss="modal" class="login100-form-btn" id="joinCancle">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//Join Modal -->

	<!--Memberd Modal -->
	<div class="modal fade" id="memModiModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">회원가입</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<img src="images/noImage.png" class="img-circle" id="modi_profile" style="width: 140px; height: 140px; display: block; margin-left: auto; margin-right: auto;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
							<form enctype="multipart/form-data" method="post" id="mUploadForm">
								<span class="fileUpload btn login100-form-btn login-file-btn"> <span class="upl" id="upload">업로드</span>
								 <input type="file" class="upload up" id="modiFile" name="file" onchange="readURL(this,'modi_profile','mUploadForm');" />
								</span>
							</form>
								<!-- btn-orange -->
							</div>
							<!-- btn -->
						</div>
						<!-- group -->
					</div>
					<!-- form-group -->
					<form id = "modifyForm">
					<div class="row">
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriter" id="modi_boardWriter" placeholder="ID는 수정불가">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterName" id="modi_boardWriterName"  placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterPhone" id="modi_boardWriterPhone" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="password" name="boardWriterEmail" id="modi_boardWriterEmail" placeholder="이메일.">
								<span class="focus-input100" data-placeholder="&#xf159;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="boardWriterPw" id="modi_boardWriterPw" placeholder="암호를 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="boardWriterPwConfirm" id="modi_boardWriterPwConfirm" placeholder="암호 확인.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					</form>
					<div class="container-login100-form-btn">
						<a href="#" class="login100-form-btn" onclick="WriterModify()">수정</a> <a href="#" class="login100-form-btn">탈퇴</a> <a href="#" data-dismiss="modal" class="login100-form-btn" id="modCancle">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//MemberModify Modal -->

	<!--Write Modal -->
	<div class="modal fade" id="writeModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 추가/수정
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<form enctype="multipart/form-data" method="post" id="writeForm">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>공개여부</th>
										<td colspan="3">
											<input type="radio" name="boardPublicFl" id="privacy" value="Y" checked="checked">공개
											<input type="radio" name="boardPublicFl" id="privacy" value="N">비공개
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td colspan="3" class="input-td">
											<input type="text" class="form-control input-sm" name="boardTitle" placeholder="제목을 입력해 주세요.">
										</td>
									</tr>
									<tr >
										<th>작성자</th>
										<td id="Writer">이강민</td>
										<th>작성일자</th>
										<td id="WriteDay">2019-06-17</td>
									</tr>
									<tr>
										<td class="input-td" colspan="4">
											<textarea class="form-control" style="resize: none;" rows="15" id="comment" name="boardContents" placeholder="내용을 입력해 주세요."></textarea>
										</td>
									</tr>
									
									<tr>
										<th>첨부파일</th>
										<td colspan="3">
											<input type="file" id="input-file-now" name="file" class="file-upload" multiple="multiple"/>
										</td>
									</tr>
								</tbody>
							</table>
							</form>

						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="writeBoard()">저장</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--//Write Modal -->
	
	<!--boardModify Modal -->
	<div class="modal fade" id="boardModifyModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 수정
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<form enctype="multipart/form-data" method="post" id="boardModifyForm">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>공개여부</th>
										<td colspan="3">
											<input type="radio" name="boardPublicFl" id="modiPrivacy" value="Y" checked="checked">공개
											<input type="radio" name="boardPublicFl" id="modiPrivacy" value="N">비공개
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td colspan="3" class="input-td">
											<input type="text" class="form-control input-sm" id="bModiTitle" name="boardTitle" placeholder="제목을 입력해 주세요." readonly="readonly">
										</td>
									</tr>
									<tr >
										<th>작성자</th>
										<td id="bModiWriter">이강민</td>
										<th>작성일자</th>
										<td id="bModiWriteDay">2019-06-17</td>
									</tr>
									<tr>
										<td class="input-td" colspan="4">
											<textarea class="form-control" style="resize: none;" id="bModiContentns" rows="15" id="comment" name="boardContents" placeholder="내용을 입력해 주세요."></textarea>
										</td>
									</tr>
									
									<tr>
										<th>첨부파일</th>
										<td colspan="3">
											<input type="file" id="input-file-now" name="file" class="file-upload" multiple="multiple"/>
										</td>
									</tr>
								</tbody>
							</table>
							</form>

						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="boardModify()">저장</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!--//boardModify Modal -->
	<!--modify Modal -->
	<div class="modal fade" id="modiModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세 정보
					</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-up"></i> 이전글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<a><button class="btn btn-link" id="preTitle">이전 글 제목입니다.</button></a>
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm" id="preWriteDate">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered" id="detailContents">
								<tbody>
									<tr>
										<th>제목</th>
										<td>제목입니다.</td>
										<th>조회수</th>
										<td>1</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>홍길동</td>
										<th>작성일자</th>
										<td>2021년01월01일</td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="detail-content"></div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2 col-header">
							<div class="well well-sm">
								<i class="fas fa-chevron-down"></i> 다음글
							</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm">
								<button class="btn btn-link" id="nextTitle">다음 글 제목입니다.</button>
								</a>
							</div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm" id="nextWriteDate">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">
							<button data-toggle="modal" data-target="#boardModifyModal" class="btn btn-default btn-full" onclick="boardModifyInit()">수정</button>
						</div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="boardDel()">삭제</button>
						</div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" data-dismiss="modal" id="detailCancle">닫기</button>
						</div>
					</div>
				</div>
			</div>
			<!--//modify Modal -->
</body>
</html>