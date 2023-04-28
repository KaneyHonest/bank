<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account"%>
<%
Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>振込画面</title>
</head>
<body>
<h1>振込画面</h1>
<p>残高<%= account.getBalance() %></p>
<form action="/bank/Transfer" method="post">
口座番号：<input type="text" name="accountNumber" pattern="^1\d{9}$" placeholder="金額" title="口座番号を入力" required ><br>
金額：<input type="number" name="amount" min="1" max="<%= account.getBalance() %>" placeholder="金額" title="金額を入力" required list="defaultNumbers">
<datalist id="defaultNumbers">
  <option value="1000"></option>
  <option value="10000"></option>
</datalist>
<input type="submit" value="振込">
</form>
<a href="/bank/Main">戻る</a>

<script type="text/javascript">
const accountNumberInput = document.querySelector("input[type='text']");
const amountInput = document.querySelector("input[type='number']");
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
		  amountInput.setCustomValidity('金額は1-1千万円の範囲で入力してください。');
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