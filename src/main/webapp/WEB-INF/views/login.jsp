<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ITKey 로그인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="resources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">

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
	function checkId(){
		var vid = document.getElementById("username").value;
		var vpw = document.getElementById("pass").value;
		var rememberMe = null;
		if($('#ckb1').is(':checked')){
		 	rememberMe = document.getElementById("ckb1").value;
		}
		alert(rememberMe);
		if(!vid || !vpw){
			alert("아이디와 비밀번호를 모두 입력해주세요.");
		}
		
		$.ajax({
			url:"login.do",
			type:'POST',
			data:{id : vid, 
				  pw : vpw,
				  rememberId : rememberMe},
			dataType:'json',
			success:function(data){
				var check = data.check;
				alert("check"+check);
				if(check == 0){
					var result = confirm("아이디가 존재하지 않습니다. 회원가입 하시겠습니까?");
					if(result){
						location.href="register.do";
					}
				}else if(check == -1){
					alert("비밀번호가 틀렸습니다. 다시 입력해주세요.");
				}else
					location.href="main.do";
			}
		});
	}
	
	window.onload = function() {
		  if(${memberId != null }){
			  document.getElementById("username").value="${memberId}";
 			  $( '#ckb1' ).attr( 'checked', 'checked' );
		  }	
	};
</script>
</head>

<body>
	<form action="login.do" method="post" id=frm>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<div class="text-center" style="width: 100%">
						<img src="resources/images/logo.png" width="50%">
					</div>

					<span class="login100-form-title p-b-34 p-t-27"> ITKey Edu<br>Project Login
					</span>

					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="text" id="username" name="username" placeholder="ID">
						<span class="focus-input100" data-placeholder="&#xf207;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" id="pass" name="pass" placeholder="비밀번호">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>

					<div class="contact100-form-checkbox">
						<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember-me">
						<label class="label-checkbox100" for="ckb1"> ID 저장 </label>
					</div>

					<div class="container-login100-form-btn">
						<a href="#" class="login100-form-btn" onclick="checkId();">로그인</a> <a href="register.do" class="login100-form-btn">회원가입</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
	<div id="dropDownSelect1"></div>
</body>

</html>