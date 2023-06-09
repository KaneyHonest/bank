package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.Account;

public class UpdateBlanceLogic {
	public void execute(Account account, int balance) {
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("update user set balance=? where accountNumber = ?;");
			ps.setInt(1, balance);
			ps.setString(2, account.getAccountNumber());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
