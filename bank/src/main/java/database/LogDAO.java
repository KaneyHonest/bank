package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import model.Account;
import model.Log;

public class LogDAO {
	// 個数指定
	public List<Log> execute(Account account, int logNumber) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement(
					"select log.operationTime, log.operation, log.address, log.amount, log.afterBalance from log join user using(id) where user.accountNumber = ? order by log.operationTime desc limit ?;");
			ps.setString(1, account.getAccountNumber());
			ps.setInt(2, logNumber);
			rs = ps.executeQuery();

			List<Log> logs = new ArrayList<>();
			while (rs.next()) {
				Log log = new Log();
				log.setOperationTime(new SimpleDateFormat("yyyy年M月d日").format(rs.getTimestamp(1)));
				log.setOperation(rs.getString(2));
				log.setAddress(rs.getString(3));
				log.setAmount(rs.getString(4));
				log.setBalance(rs.getInt(5));
				logs.add(log);
			}

			return logs;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	// 日付指定
	public List<Log> execute(Account account, String date) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement(
					"select log.operationTime, log.operation, log.address, log.amount, log.afterBalance from log join user using(id) where user.accountNumber = ? and log.operationTime like ? order by log.operationTime desc;");
			ps.setString(1, account.getAccountNumber());
			ps.setString(2, date + "%");
			rs = ps.executeQuery();

			List<Log> logs = new ArrayList<>();
			while (rs.next()) {
				Log log = new Log();
				log.setOperationTime(new SimpleDateFormat("yyyy年M月d日").format(rs.getTimestamp(1)));
				log.setOperation(rs.getString(2));
				log.setAddress(rs.getString(3));
				log.setAmount(rs.getString(4));
				log.setBalance(rs.getInt(5));
				logs.add(log);
			}

			return logs;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
}
