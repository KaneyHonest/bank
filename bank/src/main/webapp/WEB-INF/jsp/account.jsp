<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page
	import="model.Account, model.Log, java.util.List, java.util.Date, java.text.SimpleDateFormat"%>
<%
response.setHeader("Cache-Control", "no-store");
%>
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
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<style type="text/css">

table {
  border-collapse: collapse;
  margin-top: 15px;
}
th, td {
	border: solid 1px black;
	padding: 3px 10px;
}
th {
	background: gainsboro;
}
h1 {
	text-align: center;
	margin: 15px 0;
}
.flex {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	column-gap: 30px;
	row-gap: 30px;
	flex-wrap: wrap;
}

.menubar {
	display: flex;
	
	height: 8%;
	width: 100%;
	border: 1px solid gray;
	align-items: center;
	background: lightgrey;
	justify-content: center;
}

.menu {
	display: block;
	font-size: 22px;
	padding: 15px 20px;
	
}
.menubtn:hover {
	background: darkgrey;
}
a {
	text-decoration: none;
	color: black;
}

.left {
	flex-basis: 400px;
	box-shadow: 0 0 5px 1px rgba(0,0,0,0.14);
	padding: 20px;
}
.amount {
	text-align: center;
	font-size: 100px;
}
.position {
	position: absolute;
	margin-left: 5px;
}
.btn {
	margin-right:5px;
	position: relative;
	top: 8px;
	display: block;
	margin-left: auto;
	width: 90px;
	text-align:center;
	border-radius: 3px;
	border: 1px solid gray;
	background: whitesmoke;
}
.logout:hover {
	color: red;
}
.btn:active {
	background: white;
}
	
</style>
</head>
<body>
	
		<h1>口座画面</h1>
<div class="menubar">
		<%
		if (account.getBalance() == 1000000000) {
		%>
		<p class="menu">入金</p>
		<%
		} else {
		%>
		<a class="menu menubtn" href="/bank/Deposit">入金</a>
		<%
		}
		%>
		<%
		if (account.getBalance() == 0) {
		%>
		<p class="menu">出金</p>
		<p class="menu">振込</p>
		<%
		} else {
		%>
		<a class="menu menubtn" href="/bank/Withdraw">出金</a> <a class="menu menubtn"
			href="/bank/Transfer">振込</a>
		<%
		}
		%>
		<a class="menu logout" href="/bank/Logout">ログアウト</a>
	</div>
	<div class="flex">
		<div class="left">
			<h2>残高</h2>
			<p class="amount">
				<%=account.getBalance()%></p>
		</div>
		<!-- 記録出力 -->
		<div class="right">
			<h2 class="position">
				直近の記録
			</h2><a class="btn" href="/bank/ReferLog?date=<%=date%>">記録の参照</a>
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
					<td><%=log.getOperationTime()%></td>
					<td><%=log.getOperation()%></td>
					<td><%=log.getAddressee()%></td>
					<td><%=log.getAmount()%></td>
					<td><%=log.getBalance()%></td>
				</tr>
				<tr>
					<%
					}
					%>
				</tr>
			</table>
		</div>
	</div>


</body>
</html>