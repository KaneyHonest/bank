<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page
	import="model.Account, model.Log, java.util.List, java.util.Date, java.text.SimpleDateFormat"%>
	<%response.setHeader("Cache-Control","no-store"); %>
<%
Account account = (Account) session.getAttribute("account");
%>
<%
@SuppressWarnings("unchecked")
List<Log> logs = (List<Log>) request.getAttribute("logs");
%>
<%
String date = new SimpleDateFormat("yyyy-MM").format(new Date());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>口座画面</title>
</head>
<body>
	<h1>口座画面</h1>
	<% if (account.getBalance() == 1000000000) { %>
	<p>入金</p>
	<%} else { %>
	<a href="/bank/Deposit">入金</a>
	<% } %>
	<%
	if (account.getBalance() == 0) {
	%>
	<p>出金</p>
	<p>振込</p>
	<%
	} else {
	%>
	<a href="/bank/Withdraw">出金</a>
	<a href="/bank/Transfer">振込</a>
	<%
	}
	%>
	<a href="/bank/Logout">ログアウト</a>
	<p>
		残高は<%=account.getBalance()%></p>

	<!-- 記録出力 -->
	<a href="/bank/ReferLog?date=<%=date%>">記録の参照</a>
	<p>直近の記録</p>
	<table>
		<tr>
			<th>年月日(新しい順)</th>
			<th>操作</th>
			<th>宛名</th>
			<th>金額</th>
			<th>残高</th>
		</tr>
		<tr>
			<%
			for (Log log : logs) {
			%>
			<th><%=log.getOperationTime()%></th>
			<th><%=log.getOperation()%></th>
			<th><%=log.getAddressee()%></th>
			<th><%=log.getAmount()%></th>
			<th><%=log.getBalance()%></th>
		</tr>
		<tr>
			<%
			}
			%>
		</tr>
	</table>



</body>
</html>