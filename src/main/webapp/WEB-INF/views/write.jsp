<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ITKey 글상세</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png"
	href="resources/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/fonts/iconic/css/material-design-iconic-font.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="resources/css/util.css">
<link rel="stylesheet" type="text/css" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="resources/css/table.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
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
	function list() {
		var result = confirm("작성된 내용이 모두 사라집니다. 계속 하시겠습니까?");
		if (result) {
			location.href = "main.do";
		}
	}
	function save() {
		if ($("#title").val() == '') {
			alert("제목을 입력해주세요.");
			return false;
		}
		if ($("#contents").val() == '') {
			alert("내용을 입력해주세요.");
			return false;
		}
		var privacy = $('input[name="boardPublicFl"]:checked').val();
		alert(privacy);
		if (privacy == 'N') {
			var result = confirm("비공개 글은 관리자와 본인을 제외한 다른 사용자는 접근이 불가합니다. 그래도 진행하시겠습니까?");
			if (result) {
				$("#boardForm").submit();
			}
		}
		$("#boardForm").submit();
	}

	function saveFile() {
		var formData = new FormData();
		var inputFile = $("input[name='file']");
		var files = inputFile[0].files;

		for (var i = 0; i < files.length; i++) {
			formData.append("file", files[i]);
		}

		$.ajax({
			url : "upload.do",
			dataType : "json",
			processData : false,
			contentType : false,
			data : formData,
			type : "POST",
			success : function(data) {
				var fileIdx = "";
				for (var i = 0; i < data.length; i++) {
					if (i + 1 != data.length)
						fileIdx += data[i].fileIdx + ",";
					else
						fileIdx += data[i].fileIdx;
				}
				$("#fileIdx").val(fileIdx);
				alert($("#fileIdx").val());
			}
		});
	}
</script>
</head>
<body>
	<div class="limiter animsition">
		<div class="container-login100">
			<div class="wrap-login100">
				<div class="login100-form">
					<h4>
						<i class="fa fa-paper-plane" style="color: #b224ef;"></i> 새글 작성 /
						수정
					</h4>
					<div class="row">
						<div class="col-sm-12">
							<form action="write.do" name="boardForm" id="boardForm" method="post">
								<input type="hidden" id="boardWriter" name="boardWriter" value=${id }>
								<input type="hidden" id="fileIdx" name="fileIdx">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<th class="padding-lg">제 목</th>
											<td colspan="4"><input type="text"
												class="form-control write-form" id="title" name="boardTitle"
												placeholder="제목을 작성해 주세요."></td>
										</tr>
										<tr>
											<th>작성자</th>
											<td>${id}</td>
											<td colspan="2">
												<input type="radio" name="boardPublicFl" id="privacy" value="Y" checked="checked">공개
												<input type="radio" name="boardPublicFl" id="privacy" value="N">비공개
											</td>
											
										</tr>
										<tr>
											<td colspan="4">
												<div class="detail-content">
													<textarea class="form-control write-form" rows="14"
														id="contents" name="boardContents" placeholder="내용을 작성해 주세요."></textarea>
												</div>
											</td>
										</tr>
										<tr>
											<th class="padding-lg">첨부파일</th>

											<td colspan="3">
											<input type="file" multiple="multiple"	class="form-control write-form file-form" name="file"
												id="file" onchange="saveFile()">
											</td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="list()">목록</button>
						</div>
						<div class="col-sm-8"></div>
						<div class="col-sm-2">
							<button class="btn btn-default btn-full" onclick="save()">저장</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>
</html>