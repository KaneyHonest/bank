<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
</head>
<body>
<h1>ログイン画面</h1>
<form action="/bank/Login" method="post">
口座番号：<input type="text" name="accountNumber"><br>
パスワード：<input type="password" name="password">
<input type="submit" value="登録">
</form>
<a href="/bank/Bank">戻る</a>
</body>
</html>