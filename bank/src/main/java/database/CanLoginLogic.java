package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;

public class CanLoginLogic {
	public boolean execute(User user) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		try {
			con = DBManager.getConnection();
			ps = con.prepareStatement("select exists (select accountNumber from user where accountNumber = ? and password = ?);");
			ps.setString(1, user.getAccountNumber());
			ps.setString(2, user.getPassword());
			rs = ps.executeQuery();
			rs.next();

			final int EXISTENCE = 1;
			return rs.getInt(1) == EXISTENCE; // 口座番号とパスワードが合致する口座があればログイン成功
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
}
