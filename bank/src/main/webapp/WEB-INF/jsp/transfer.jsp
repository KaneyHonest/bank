<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account, model.ErrorMessage, model.AccountSetting"%>
    <%response.setHeader("Cache-Control","no-store"); %>
<%
Account account = (Account) session.getAttribute("account");
%>
<%
ErrorMessage errorMessage = (ErrorMessage) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>振込画面</title>
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
#accountNumber, #amount {
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

#accountNumber:focus, #amount:focus {
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
<h1>振込画面</h1>
<form action="/bank/Transfer" method="post">
<label for="accountNumber">口座番号</label> <input type="text" name="accountNumber" id="accountNumber" pattern="^1\d{9}$" placeholder="金額" title="口座番号を入力" required ><br>
<label for="amount">金額(残高:<%= account.getBalance() %>)</label><input type="number" name="amount" id="amount" min="1" max="<%= account.getBalance() > AccountSetting.SINGLE_TRANSACTION_LIMIT ? AccountSetting.SINGLE_TRANSACTION_LIMIT : account.getBalance() %>" placeholder="金額" title="金額を入力" required list="defaultNumbers">
<datalist id="defaultNumbers">
  <option value="1000"></option>
  <option value="10000"></option>
</datalist>
<input type="submit" value="振込">
</form>

<%
	if (errorMessage != null) {
	%>
	<p>
		<%=errorMessage.getMessage()%></p>
	<%
	}
	%>
<a href="/bank/Main">戻る</a>
</div>
<script type="text/javascript">
window.addEventListener("pageshow", () => {
	const form = document.querySelector("form");
	form.reset();
});
const accountNumberInput = document.querySelector("input[type='text']");
const amountInput = document.querySelector("input[type='number']");
const max = amountInput.max;
const regexp = /^0+/;

accountNumberInput.setCustomValidity('口座番号を入力してください。');
amountInput.setCustomValidity('金額を入力してください。');

accountNumberInput.addEventListener('input', () => {
	accountNumberInput.setCustomValidity('');
	accountNumberInput.checkValidity();
});

accountNumberInput.addEventListener('invalid', () => {
	if (accountNumberInput.validity.valueMissing) {
		accountNumberInput.setCustomValidity('口座番号を入力してください。');
	} else if (accountNumberInput.validity.patternMismatch) {
		accountNumberInput.setCustomValidity('口座番号は半角数字10桁を入力してください。');
	} 
});

amountInput.addEventListener('input', () => {
	  if (amountInput.validity.rangeOverflow || amountInput.validity.rangeUnderflow) {
		  if (max == 1) {
			  input.setCustomValidity("金額は1円を入力してください。");
		  } else if (max < 10000){
			  input.setCustomValidity("金額は1-" + max + "円の範囲で入力してください。");
		  } else {
			  input.setCustomValidity("金額は1-" + (max / 10000) + "万円の範囲で入力してください。");
		  }
	  } else if (amountInput.validity.stepMismatch) {
		  amountInput.setCustomValidity('整数値を入力してください。');
	  } else if (amountInput.validity.valueMissing) {
		  amountInput.setCustomValidity('金額を入力してください。');
	  } else if (regexp.test(amountInput.value)) {
		  amountInput.setCustomValidity('先頭が０から始まる金額は不正です。');
	  } else {
		  amountInput.setCustomValidity('');
	  }
});


</script>
<script src="js/index.js"></script>
</body>
</html>