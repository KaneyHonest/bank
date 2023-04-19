<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account"%>
<%
Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出金画面</title>
</head>
<body>
<h1>出金画面</h1>
<p>残高<%= account.getBalance() %></p>
<form action="/bank/Withdraw" method="post">
金額：<input type="number" name="amount">
<input type="submit" value="出金">
</form>
<a href="/bank/Main">戻る</a>
</body>
</html>