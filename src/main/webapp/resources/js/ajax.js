var date = new Date();
var cdata = null;
var img = null;

function commonAjax(url, type, data, dataType){
	var result = "";
	$.ajax({
		url: url,
		type: type,
		data: data,
		dataType: dataType,
		async: false,
		success: function(rs){
			result = rs;
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return result;
}

function commonAjaxMulti(url, data, dataType){
	var result = "";
	$.ajax({
		url: url,
		type: 'post',
		data: data,
		dataType: dataType,
		processData: false,
		contentType: false,
		enctype: 'multipart/form-data',
		async: false,
		success: function(rs){
			result = rs;
		},
		error: function(request,status,error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
	return result;
}

// 회원확인 ( 아이디확인 및 회원가입 )
function memEvent(param){
	var result = commonAjax($('#checkIdUrl').val(), 'post', $('#joinForm').serialize(), 'text');
	if(param == "insert"){
		if(result == 0){
			var formdata = new FormData(document.getElementById("joinForm"));
			var rs = commonAjaxMulti($('#joinForm').attr('action'), formdata, 'text');
			if(rs == 1){
				alert('회원가입 성공');
				$('#jCancleBtn').trigger('click');
			}else{
				alert('회원가입 실패');
			}
		}else{
			alert('이미 존재하는 아이디입니다.');
		}
	}else if(param == "check"){
		if(result == 0){
			$('#checkId').css('display', 'none');
		}else{
			$('#checkId').css('display', 'block');
		}
	}
}

function chkEmail(str) {
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
	if (regExp.test(str)) return true;
	else return false;
}

function readURL(input) {
	var reader = new FileReader();
	reader.onload = function(e) {
		$('#upimg').attr('src', e.target.result);
	}
	reader.readAsDataURL(input.files[0]);
}

function imgError(image){
	image.onerror = "";
	image.src = "resources/images/noImage.png";
	return true;
}

function pageBtn(page){
	$('#selPage').val(page);
	commonAjax($('#pageURL').val(), 'post', {selPage : $('#selPage').val()}, 'json');
	getBoardList();
}

function downFile(idx){
	var result = commonAjax($('#downURL').val(), 'post', {fileIdx : idx}, 'text');
	if(result == 'fail'){
		alert('다운로드할 파일을 찾지 못했습니다.');
	}else{
		location.href= $('#downURL').val()+'?fileIdx='+idx;
	}
}

function delBd(idx, writer){
	var result = confirm('글을 삭제하시겠습니까?');
	if(result){
		var result = commonAjax($('#delURL').val(), 'post', {boardIdx : idx, boardWriter : writer}, 'text');
		if(result == 'success'){
			alert('삭제 성공');
			$('#modiCloseBtn').trigger('click');
			getBoardList();
		}else{
			alert('삭제 실패');
		}
	}
}

function delFile(){
	$('#fileIdx').val('0');
	$('#input-file-now').css('display', 'block');
	$('#fileInfo').html('');
}

function modBd(){
	$('#modiCloseBtn').trigger('click');
	$('#writeModal').modal();
	
	$('#modiIdx').val(cdata.idx);
	$('#insertTitle').val(cdata.title);
	$('#today').text(cdata.date);
	if(cdata.lock == 'Y') $('input:radio[name="boardPublicFl"]:input[value="Y"]').attr('checked', true);
	$('#insertCont').val(cdata.cont);
	
	if(cdata.fIdx != null) {
		$('#fileInfo').html(cdata.fName + ' <span style=\"margin-left: 10px; cursor: pointer; color: purple\" onclick=\"delFile()\">[ 삭제  ]</span> ');
		$('#fileIdx').val(cdata.fIdx);
		$('#input-file-now').css('display', 'none');
	}
}

function showCont(idx, writer){
	var data = { boardIdx : idx, boardWriter : writer};
	var result = commonAjax($('#selUrl').val(), 'post', data, 'json');
	
	cdata = {
		idx : result.bdCont.boardIdx,
		writer : result.bdCont.boardWriter,
		title : result.bdCont.boardTitle,
		cont : result.bdCont.boardContents,
		name : result.bdCont.boardWriterName,
		date : result.bdCont.boardWriteDate,
		view : result.bdCont.boardViewCount,
		lock : result.bdCont.boardPublicFl,
		fIdx : null,
		fName : null
	};
	
	if(result.bdFile != null){
		cdata.fIdx = result.bdFile.fileIdx
		cdata.fName = result.bdFile.fileOriginalName
	}
	
	// 제목
	if(cdata.title != null) $('#contTitle').text(cdata.title);
	else $('#contTitle').text('제목없음');
	
	// 조회수
	if(cdata.view != null) $('#contView').text(cdata.view);
	else $('#contView').text('0');
	
	// 작성자
	$('#contName').text(cdata.name);
	
	// 작성일
	if(cdata.date != null) $('#contDate').text(cdata.date);
	else $('#contDate').text('알수없음');	

	// 내용
	if(cdata.cont != null) $('#contCont').text(cdata.cont);
	else $('#contCont').text('내용없음');
	
	// 첨부파일
	if(result.bdFile == null){
		$('#contFile').text('첨부된 파일이 없습니다');
	}else{
		var cont = '';
		cont += '<button onclick=\'downFile('+ cdata.fIdx +')\'> '+ cdata.fName +' </button>';
		$('#contFile').html(cont);
	}
	
	//삭제 및 수정 버튼
	if(cdata.writer == $('#loginId').val()){
		$('#modiDiv').html('<button onclick=\"modBd()\" class=\"btn btn-default btn-full\">수정</button>');
		$('#delDiv').html('<button onclick=\"delBd('+ idx +', '+ writer +')\" class=\"btn btn-default btn-full\">삭제</button>');
	}else{
		$('#modiDiv').html('');
		$('#delDiv').html('');
	}

	for(var a = 0; a < result.bdPreBef.length; a++){
		if(result.bdCont.boardIdx > result.bdPreBef[a].boardIdx){
			$('#contBef').css('display', 'block');
			$('#contBefBtn').text(result.bdPreBef[a].boardTitle);
			$('#contBefBtn').attr('onclick', 'modiModal(\''+ result.bdPreBef[a].boardPublicFl + '\',' + result.bdPreBef[a].boardIdx +', \''+ result.bdPreBef[a].boardWriter +'\')');
			$('#contBefDate').text(result.bdPreBef[a].boardWriteDate);
		}else if(result.bdCont.boardIdx < result.bdPreBef[a].boardIdx){
			$('#contPre').css('display', 'block');
			$('#contPreBtn').text(result.bdPreBef[a].boardTitle);
			$('#contPreBtn').attr('onclick', 'modiModal(\''+ result.bdPreBef[a].boardPublicFl + '\',' + result.bdPreBef[a].boardIdx +', \''+ result.bdPreBef[a].boardWriter +'\')');
			$('#contPreDate').text(result.bdPreBef[a].boardWriteDate);
		}
		
		if(result.bdPreBef.length == 1){
			if(result.bdCont.boardIdx > result.bdPreBef[a].boardIdx) $('#contPre').css('display', 'none');
			if(result.bdCont.boardIdx < result.bdPreBef[a].boardIdx) $('#contBef').css('display', 'none');
		}else if(result.bdPreBef.length == 0){
			$('#contPre').css('display', 'none');
			$('#contBef').css('display', 'none');
		}
	}
	
	/*getBoardList();*/
}

function modiModal(fl, idx, writer){
	if(fl == 'Y'){
		if(writer == $('#loginId').val()){
			showCont(idx, writer);
			if($('#modiModal').css('display') == 'none') $("#modiModal").modal();
		}else {
			alert('작성자만 볼 수 있는 게시글 입니다.');
		}
	}else{
		showCont(idx, writer);
		if($('#modiModal').css('display') == 'none') $("#modiModal").modal();
	}
}

function getBoardList(){
	// 상단 정보 출력
	var result = commonAjax($('#countURL').val(), 'post', {date: date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + date.getDate()}, 'json');
	$('#countBd').text(result.countBd);
	$('#countJoin').text(result.countJoin);
	$('#tdCountBd').text(result.tdCountBd);
	$('#tdCountJoin').text(result.tdCountJoin);

	// 조건
	var data = {"selPage" : $('#selPage').val(), "selCnt" : $('#selCnt').val()}
	if($('#searching').val() == '1'){
		data.searchF = $('#searchF option:selected').val();
		data.searchT = $('#searchT').val();
	}else{
		$('#searchT').val('');
		$('#searchF option:eq(0)').attr('selected', 'selected');
	}

	// 게시물 리스트 출력
	result = commonAjax($('#listUrl').val(), 'post', data, 'json');
	var resultCnt = commonAjax($('#cntListURL').val(), 'post', data, 'json');
	
	var cont = "";
	for(var i = 0; i < result.bdList.length; i++){    
		cont += '<tr>';
		cont += '<td style=\"text-align: center\">'+ ((resultCnt.countBd - ($('#selCnt').val() * ($('#selPage').val()-1))) - i ) +'</td>';
		cont += '<td style=\"text-align: center\">'+ result.bdList[i].boardWriterName +'</td>';
		if(result.bdList[i].boardPublicFl == 'Y'){
			cont+= '<td style=\"text-align: center\"><i class=\"fas fa-lock\"></i></td>'
		}else{
			cont+= '<td style=\"text-align: center\"><i class=\"fas fa-unlock\"></i></td>'
		}
		cont += '<td><a href=\"javascript:void(0);\" onclick=\"modiModal(\''+ result.bdList[i].boardPublicFl + '\',' +result.bdList[i].boardIdx +',\''+ result.bdList[i].boardWriter +'\')\">'+ result.bdList[i].boardTitle +'</a></td>';
		if(result.bdList[i].boardWriteDate == null){
			cont += '<td style="text-align: center"> 알수없음 </td>';
		}else{
			cont += '<td style="text-align: center">'+ result.bdList[i].boardWriteDate +'</td>';
		}
		if(result.bdList[i].boardViewCount == null){
			cont += '<td style="text-align: center">'+ 0 +'</td>';
		}else{
			cont += '<td style="text-align: center">'+ result.bdList[i].boardViewCount +'</td>';
		}
		cont += '</tr>';
	}

	$('#bdList').html(cont);
	
	//페이징
	if(resultCnt.countBd != 0){
		var totalPage = (Math.ceil(resultCnt.countBd / $('#selCnt').val()));
		var totalBlock = (Math.ceil(totalPage / $('#pageBlock').val()));
		var nowBlock = (Math.ceil($('#selPage').val() / $('#pageBlock').val()));

		cont = "";
		if(nowBlock != 1)  cont += '<li onclick=\"pageBtn('+ (((nowBlock - 1) * nowBlock) - 1) +')\"><a href=\"#\">이전</a></li>';
		for(var j = ((nowBlock - 1) * $('#pageBlock').val()) + 1; j <= (nowBlock * $('#pageBlock').val()); j++){
			if(j > totalPage) break;
			if(j == $('#selPage').val()) cont += '<li class=\"active\"><a href=\"#\">'+ j +'</a></li>';
			else cont += '<li onclick=\"pageBtn('+ j +')\" ><a href=\"#\">'+ j +'</a></li>';
		}

		if(nowBlock != totalBlock) cont += '<li onclick=\"pageBtn('+ ((nowBlock * $('#pageBlock').val())+1) +')\"><a href=\"#\">다음</a></li>';
		$('.pagination').html(cont);
	}else{
		cont = '';
		$('.pagination').html(cont);  
		cont += '<tr><td style=\"text-align:center\" colspan=\"6\"> 검색결과가 없습니다 </td></tr>';
		$('#bdList').html(cont);
	}
}

function sessionCheck(){
	var result = commonAjax($('#sessionUrl').val(), 'post', {}, 'json');
	var html = "";
	// 로그인 했을 때
	if(result.loginId != null){
		img = result.loginImg
	
		html += '<ul class=\"nav navbar-nav navbar-right navbar-logout\">';
		html += '<li class=\"login-img\"><img src=\"'+ 'resources/download/' + img + '\" class=\"img-circle img-loginer\" onerror=\"imgError(this)\" style=\"width: 35px; height: 35px;\"></li>';
		html += '<li><h5 class="h5-nav">';
		html += '<u>' +  result.loginName  + '</u><font style=\"color : #cacaca\"> 님 안녕하세요.</font>';
		html += '</h5></li>';
		html += '<li><a href=\"#\" id=\"logoutBtn\" onclick=\"logout()\"><i class=\"fas fa-sign-out-alt\"></i> 로그아웃</a>';
		html += '</li></ul>';

		$('.iframe-before-login').css('display', 'none');
		$('.table-after-login').css('display', 'block');
		$('#loginId').val(result.loginId);
		$('#writerId').val(result.loginId);
		$('#wName').html(result.loginName);

		
		
		if(result.selPage != null) $('#selPage').val(result.selPage);
		if(result.searchF != null) {
			$('#searchF').val(result.searchF);
			$('#searchT').val(result.searchT);
			$('#searching').val('1');
		}
		getBoardList();
	// 로그인 안했을 때
	}else{
		html += '<form id=\"loginForm\" action=\"/sam/login.do\" method=\"post\" >';
		html += '<ul class=\"nav navbar-nav navbar-right navbar-login\">';
		html += '<li class=\"li-login\"><input type=\"text\" class=\"form-control nav-login\" name=\"userid\" id=\"\" placeholder=\"로그인 아이디\"/></li>';
		html += '<li class=\"li-login\"><input type=\"password\" class=\"form-control nav-login\" name=\"pass\" id=\"loginPwd\" onkeyup="pwdKeyup()" placeholder=\"비밀번호\"/></li>';
		html += '<li><a href=\"#\" id=\"loginBtn\" onclick=\"login()\"><i class=\"fas fa-sign-in-alt\"></i> 로그인</a></li>';
		html += '<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#joinModal\"><i class=\"fas fa-user-plus\"></i> 회원가입</a></li>';                                                   
		html += '</ul></form>';

		$(".iframe-before-login").css('display', 'block');
		$(".table-after-login").css('display', 'none');
	}
	$("#myNavbar").html(html);
}

// 비밀번호 작성 시, 부트스트랩 css 때문에 비밀번호가 안보여져서 따로 설정함
function pwdKeyup(){
	if($('#loginPwd').val().trim() == ""){
		$('#loginPwd').css('font-family', 'inherit');
	}else{
		$('#loginPwd').attr('style', 'color: white !important');
		$('#loginPwd').css('font-family', 'normal');
	}
}

function login(){
	var result = commonAjax($('#loginCheckURL').val(), 'post', $('#loginForm').serialize(), 'text');
	if(result == 0){
		alert('아이디가 존재하지 않습니다.');
	}else if(result == 2){
		alert('비밀번호가 틀렸습니다.');
	}else if(result == 1){
		commonAjax($('#loginForm').attr('action'), 'post', $('#loginForm').serialize(), 'json');
		sessionCheck();
	}else{
		alert('알수없는 오류');
	}
}

function logout(){
	commonAjax($('#logoutURL').val(), 'post', {}, 'json');

	sessionCheck();
}

$( document ).ready(function() {
	// 세션 확인
	sessionCheck();

	// 이미지 파일 체크
	$('#up').on('change', function(){
		if( $("#up").val() != "" ){
			var ext = $('#up').val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['png','jpg','jpeg']) == -1) {
				alert('png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				$("#up").val("");
				return;
			}else{
				readURL(this);
			}
		}
	});
	
	// 아이디 체크
	$('#joinId').keyup(function(){
		memEvent("check");
	});

	// 이메일 체크
	$("#joinEmail1").keyup(function(){
		if(chkEmail($("#joinEmail1").val()) || $("#joinEmail1").val() == ""){
			$('#checkEmail').css('display', 'none');
		}else{
			$('#checkEmail').css('display', 'block');
		}
	});

	// 회원가입 버튼 클릭 이벤트
	$('#joinBtn').click(function(){
		if($("#up").val() == ""){
			alert('프로필사진을 등록해주세요');
		}else if($('#joinId').val().trim()     == ''
				||$('#joinPwd').val().trim()    == ''
				||$('#joinNm').val().trim()     == ''
				||$('#joinPhn').val().trim()    == '' 
				||$('#joinEmail1').val().trim() == ''
				||$('#joinEmail2').val().trim() == '' ){
			alert('모든항목을 빈칸없이 작성해주세요');
		}else if(!chkEmail($("#joinEmail1").val())){
			alert('이메일 양식에 맞춰 작성해 주시기 바랍니다');
		}else if($('#joinEmail1').val().trim() != $('#joinEmail2').val().trim()){
			alert('작성된 이메일이 다릅니다 이메일을 다시 확인해주시기 바랍니다.');
		}else{
			memEvent('insert');
		}
	});

	// 글쓰기 작성 버튼 이벤트
	$('#writeSaveBtn').click(function(){
		if($('#insertTitle').val().trim() == ''){
			alert('제목을 입력해주세요');
		}else if($('#insertCont').val().trim() == ''){
			alert('내용을 입력해주세요');
		}else{
			var formdata = new FormData(document.getElementById("writeForm"));
			var rs = commonAjaxMulti($('#writeForm').attr('action'), formdata, 'text');
			if(rs == 1){
				alert('게시글 작성 및 수정 성공');
				$('#writeCloseBtn').trigger('click');
				$('#selPage').val('1');
				getBoardList();
			}else{
				alert('작성 및 수정 실패');
			}
		}
	});
	
	// 글작성 버튼 클릭 시 내용 초기화
	$('#writeBtn').click(function(){
		document.getElementById('writeForm').reset();
		$('#modiIdx').val('0');
		$('#fileIdx').val('0');
		$('#fileInfo').html('');
		$('#input-file-now').css('display', 'block');
		$('#today').text(date.getFullYear() + '-' + ('0'+(date.getMonth()+1)).slice(-2) + '-' + date.getDate());
		$('input:radio[name="boardPublicFl"]:input[value="Y"]').attr('checked', false);
		$('input:radio[name="boardPublicFl"]:input[value="N"]').attr('checked', true);
	});

	// 검색 버튼 이벤트
	$('#searchBtn').click(function(){
		if($('#searchF option:selected').val() != 'A' && $('#searchT').val().trim() == ""){
			alert('검색어를 입력해주세요');
		}else{
			var data = {searchF : $('#searchF').val(), searchT : $('#searchT').val()}
			$('#selPage').val('1');
			$('#searching').val('1');
			commonAjax($('#pageURL').val(), 'post', {selPage : $('#selPage').val()}, 'json');
			commonAjax($('#searchingURL').val(), 'post', data, 'json');
			getBoardList();
		}
	});
	
	
	
	// 오늘 날짜
	$('#today').text(date.getFullYear() + '-' + ('0'+(date.getMonth()+1)).slice(-2) + '-' + ('0'+(date.getDate()+1)).slice(-2));
});