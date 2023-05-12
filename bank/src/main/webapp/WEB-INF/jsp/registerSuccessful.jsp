<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="model.User"%>
	<%response.setHeader("Cache-Control","no-store"); %>
<%
User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<style type="text/css">
h1, h2, p {
	margin : 50px 0px;
	font-size : 50px;
	text-align: center;
}

a {
  text-decoration: none;
  font-size : 30px;
    display: block;
    text-align: center;
    margin: auto;
}
</style>
</head>
<body>
<h1>登録完了</h1>
<p>あなたの口座番号</p>
<h2><%= user.getAccountNumber() %></h2>
<a href="/bank/Bank">トップ画面に戻る</a>
</body>
</html>