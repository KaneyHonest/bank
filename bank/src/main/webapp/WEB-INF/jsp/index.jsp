<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%response.setHeader("Cache-Control","no-store"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>データベースバンク</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<style type="text/css">

h1 {
	margin : 100px 0px;
	font-size : 125px;
	text-align: center;
}
a {
  text-decoration: none;
  font-size : 30px;
   box-shadow: 0 5px #0023b7;
    border-radius: 5px;
    display: block;
    width: 300px;
    padding: 25px;
    box-sizing: border-box;
    background: dodgerblue;
    color: #FFF;
    text-align: center;
    margin: 10px auto;
}
a:hover {
	background: blue;
}
a:active {
  box-shadow: none;
  position: relative;
  top: 5px;
}
</style>
</head>
<body>
	<h1>データベースバンク</h1>
	<a href="/bank/Register">新規口座開設</a>
		
	<a href="/bank/Login">ログイン</a>
		
	
</body>
</html>