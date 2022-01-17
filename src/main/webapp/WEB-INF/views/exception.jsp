<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Exception</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
	<style>
.base-glyphicon {
	font-size: 10em;
	color: #CF4E50;
	margin-top: 40px;
}

.panel-exception {
	margin-top: 20%;
	min-height: 400px;
	width: 50%;
	margin-left: auto;
	margin-right: auto;
}

.pan-title {
	font-size: 5em;
	color: #CF4E50;
}

.pan-content {
	font-size: 1.7em;
}

.alert-glyphicon {
	color: #CF4E50;
	font-size: 5em;
	margin-top: 20px;
	margin-left: 20px;
}

.alert-title {
	font-weight: bold;
	color: #CF4E50;
}
</style>
<body>

	<div class="container text-center">
		<div class="panel panel-default panel-exception">
			<div class="panel-body text-center">
				<span class="glyphicon glyphicon-alert base-glyphicon"></span>
				<h1 class="pan-title">${errorCode }</h1>
				<p class="pan-content">${message}</p>
			</div>
		</div>
	</div>
	<div>
		${exception.message}
	</div>
</body>
</html>