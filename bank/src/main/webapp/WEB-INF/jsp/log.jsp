
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="model.DateSetting,model.Log,java.util.List"%>
<%
response.setHeader("Cache-Control", "no-store");
%>
<%
DateSetting dateSetting = (DateSetting) request.getAttribute("dateSetting");
%>
<%
@SuppressWarnings("unchecked")
List<Log> logs = (List<Log>) request.getAttribute("logs");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>口座履歴</title>
<link rel="stylesheet" href="https://unpkg.com/ress/dist/ress.min.css">
<link rel="stylesheet" type="text/css" href="css/style.css" media="all">
<style type="text/css">
div {
	width: 150px;
	margin: 0 auto;
}

.font_green {
	color: green;
}

h1 {
	text-align: center;
	margin: 15px 0;
}

form {
	position: absolute;
}

a {
	left: 120px;
	position: relative;
	text-decoration: none;
	font-size: 15px;
	display: block;
	text-align: center;
	border-radius: 3px;
	width: 50px;
	height: 25px;
	background: whitesmoke;
	color: black;
	border: 1px solid gray;
}

table {
	border-collapse: collapse;
	margin: 0 auto;
}

th, td {
	text-align: center;
	border: solid 1px black;
	padding: 3px 10px;
}

th {
	background: gainsboro;
}

select {
	appearance: auto;
	text-align: center;
}
</style>
</head>
<body>

	<h1>口座履歴</h1>
	<div>
		<form action="/bank/ReferLog" method="get">
			<input type="month" name="date" value="<%=dateSetting.getDate()%>"
				min="<%=dateSetting.getMinDate()%>"
				max="<%=dateSetting.getMaxDate()%>" autocomplete="off" required>
		</form>
		<a href="/bank/Main">戻る</a>
	</div>
	<table>
		<caption>履歴一覧</caption>
		<thead>
			<tr>
				<%
				if (logs.size() != 0) {
				%>
				<th><select class="order">
						<option value="ascending" selected>昇順</option>
						<option value="descending">降順</option>
				</select></th>
				<th><select class="operation">
						<option value="" selected>操作</option>
						<option value="入金">入金</option>
						<option value="出金">出金</option>
						<option value="振込">振込</option>
				</select></th>
				<%
				} else {
				%>
				<th>日付</th>
				<th>操作</th>
				<%
				}
				%>
				<th>宛名</th>
				<th>金額</th>
				<th>残高</th>
			</tr>
		</thead>
		<tbody>

			<%
			for (Log log : logs) {
			%>
			<tr>
				<td><%=log.getOperationTime()%></td>
				<td><%=log.getOperation()%></td>
				<td><%=log.getAddress()%></td>
				<td class=" <%=log.getAmount() > 0 ? "font_green" : "font_red"%> ">
					<%=log.getAmount()%>
				</td>
				<td><%=log.getBalance()%></td>
			</tr>
			<%}%>

		</tbody>
	</table>
	<script type="text/javascript">
	
const input = document.querySelector("input[type='month']");
const form = document.querySelector("form");
const table = document.querySelector("table");
const order = document.querySelector(".order");
const operation = document.querySelector(".operation");

order?.addEventListener('change', () => {
	const tBody = table.tBodies[0];
    const rows = tBody.rows;
    for (let i = rows.length - 1; i >= 0; i--) {
		tBody.appendChild(rows[i]);
    }
});

operation?.addEventListener('change', () => {
	for (let row of table.tBodies[0].rows) {
		row.style.display = (operation.value === '' || row.cells[1].textContent === operation.value) ? 'table-row' : 'none';
	}
});

input.addEventListener('click', ()=> { 
	input.showPicker(); 
}) 
input.addEventListener('change', () => {
	if ( !input.validity.valueMissing) { 
		form.submit(); 
	} 
}); 

</script>
	<script src="js/index.js"></script>
</body>
</html>