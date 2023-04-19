<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>入金画面</title>
</head>
<body>
<h1>入金画面</h1>
<form action="/bank/Deposit" method="post">
金額：<input type="number" name="amount">
<input type="submit" value="入金">
</form>
<a href="/bank/Main">戻る</a>
</body>
</html>