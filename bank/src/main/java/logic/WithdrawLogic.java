package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import database.DBManager;
import model.Account;

public class WithdrawLogic {

	public void execute(Account account, int amount) {

		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();

			// 記録する
			ps = con.prepareStatement(
					"insert into log (id, operationTime, operation, amount, afterBalance) values ((select id from user where accountNumber = ?), ?, ?, ?, ?)");
			ps.setString(1, account.getAccountNumber());
			ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			ps.setString(3, "出金");
			ps.setString(4, "-" + amount);
			ps.setInt(5, account.getBalance() - amount);
			ps.executeUpdate();

			// 口座残高に反映
			ps = con.prepareStatement("update user set balance=balance-? where accountNumber = ?;");
			ps.setInt(1, amount);
			ps.setString(2, account.getAccountNumber());
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
