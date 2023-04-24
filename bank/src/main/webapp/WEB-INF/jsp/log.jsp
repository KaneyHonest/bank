<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="model.DateSettings, model.Log, java.util.List"%>
<%DateSettings dateSettings = (DateSettings) request.getAttribute("dateSettings"); %>
<%
@SuppressWarnings("unchecked")
List<Log> logs = (List<Log>) request.getAttribute("logs");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>記録の参照</title>
</head>
<body>
<form action="/bank/ReferLog" method="get">
<input type="month" name="date" value="<%=dateSettings.getDate() %>" min="<%=dateSettings.getMinDate() %>" max="<%=dateSettings.getMaxDate() %>">
<input type="submit" value="参照">
</form>
<p>記録一覧</p>
<table>
		<tr>
			<th>新しい順</th>
			<th>操作</th>
			<th>宛名</th>
			<th>金額</th>
			<th>残高</th>
		</tr>
		<tr>
			<%
			for (Log log: logs) {
			%>
			<th>
			<%=log.getOperationTime()%>
			</th>
			<th>
			<%=log.getOperation()%>
			</th>
			<th>
			<%=log.getAddressee()%>
			</th>
			<th>
			<%=log.getAmount()%>
			</th>
			<th>
			<%=log.getBalance()%>
			</th>
			</tr>
			<tr>
			<%
			}
			%>
		</tr>
	</table>
</body>
</html>