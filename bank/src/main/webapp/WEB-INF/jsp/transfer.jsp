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
form {
	text-align: center;
}


</style>
</head>
<body>
<div class="form_area">
<h1>振込画面</h1>
<form action="/bank/Transfer" method="post">
<label for="accountNumber">口座番号</label> <input type="text" name="accountNumber" id="accountNumber" class="input_area" pattern="^1\d{9}$" placeholder="金額" title="口座番号を入力" required ><br>
<label for="amount">金額(残高:<%= String.format("%,d", account.getBalance()) %>)</label><input type="number" name="amount" id="amount" class="input_area" min="1" max="<%= account.getBalance() > AccountSetting.SINGLE_TRANSACTION_LIMIT ? AccountSetting.SINGLE_TRANSACTION_LIMIT : account.getBalance() %>" placeholder="金額" title="金額を入力" required list="defaultNumbers">
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
<a class="form_back_btn" href="/bank/Main">戻る</a>
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
			  amountInput.setCustomValidity("金額は1円を入力してください。");
		  } else if (max < 10000){
			  amountInput.setCustomValidity("金額は1-" + max + "円の範囲で入力してください。");
		  } else {
			  amountInput.setCustomValidity("金額は1-" + (max / 10000) + "万円の範囲で入力してください。");
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
</body>
</html>