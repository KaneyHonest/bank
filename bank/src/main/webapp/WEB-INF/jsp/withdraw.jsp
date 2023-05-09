<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@page import="model.Account, model.ErrorMessage"%>
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
</head>
<body>
<h1>出金画面</h1>
<p>残高<%= account.getBalance() %></p>
<form action="/bank/Withdraw" method="post">
金額：<input type="number" name="amount" min="1" max="<%= account.getBalance() > 10000000 ? 10000000 : 10000000 - account.getBalance() %>" placeholder="金額" title="金額を入力" required list="defaultNumbers">
<datalist id="defaultNumbers">
  <option value="1000"></option>
  <option value="10000"></option>
</datalist>
<input type="submit" value="出金">
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

<script type="text/javascript">
const input = document.querySelector("input");
const max = input.max;
const regexp = /^0+/;

input.setCustomValidity('金額を入力してください。');

input.addEventListener('input', () => {
	  if (input.validity.rangeOverflow || input.validity.rangeUnderflow) {
		  if (max == 1) {
			  input.setCustomValidity("金額は1円を入力してください。");
		  } else if (max < 10000){
			  input.setCustomValidity("金額は1-" + max + "円の範囲で入力してください。");
		  } else {
			  input.setCustomValidity("金額は1-" + (max / 10000) + "万円の範囲で入力してください。");
		  }
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

window.addEventListener("pageshow", () => {
	const form = document.querySelector("form");
	form.reset();
});
</script>
</body>
</html>