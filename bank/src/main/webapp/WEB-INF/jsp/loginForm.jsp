<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.ErrorMessage"%>
<%
response.setHeader("Cache-Control", "no-store");
%>
<%
ErrorMessage errorMessage = (ErrorMessage) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css" media="all">
</head>
<body>
	<div class="form_area">
		<h1 class="form_title">ログイン画面</h1>
		<%if (errorMessage != null) {%>
		<p class="error_area"><%=errorMessage.getMessage()%></p>
		<%}%>
		<form class="input_form" action="/bank/Login" method="post">
			<label for="accountNumber">口座番号</label>
			<input type="text" name="accountNumber" id="accountNumber" class="input_area" required placeholder="必須" title="口座番号を入力してください"> 
			<label for="password">パスワード</label> 
			<input type="password" name="password" id="password" class="input_area" required autocomplete="new-password" placeholder="必須" title="パスワードを入力してください"> 
			<input type="submit" value="登録" id="button">
		</form>
		<a class="form_back_btn" href="/bank/Bank">戻る</a>
	</div>
	<script type="text/javascript">
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset(); // ブラウザー自動入力対策
	});
	
	const accountNumberInput = document.querySelector("#accountNumber");
	const passwordInput = document.querySelector("#password");

	// 初期値
	passwordInput.setCustomValidity('入力必須');
	accountNumberInput.setCustomValidity('入力必須');

	passwordInput.addEventListener('input', () => {
		passwordInput.setCustomValidity('');
		passwordInput.checkValidity();
	});
	passwordInput.addEventListener('invalid', () => {
		accountNumberInput.setCustomValidity('入力必須');
	});
	
	accountNumberInput.addEventListener('input', () => {
		accountNumberInput.setCustomValidity('');
		accountNumberInput.checkValidity();
	});
	accountNumberInput.addEventListener('invalid', () => {
		passwordInput.setCustomValidity('入力必須');
	});
</script>
</body>
</html>