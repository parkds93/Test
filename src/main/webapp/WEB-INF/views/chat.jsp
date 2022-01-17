<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<script src="resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/0.3.4/sockjs.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.origin.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/vendor/fontawesome-free-5.8.2-web/css/all.min.css">
<link rel="stylesheet" id="bootstrap-css"
	href="resources/css/chat_main.css">
<title>ITKey Talk</title>

<script type="text/javascript">
	$(document).ready(function() {
			$("#sendBtn").click(function() {
				if($("#message").val()==""){
					alert("내용을 입력해주세요");
					$("#message").focus();
				}else{
					sendMessage();
					$("#message").val("");
					$("#message").focus();
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
		sock.send($("#message").val());
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
			appendText = "<div class='outgoing_msg'>"
					+ "<div class='sent_msg'>"
					+ "<p>" + data.message + "</p>"
					+ "<span class='time_date'>" + month + "월" + date + "일"
					+ " | " + today.toLocaleTimeString()+"</span>" 
					+ "</div></div>";
			$("#msg_history").append(appendText);
			$('#msg_history').scrollTop($('#msg_history')[0].scrollHeight);
		} else { // 상대방이 보낸 메세지
			appendText = "<div class='incoming_msg'>"
					+ "<div class='incoming_msg_img'>"
					+ "<img src='resources/images/upload/"+data.fileChangedName +"' alt='sunil'>"
					+ "</div><div class='received_msg'>"
					+ "<div class='received_withd_msg'>"
					+ "<h4>"+data.boardWriterName+"</h4>"
					+ "<p>"+data.message+"</p>" 
					+ "<span class='time_date'>" + month + "월" + date + "일"
					+ " | " + today.toLocaleTimeString()+"</span>"  
					+ "</div></div></div>";
			$("#msg_history").append(appendText);
			$('#msg_history').scrollTop($('#msg_history')[0].scrollHeight); // 메세지 전송시 스크롤 맨밑으로 개쩐다
		}
		//sock.close();

	}

	function onClose(evt) {
		$("#data").append("연결 끊김");
	}
</script>
</head>

<body>
	<div class="container">
		<h3 class=" text-center">
			<div class="jumbotron">
				<h1>
					<i class="fa fa-paper-plane color-blue"></i> ITKey <font
						class="color-blue">T</font>alk
				</h1>
				<p>ITKEY 단체 채팅방 개발을 위한 퍼블리싱 파일입니다. 해당 채팅방을 예쁘게 만들어 주세요.</p>
			</div>
			<input class="mainbtn" style="float: right;" type="button"
				value="메인화면" onclick="location.href='main.do'">
		</h3>
		<div class="messaging">
			<div class="inbox_msg">
				<div class="mesgs">
					<div class="msg_history" id="msg_history"></div>
					<div class="type_msg">
						<div class="input_msg_write">
							<input type="text" class="write_msg" id="message"
								placeholder="내용을 입력해 주세요." />
							<button class="msg_send_btn" id="sendBtn" type="button">
								<i class="fa fa-paper-plane" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>