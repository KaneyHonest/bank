<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control", "no-store");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>データベースATM</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css" media="all">
<style type="text/css">
h1 {
	font-size: 125px;
	margin-top: 150px;
	margin-bottom: 100px;
}
a {
	font-size: 30px;
	width: 300px;
	margin: 10px auto;
	padding: 25px;
	color: #FFF;
	background: dodgerblue;
	display: block;
	border-radius: 5px;
	box-shadow: 0 5px #0023b7;
	box-sizing: border-box;
}
a:hover {
	background: blue;
}
a:active {
	position: relative;
	top: 5px;
	box-shadow: none;
}
</style>
</head>
<body>
	<h1>データベースATM</h1>
	<a href="/bank/Register">新規口座開設</a>
	<a href="/bank/Login">ログイン</a>
</body>
</html>