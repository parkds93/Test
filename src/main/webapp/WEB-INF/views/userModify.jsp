<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ITKey 정보수정</title>
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
	
	function checkInfo(){
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 휴대폰 번호 정규식
		var phoneJ =  /^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})$/;

		if($("#up").val()==""){
			alert("프로필 사진을 등록해주세요.");
			return false;
		}
		// 공백 검사
		if(checkEmpty()=="noEmpty")
		{
			if(!(phoneJ.test($("#phone").val()))){
				alert("전화번호 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}
			if(!(mailJ.test($("#mail").val()))){
				alert("이메일 양식에 맞춰 작성해주시기 바랍니다.");
				return false;
			}
			if($("#pass").val() != $("#passConfrim").val()){
				alert("암호가 서로 다릅니다. 암호를 다시 확인하여 주시기 바랍니다.");
				return false;
			}
			
			var result = confirm("작성한 내용으로 수정이 진행됩니다. 계속하시겠습니까?");
			if(result){
				document.getElementById('updateFrm').submit();
			}
		}
	}
	
	
	function checkEmpty(){
		var result = "noEmpty";
		$('input').each(function(){	
			if($(this).val()==""){
				alert("모든항목을 빈칸없이 작성해 주시기 바랍니다.");
				result = "Empty";
				return false;
			}
		});
		return result;
	}
	
	// 파일 확장자 제한
	function readURL(file){
		var ext = $(file).val().split('.').pop().toLowerCase();
	  	  if($.inArray(ext, ['png','jpg']) == -1) {
	  	  	alert("지정된 파일만 올려주세요 ( png jpg)")
	  	  	$(file).val("");
	  	  	return false;
	  	}
	  	var formData = new FormData($("#fileForm")[0]);
	  	
	  	alert($("#fileForm")[0]);
 	    
	  	$.ajax({
	  		url:'upload.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
			dataType: 'json',
            enctype: 'multipart/form-data',
            success: function(data){
            	var fileSrc = "resources\\images\\upload\\"+data[0].fileChangedName;
            	alert(fileSrc);
            	alert("success fileIdx -> "+data[0].fileIdx);
            	$("#fileIdx").val(data[0].fileIdx);
            	
            	$("#profile").attr('src',fileSrc);
	        }
	    });      
	}
	
	function deleteUser(){
		

		var result = confirm("탈퇴 버튼을 누르셨습니다. 계속하시곘습니까?");
		if(result){
			location.href="main.do?boardWriter=${writer.boardWriter}";
		}
	}
</script>
</head>

<body>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form validate-form">
					<span class="login100-form-title p-b-27 p-t-15">정보수정</span>
					<div class="row text-center">
						<div class="col-sm-12">
							<img src="resources/images/noImage.png" id="profile" class="img-circle" style="width: 180px; height: 180px; border-radius: 100%;">
						</div>
					</div>
					<div class="form-group" style="margin-bottom: 50px; margin-top: 10px;">
						<div class="input-group">
							<input type="text" class="form-control" readonly>
							<div class="input-group-btn">
								<form method="post" enctype="multipart/form-data" id="fileForm" >
								<span class="fileUpload btn login100-form-btn"> <span class="upl" id="upload">업로드</span> <input type="file" class="upload up" id="file" name="file" onchange="readURL(this);" />
								</span>
								</form>
								<!-- btn-orange -->
							</div>
							<!-- btn -->
						</div>
						<!-- group -->
					</div>
					<!-- form-group -->
					<form action="userModify.do" method="post" id="updateFrm">
					<input type="hidden" id="fileIdx" name="fileIdx">
					<div class="row">
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriter" value="${writer.boardWriter }" readonly="readonly">
								<span class="focus-input100" data-placeholder="&#xf207;"></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterName" placeholder="이름 입력란">
								<span class="focus-input100" data-placeholder="&#xf205;"></span>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterPhone" id="phone" placeholder="전화번호 입력란">
								<span class="focus-input100" data-placeholder="&#xf2be;"></span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="wrap-input100 validate-input" data-validate="Enter username">
								<input class="input100" type="text" name="boardWriterEmail" id="mail" placeholder="이메일.">
								<span class="focus-input100" data-placeholder="&#xf159;"></span>
							</div>
						</div>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="boardWriterPw" id="pass" placeholder="암호를 입력해주세요.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter username">
						<input class="input100" type="password" name="passConfirm" id="passConfrim" placeholder="암호 확인.">
						<span class="focus-input100" data-placeholder="&#xf191;"></span>
					</div>
					</form>
					<div class="container-login100-form-btn">
						<a href="#" class="login100-form-btn" onclick="checkInfo()">수정</a> <a href="#" class="login100-form-btn" onclick="deleteUser()">탈퇴</a> <a href="" class="login100-form-btn">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>
</html>