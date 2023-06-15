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
<title>登録フォーム</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css" media="all">
</head>
<body>
	<div class="form_area">
		<h1 class="form_title">登録フォーム</h1>
		<%if (errorMessage != null) {%>
		<p class="error_area"><%=errorMessage.getMessage()%></p>
		<%}%>
		<form class="input_form" action="/bank/Register" method="post">
			<label for="name">名前</label> 
			<input type="text" id="name" class="input_area" name="name" required size="20" placeholder="ユーザー名" maxlength="10" title="名前を入力してください">
			<label for="password">パスワード(半角英数字4-16文字)</label>
			 <input id="password" class="input_area" name="password" autocomplete="new-password" type="password" size="20" required placeholder="パスワード" pattern="^[0-9a-zA-Z]{4,16}$" title="半角英数字4-16文字のパスワードを入力してください">
			<input type="submit" value="登録">
		</form>
		<a class="form_back_btn" href="/bank/Bank">戻る</a>
	</div>
	<script type="text/javascript">
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset(); // ブラウザー自動入力対策
	});
	
	const nameInput = document.querySelector("#name");
	const passwordInput = document.querySelector("#password");

	//初期値
	nameInput.setCustomValidity('名前を入力してください。');
	passwordInput.setCustomValidity('パスワードを入力してください。');
	
	nameInput.addEventListener('input', () => {
		nameInput.setCustomValidity('');
		nameInput.reportValidity();
	});
	
	nameInput.addEventListener('invalid', () => {
		if (nameInput.validity.valueMissing) {
			nameInput.setCustomValidity('名前を入力してください。');
		} else if (nameInput.validity.tooLong) {
			nameInput.setCustomValidity('名前は10文字以内で入力してください。');
		}
	});

	passwordInput.addEventListener('input', () => {
		passwordInput.setCustomValidity('');
		passwordInput.reportValidity();
	});
	
	passwordInput.addEventListener('invalid', () => {
		if (passwordInput.validity.valueMissing) {
			passwordInput.setCustomValidity('パスワードを入力してください。');
		} else if (passwordInput.validity.patternMismatch) {
			passwordInput.setCustomValidity('パスワードは半角英数字4-16文字を入力してください。');
		} 
	});
	</script>
</body>
</html>