package logic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBManager;
import model.User;

public class CanLoginLogic {

	public boolean execute(User user) {
		// TODO 自動生成されたメソッド・スタブ

		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement(
					"select exists (select accountNumber from user where accountNumber = ? and password = ?);");
			ps.setString(1, user.getAccountNumber());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1) == 1 ? true : false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
