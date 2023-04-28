<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account"%>
<%
Account account = (Account) session.getAttribute("account");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出金画面</title>
</head>
<body>
<h1>出金画面</h1>
<p>残高<%= account.getBalance() %></p>
<form action="/bank/Withdraw" method="post">
金額：<input type="number" name="amount" min="1" max="<%= account.getBalance() %>" placeholder="金額" title="金額を入力" required list="defaultNumbers">
<datalist id="defaultNumbers">
  <option value="1000"></option>
  <option value="10000"></option>
</datalist>
<input type="submit" value="出金">
</form>
<a href="/bank/Main">戻る</a>

<script type="text/javascript">
const input = document.querySelector("input");
const regexp = /^0+/;

input.setCustomValidity('金額を入力してください。');

input.addEventListener('input', () => {
	  if (input.validity.rangeOverflow || input.validity.rangeUnderflow) {
		  input.setCustomValidity('金額は1-1千万円の範囲で入力してください。');
	  } else if (input.validity.stepMismatch) {
		  input.setCustomValidity('整数値を入力してください。');
	  } else if (input.validity.valueMissing) {
		  input.setCustomValidity('金額を入力してください。');
	  } else if (regexp.test(input.value)) {
		  input.setCustomValidity('先頭が０から始まる金額は不正です。');
	  } else {
		  input.setCustomValidity('');
	  }
});
</script>
</body>
</html>