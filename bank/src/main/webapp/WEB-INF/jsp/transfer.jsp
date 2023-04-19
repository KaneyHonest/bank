<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account"%>
<%
Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>振込画面</title>
</head>
<body>
<h1>振込画面</h1>
<p>残高<%= account.getBalance() %></p>
<form action="/bank/Transfer" method="post">
口座番号：<input type="number" name="accountNumber"><br>
金額：<input type="number" name="amount">
<input type="submit" value="振込">
</form>
<a href="/bank/Main">戻る</a>
</body>
</html>