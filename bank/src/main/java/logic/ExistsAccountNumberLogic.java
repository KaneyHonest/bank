package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBManager;

public class ExistsAccountNumberLogic {
	
	public boolean execute(String accountNumber) {
		
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select exists (select accountNumber from user where accountNumber = ?);");
			ps.setString(1, accountNumber);
			rs = ps.executeQuery();
			rs.next();

			final int EXISTENCE = 1;
			return rs.getInt(1) == EXISTENCE;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return true;
	}
}
