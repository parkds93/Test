<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
	<script src="resources/vendor/animsition/js/animsition.min.js"></script>
	<script src="resources/vendor/bootstrap/js/popper.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/vendor/select2/select2.min.js"></script>
	<script src="resources/vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/vendor/daterangepicker/daterangepicker.js"></script>
	<script src="resources/vendor/countdowntime/countdowntime.js"></script>
	<script src="resources/js/main.js"></script>
	
	<script src="resources/js/ajax.js"></script>
	
	<script>
		function fn_chat_toggle() {
			$(".panel-whole-body").slideToggle();
		}
	</script>
	    
	<style>
		::placeholder {
			font-family : inherit;
		}
	</style>
</head>

<body>
	<form>
		<input type="hidden" id="loginId" name="loginId" value=""/>
		<input type="hidden" id="searching" name="searching" value="0"/>
		<input type="hidden" id="selPage" name="selPage" value="1"/>
		<input type="hidden" id="selCnt" name="selCnt" value="15"/>
		<input type="hidden" id="pageBlock" name="pageBlock" value="10"/>
		<input type="hidden" id="listUrl" value="/sam/list.do"/>
		<input type="hidden" id="selUrl" value="/sam/select.do"/> 
		<input type="hidden" id="sessionUrl" value="/sam/session.do"/>     
		<input type="hidden" id="checkIdUrl" value="/sam/idCheck.do"/>     
		<input type="hidden" id="loginCheckURL" value="/sam/loginCheck.do" />
		<input type="hidden" id="logoutURL" value="/sam/logout.do" />
		<input type="hidden" id="countURL" value="/sam/count.do" />
		<input type="hidden" id="cntListURL" value="/sam/listCnt.do" />
		<input type="hidden" id="pageURL" value="/sam/page.do" />
		<input type="hidden" id="downURL" value="/sam/download.do" />
		<input type="hidden" id="delURL" value="/sam/delete.do" />
		<input type="hidden" id="searchingURL" name="searching" value="/sam/searching.do"/>
	</form>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ITKey Education</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar"></div>
		</div>
	</nav>

	<div class="limiter iframe-before-login">
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
	<div class="limiter table-after-login">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="row panel-row">
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 게시글 수</h5>
								<h1 id="countBd" class="overview-content">242</h1>
								<i class="far fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">총 가입자 수</h5>
								<h1 id="countJoin" class="overview-content">242</h1>
								<i class="fas fa-users"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 게시글 수</h5>
								<h1 id="tdCountBd" class="overview-content">242</h1>
								<i class="fas fa-file-alt"></i>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="overview-div">
								<h5 class="overview-title">오늘 가입자 수</h5>
								<h1 id="tdCountJoin" class="overview-content">242</h1>
								<i class="fas fa-user-circle"></i>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4"><button type="button" id="writeBtn" class="btn btn-default" data-toggle="modal" data-target="#writeModal"><i class="fas fa-plus"></i> 새글 추가</button></div>
						<div class="col-sm-2"></div>
						<div class="col-sm-2">
							<select class="form-control" id="searchF" name="searchF">
								<option value="A">전체</option>
								<option value="T">글제목</option>
								<option value="C">글내용</option>
							</select>
						</div>
						<div class="col-sm-3"><input type="text" class="form-control" id="searchT" name="searchT" placeholder="문자열을 입력해주세요."></div>
						<div class="col-sm-1 text-right"><button type="button" id="searchBtn" class="btn btn-default btn-full"><i class="fas fa-search"></i> 검색</button></div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-hover">
								<thead>
									<tr>
										<th style="width : 7%;">순번</th>
										<th style="width : 9%;">작성자</th>
										<th style="width : 5%;">공개</th>
										<th>제목</th>
										<th style="width : 10%;">작성일자</th>
										<th style="width : 10%;">조회수</th>
									</tr>
								</thead>
								<tbody id="bdList">
									<tr>
										<td style="text-align: center">1</td>
										<td style="text-align: center">테스트</td>
										<td style="text-align: center"><i class="fas fa-lock"></i></td>
										<td><a href="javascript:void(0);" data-toggle="modal" data-target="#modiModal">하이하이</a></td>
										<td style="text-align: center">2019-10-13</td>
										<td style="text-align: center"> 1 </td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 text-center">
							<ul class="pagination"></ul>
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
					<form id="joinForm" action="/sam/join.do" method="post" >
						<div class="row">
							<div class="col-sm-12">
								<img id="upimg" src="resources/images/noImage.png" class="img-circle" style="width: 140px; height: 140px; display : block; margin-left : auto; margin-right: auto;">
							</div>
						</div>
						<div class="form-group" style="margin-bottom : 50px; margin-top : 10px;">
							<div class="input-group">
								<input type="text" class="form-control" readonly>
								<div class="input-group-btn">
									<span class="fileUpload btn login100-form-btn login-file-btn">
										<span class="upl" id="upload">업로드</span>
										<input type="file" class="upload up" name="imgfile" id="up" accept=".jpg, .png"/>
									</span><!-- btn-orange -->
								</div><!-- btn -->
							</div><!-- group -->
						</div><!-- form-group -->

						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="joinId" class="input100" type="text" name="userid" placeholder="ID">
									<span class="focus-input100" data-placeholder="&#xf207;"></span>
								</div>
								<span id="checkId" style="display: none; margin-top: -26px;"> 존재하는 아이디 입니다 </span>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter password">
									<input id="joinPwd" class="input100" type="password" name="pass" placeholder="Password">
									<span class="focus-input100" data-placeholder="&#xf191;"></span>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="joinNm" class="input100" type="text" name="username" placeholder="이름 입력란">
									<span class="focus-input100" data-placeholder="&#xf205;"></span>
								</div>
							</div>
							<div class="col-sm-6">
								<div class="wrap-input100 validate-input" data-validate="Enter username">
									<input id="joinPhn" class="input100" type="text" name="phone" placeholder="전화번호 입력란">
									<span class="focus-input100" data-placeholder="&#xf2be;"></span>
								</div>
							</div>
						</div>

						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input id="joinEmail1" class="input100" type="text" name="email" placeholder="이메일을 입력해주세요.">
							<span class="focus-input100" data-placeholder="&#xf15a;"></span>
						</div>
						<span id="checkEmail" style="display: none; margin-top: -26px;"> 형식에 맞지 않는 이메일입니다. </span>

						<div class="wrap-input100 validate-input" data-validate="Enter username">
							<input id="joinEmail2" class="input100" type="text" name="username" placeholder="이메일을 다시한번 입력해주세요.">
							<span class="focus-input100" data-placeholder="&#xf159;"></span>
						</div>

						<div class="container-login100-form-btn">
							<div id="joinBtn" class="login100-form-btn animsition-link">가입</div>
							<a id="jCancleBtn" href="" data-dismiss="modal" class="login100-form-btn animsition-link">취소</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--//Join Modal -->

	<!--Write Modal -->
	<div class="modal fade" id="writeModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 추가/수정</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12">
							<form id="writeForm" method="post" action="/sam/write.do">
								<input type="hidden" name="boardIdx" id="modiIdx" value="0"/>
								<input type="hidden" id="fileIdx" name="fileIdx" value="0"/>
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th>제목</th>
											<td colspan="5" class="input-td"><input type="text" name="boardTitle" id="insertTitle" class="form-control input-sm" placeholder="제목을 입력해 주세요."></td>
										</tr>
										<tr>
											<th>작성자</th>
											<td id="wName"></td>
											<th>작성일자</th>
											<td id="today">2019-06-17</td>
											<th>공개여부</th>
											<td>
												<input type="radio" name="boardPublicFl" value="N"/> 공개
												&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" name="boardPublicFl" value="Y"/> 비공개
											</td>
										</tr>
										<tr>
											<td class="input-td" colspan="6">
												<textarea class="form-control" name="boardContents" id="insertCont" style="resize: none;" rows="15" id="comment" placeholder="내용을 입력해 주세요."></textarea>
											</td>
										</tr>
										<tr>
											<th>첨부파일</th>
											<td colspan="5">
												<span id="fileInfo"></span>
												<input type="file" name="imgfile" id="input-file-now" class="file-upload" accept=".jpg, .png"/>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2"><button id="writeSaveBtn" class="btn btn-default btn-full">저장</button></div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2"><button id="writeCloseBtn" class="btn btn-default btn-full" data-dismiss="modal">닫기</button></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--//Write Modal -->

	<!--modify Modal -->
	<div class="modal fade" id="modiModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><i class="fa fa-paper-plane" style="color: #b224ef;"></i> 글 상세 정보</h4>
				</div>
				<div class="modal-body">
					<div id="contPre" class="row" style="display: none;">
						<div class="col-sm-2 col-header">
							<div class="well well-sm"><i class="fas fa-chevron-up"></i> 이전글</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm"><button class="btn btn-link" id="contPreBtn">이전 글 제목입니다.</button></a></div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm" id="contPreDate">2019-10-13</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<table class="table table-bordered">
								<tbody>
									<tr>
										<th>제목</th>
										<td id="contTitle"></td>
										<th>조회수</th>
										<td id="contView">제목입니다.</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td id="contName">제목입니다.</td>
										<th>작성일자</th>
										<td id="contDate">제목입니다.</td>
									</tr>
									<tr>
										<td colspan="4">
											<div id="contCont" class="detail-content"></div>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td id="contFile" colspan="3"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

					<div id="contBef" class="row" style="display: none;">
						<div class="col-sm-2 col-header">
							<div class="well well-sm"><i class="fas fa-chevron-down"></i> 다음글</div>
						</div>
						<div class="col-sm-8 col-mid">
							<div class="well well-sm"><button class="btn btn-link" id="contBefBtn">다음 글 제목입니다.</button></a></div>
						</div>
						<div class="col-sm-2 col-footer">
							<div class="well well-sm" id="contBefDate">2019-10-13</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-2" id="modiDiv"></div>
						<div class="col-sm-2" id="delDiv"></div>
						<div class="col-sm-6"></div>
						<div class="col-sm-2"><button id="modiCloseBtn" class="btn btn-default btn-full" data-dismiss="modal">닫기</button></div>
					</div>
				</div>
			</div>
<!--//modify Modal -->
</body>
</html>
