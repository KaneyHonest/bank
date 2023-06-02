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
<title>登録フォーム</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<style type="text/css">
div {
	margin: 100px auto;
	padding-top: 10px;
	height: 425px;
	width: 400px;
	border: 1px solid gray;
	border-radius: 5px; 
}
h1 {
	margin : 50px 0px 30px 0px;
	font-size : 40px;
	text-align: center;
}
form {
	text-align: center;
}
label {
	font-size: 20px;
}
#name, #password {
	display: block;
	margin: auto;
	border: 2px solid gray;  /* 枠線 */
    border-radius: 5px; /* 角丸 */
    padding: 0.5em;          /* 内側の余白量 */
    width: 20em;    
    background-color: white;         /* 横幅 */
    height: 30px;           /* 高さ */
    font-size: 1em;          /* 文字サイズ */
    line-height: 1.2;        /* 行の高さ */

}

#name:focus, #password:focus {
	border: 3px solid black;
}
input[type="submit"] {
	display: block;
	margin-left: auto;
	margin-right: 50px;
	margin-top: 60px;
	font-size : 15px;
	text-align: center;
	border-radius: 3px;
    width: 50px;
    background: whitesmoke;
    color: black;
    border: 1px solid gray;
     height: 25px;
     cursor: pointer;  
}
a {
	position: relative;
	top: -25px;
  	text-decoration: none;
  	font-size : 15px;
    display: block;
    text-align: center;
    margin-left: auto;
    margin-right: 100px;
    border-radius: 3px;
    width: 50px;
    height: 25px;
    background: whitesmoke;
    color: black;
    border: 1px solid gray;
}
input[type="submit"]:hover {
	background: green;
}
input[type="submit"]:active {
	background: white;
}
a:hover {
	background: red;
}
a:active {
  background: white;
}
</style>
</head>
<body>
<div>
	<h1>登録フォーム</h1>
	<%
	if (errorMessage != null) {
	%>
	<p>
		<%=errorMessage.getMessage()%></p>
	<%
	}
	%>
	<form action="/bank/Register" method="post">
		<label for="name">名前</label> <input type="text" id="name" name="name" required
			size="20" placeholder="ユーザー名" maxlength="10" title="名前を入力してください"><br>
		<label for="password">パスワード(半角英数字4-16文字)</label> <input id="password" name="password" autocomplete="new-password"
			type="password" size="20" required placeholder="パスワード"
			pattern="^[0-9a-zA-Z]{4,16}$" title="半角英数字4-16文字のパスワードを入力してください" >
		<input type="submit" value="登録">
	</form>
	<a href="/bank/Bank">戻る</a>
	
	</div>

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