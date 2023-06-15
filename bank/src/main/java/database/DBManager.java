package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
	private static String driverName = "org.mariadb.jdbc.Driver";
	private static String url = "jdbc:mariadb://localhost:3306/bank";
	private static String user = "root";
	private static String pass = "1234";

	private DBManager() {}

	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName(driverName);
			connection = DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		return connection;
	}
}
