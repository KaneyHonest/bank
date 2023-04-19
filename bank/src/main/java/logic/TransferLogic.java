package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import database.DBManager;
import model.Account;

public class TransferLogic {
	public void execute(Account account, String transferAccountNumber, int amount) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			ps = con.prepareStatement("insert into log (id, operationTime, operation, beforeBalance, amount, afterBalance) values ((select id from user where accountNumber = ?), ?, ?, ?, ?, ?)");
			ps.setString(1, account.getAccountNumber());
			ps.setTimestamp(2, timestamp);
			ps.setString(3, "振込");
			ps.setInt(4, account.getBalance());
			ps.setInt(5, amount);
			ps.setInt(6, account.getBalance() - amount);
			ps.executeUpdate();
			
			ps = con.prepareStatement("insert into log (id, operationTime, operation, beforeBalance, amount, afterBalance) values ((select id from user where accountNumber = ?), ?, ?, (select balance from user where accountNumber = ?), ?, (select balance from user where accountNumber = ?)+?)");
			ps.setString(1, transferAccountNumber);
			ps.setTimestamp(2, timestamp);
			ps.setString(3, "振込");
			ps.setString(4, transferAccountNumber);
			ps.setInt(5, amount);
			ps.setString(6, transferAccountNumber);
			ps.setInt(7, amount);
			ps.executeUpdate();
			
			ps = con.prepareStatement("update user set balance=balance-? where accountNumber = ?;");
			ps.setInt(1, amount);
			ps.setString(2, account.getAccountNumber());
			ps.executeUpdate();
			
			ps = con.prepareStatement("update user set balance=balance+? where accountNumber = ?;");
			ps.setInt(1, amount);
			ps.setString(2, transferAccountNumber);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	}
}
