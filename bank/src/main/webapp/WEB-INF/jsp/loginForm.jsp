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
<style type="text/css">

form {
	text-align: center;
}
</style>
</head>
<body>
	<div class="form_area">
		<h1 class="form_title">ログイン画面</h1>
		<%
		if (errorMessage != null) {
		%>
		<p>
			<%=errorMessage.getMessage()%></p>
		<%
		}
		%>
		<form action="/bank/Login" method="post">
			<label for="accountNumber">口座番号</label> <input type="text"
				name="accountNumber" id="accountNumber" class="input_area" required
				placeholder="口座番号" title="口座番号10桁を入力"><br> <label
				for="password">パスワード</label> <input type="password" name="password"
				id="password" class="input_area" required
				autocomplete="new-password" placeholder="パスワード"
				title="半角英数字4-16文字を入力"> <input type="submit" value="登録"
				id="button">
		</form>




		<a class="form_back_btn" href="/bank/Bank">戻る</a>

	</div>
	<script type="text/javascript">
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset();
	});
	const accountNumberInput = document.querySelector("input[type='text']");
	const passwordInput = document.querySelector("input[type='password']");
	
	passwordInput.setCustomValidity('入力必須');
	accountNumberInput.setCustomValidity('入力必須');

	passwordInput.addEventListener('input', () => {
		passwordInput.setCustomValidity('');
		passwordInput.checkValidity();
	});
	
	accountNumberInput.addEventListener('input', () => {
		accountNumberInput.setCustomValidity('');
		accountNumberInput.checkValidity();
	});
	accountNumberInput.addEventListener('invalid', () => {
		passwordInput.setCustomValidity('入力必須');
	});
	passwordInput.addEventListener('invalid', () => {
		accountNumberInput.setCustomValidity('入力必須');
	});

</script>
</body>


</html>