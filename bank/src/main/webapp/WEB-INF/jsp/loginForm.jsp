<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.ErrorMessage"%>
	<%response.setHeader("Cache-Control","no-store"); %>
<%
ErrorMessage errorMessage = (ErrorMessage) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
</head>
<body>
	<h1>ログイン画面</h1>
	<form action="/bank/Login" method="post">
		口座番号：<input type="text" name="accountNumber" id="accountNumber"
			required placeholder="口座番号" title="口座番号10桁を入力"><br>
		パスワード：<input type="password" name="password" id="password" required autocomplete="new-password"
			placeholder="パスワード" title="半角英数字4-16文字を入力"> <input
			type="submit" value="登録" id="button">
	</form>

	<%
	if (errorMessage != null) {
	%>
	<p>
		<%=errorMessage.getMessage()%></p>
	<%
	}
	%>


	<a href="/bank/Bank">戻る</a>

	<script type="text/javascript">

const button = document.querySelector("#button");
const form = document.querySelector("form");

button.disabled = true;

form.addEventListener('input', () => {
	button.disabled = !form.checkValidity();
});

window.addEventListener("pageshow", () => {
	const form = document.querySelector("form");
	form.reset();
});
</script>
</body>


</html>