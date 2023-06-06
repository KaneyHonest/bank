package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBManager;
import model.Account;
import model.AccountSetting;

public class CanDepositLogic {
	
	public boolean execute(Account account, int amount) {
		return account.getBalance() + amount <= AccountSetting.MAXIMUM_AMOUNT;
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
			
			return rs.getInt(1) + amount <= AccountSetting.MAXIMUM_AMOUNT;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
