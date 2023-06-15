<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page
	import="model.Account, model.ErrorMessage, model.AccountSetting"%>
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
<title>出金画面</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css" media="all">
</head>
<body>
	<div class="form_area">
		<h1 class="form_title">出金画面</h1>
		<%if (errorMessage != null) {%>
		<p class="error_area"><%=errorMessage.getMessage()%></p>
		<%}%>
		<form class="input_form" action="/bank/Withdraw" method="post">
			<label for="amount">金額(残高:<%= String.format("%,d", account.getBalance()) %>)</label> 
			<input type="number" name="amount" id="amount" class="input_area" min="1" max="<%= account.getBalance() > AccountSetting.SINGLE_TRANSACTION_LIMIT ? AccountSetting.SINGLE_TRANSACTION_LIMIT : account.getBalance() %>" placeholder="金額" title="金額を入力" required>
			<input type="submit" value="出金">
		</form>
		<a class="form_back_btn" href="/bank/Main">戻る</a>
	</div>
	<script type="text/javascript">
	window.addEventListener("pageshow", () => {
		const form = document.querySelector("form");
		form.reset(); // ブラウザー自動入力対策
	});
	
	const input = document.querySelector("input");
	const max = input.max;
	const regexp = /^0+/;
	
	// 初期値
	input.setCustomValidity('金額を入力してください。');
	
	input.addEventListener('input', () => {
		input.setCustomValidity('');
		input.checkValidity();
		if (regexp.test(input.value)) {
			input.setCustomValidity('先頭が０から始まる金額は不正です。');
		} 
	});
	
	input.addEventListener('invalid', () => {
		  if (input.validity.rangeOverflow || input.validity.rangeUnderflow) {
			  if (max == 1) {
				  input.setCustomValidity("金額は1円を入力してください。");
			  } else if (max < 10000){
				  input.setCustomValidity("金額は1-" + max + "円の範囲で入力してください。");
			  } else {
				  input.setCustomValidity("金額は1-" + Math.floor(max / 10000) + "万" + (max % 10000 != 0 ? max % 10000 : "") + "円の範囲で入力してください。");
			  }
		  } else if (input.validity.stepMismatch) {
			  input.setCustomValidity('整数値を入力してください。');
		  } else if (input.validity.valueMissing) {
			  input.setCustomValidity('金額を入力してください。');
		  } 
	});
</script>
</body>
</html>