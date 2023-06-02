package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBManager;
import model.Account;

public class SetBalanceLogic {
	
	public void execute(Account account) {
		
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select balance from user where accountNumber = ?;");
			ps.setString(1, account.getAccountNumber());
			rs = ps.executeQuery();
			rs.next();
			
			account.setBalance(rs.getInt(1));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
