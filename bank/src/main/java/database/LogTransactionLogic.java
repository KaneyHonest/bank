package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import model.Account;

public class LogTransactionLogic {
	// 宛先なし（入出金）
	public void execute(Account account, Timestamp currentTime,  String operation, String amount, int afterBalance) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement(
					"insert into log (id, operationTime, operation, amount, afterBalance) values ((select id from user where accountNumber = ?), ?, ?, ?, ?)");
			ps.setString(1, account.getAccountNumber());
			ps.setTimestamp(2, currentTime);
			ps.setString(3, operation);
			ps.setString(4, amount);
			ps.setInt(5, afterBalance);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 宛先有り（振込）
	public void execute(Account account, Account addressAccount, Timestamp currentTime,  String operation, String amount, int afterBalance) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement(
					"insert into log (id, operationTime, operation, address, amount, afterBalance) values ((select id from user where accountNumber = ?), ?, ?, (select name from user where accountNumber = ?), ?, ?)");
			ps.setString(1, account.getAccountNumber());
			ps.setTimestamp(2, currentTime);
			ps.setString(3, operation);
			ps.setString(4, addressAccount.getAccountNumber());
			ps.setString(5, amount);
			ps.setInt(6, afterBalance);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
