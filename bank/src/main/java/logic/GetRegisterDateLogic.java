package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import database.DBManager;
import model.Account;

public class GetRegisterDateLogic {

	public String execute(Account account) {

		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select registerDate from user where accountNumber = ?;");
			ps.setString(1, account.getAccountNumber());
			rs = ps.executeQuery();
			rs.next();

			return new SimpleDateFormat("yyyy-MM").format(rs.getTimestamp(1));
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
}
