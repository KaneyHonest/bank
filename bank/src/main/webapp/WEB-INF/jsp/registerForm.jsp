<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%response.setHeader("Cache-Control","no-store"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録フォーム</title>
</head>
<body>
	<h1>登録フォーム</h1>
	<form action="/bank/Register" method="post">
		<label for="name">名前:</label> <input type="text" id="name" name="name" required
			size="20" placeholder="ユーザー名" maxlength="10" title="名前を入力してください"><br>
		<label for="password">パスワード(半角英数字4-16文字):</label> <input id="password" name="password" autocomplete="new-password"
			type="password" size="20" required placeholder="パスワード"
			pattern="^[0-9a-zA-Z]{4,16}$" title="半角英数字4-16文字のパスワードを入力してください" >
		<input type="submit" value="登録">
	</form>
	<a href="/bank/Bank">戻る</a>

	<script type="text/javascript">
	const nameInput = document.querySelector("#name");
	const passwordInput = document.querySelector("#password");

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
	
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset();
	});
	</script>
</body>
</html>