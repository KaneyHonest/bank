<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="model.User"%>
<%
User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録完了</title>
</head>
<body>
<h1>登録完了</h1>
<p>あなたの口座番号は<%= user.getAccountNumber() %></p>
<a href="/bank/Bank">トップ画面に戻る</a>
</body>
</html>