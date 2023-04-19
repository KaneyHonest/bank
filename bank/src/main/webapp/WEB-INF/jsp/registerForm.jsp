<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録フォーム</title>
</head>
<body>
<form action="/bank/Register" method="post">
名前：<input type="text" name="name"><br>
パスワード：<input type="password" name="password">
<input type="submit" value="登録">
</form>
<a href="/bank/Bank">戻る</a>
</body>
</html>