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
div {
	margin: 100px auto;
	padding-top: 10px;
	height: 425px;
	width: 400px;
	border: 1px solid gray;
	border-radius: 5px;
}

h1 {
	margin: 50px 0px 30px 0px;
	font-size: 40px;
	text-align: center;
}

form {
	text-align: center;
}

label {
	font-size: 20px;
}

#accountNumber, #password {
	display: block;
	margin: auto;
	border: 2px solid gray; /* 枠線 */
	border-radius: 5px; /* 角丸 */
	padding: 0.5em; /* 内側の余白量 */
	width: 20em;
	background-color: white; /* 横幅 */
	height: 30px; /* 高さ */
	font-size: 1em; /* 文字サイズ */
	line-height: 1.2; /* 行の高さ */
}

#accountNumber:focus, #password:focus {
	border: 3px solid black;
}

input[type="submit"] {
	display: block;
	margin-left: auto;
	margin-right: 50px;
	margin-top: 60px;
	font-size: 15px;
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
	font-size: 15px;
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
		<h1>ログイン画面</h1>
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
				name="accountNumber" id="accountNumber" required placeholder="口座番号"
				title="口座番号10桁を入力"><br> <label for="password">パスワード</label>
			<input type="password" name="password" id="password" required
				autocomplete="new-password" placeholder="パスワード"
				title="半角英数字4-16文字を入力"> <input type="submit" value="登録"
				id="button">
		</form>




		<a href="/bank/Bank">戻る</a>

	</div>
	<script type="text/javascript">
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset();
	});

const button = document.querySelector("input[type='sumbit']");
const form = document.querySelector("form");

button.disabled = true;

form.addEventListener('input', () => {
	button.disabled = !form.checkValidity();
});


</script>
	<script src="js/index.js"></script>
</body>


</html>