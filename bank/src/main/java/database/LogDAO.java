package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import database.DBManager;

public class LogDAO {
	public List<Log> execute(Account account) {
		List<Log> logs = new ArrayList<>();
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select log.operationTime, log.operation, log.beforeBalance, log.amount, log.afterBalance from log join user using(id) where user.accountNumber = ? order by log.operationTime desc limit 5;");
			ps.setString(1, account.getAccountNumber());
			rs = ps.executeQuery();
			while (rs.next()) {
				Log log = new Log();
				log.setOperationTime(new SimpleDateFormat("yyyy年MM月dd日 hh時mm分ss秒").format(rs.getTimestamp(1)));
				log.setOperation(rs.getString(2));
				log.setBeforeBalance(rs.getInt(3));
				log.setAmount(rs.getInt(4));
				log.setAfterBalance(rs.getInt(5));
				logs.add(log);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		
		
		
		return logs;
	}
}
