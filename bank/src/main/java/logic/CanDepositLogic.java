package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBManager;
import model.Account;

public class CanDepositLogic {
	public boolean execute(Account account, int amount) {
		return account.getBalance() + amount <= 1000000000;
	}
	
	public boolean execute(String accountNumber, int amount) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select balance from user where accountNumber = ?;");
			ps.setString(1, accountNumber);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1) + amount <= 1000000000;
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return false;
	}
}
