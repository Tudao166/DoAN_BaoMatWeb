package com.webshoes.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.http.HttpServlet;

public class ConnectionProvider extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private static Connection connection;

        
        private static String url = "jdbc:mysql://127.0.0.1:3306/webshoes";
        private static String user = "root";
        private static String password = "123456";
	public static Connection getConnection1() {

		try {
			if (connection == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connection = DriverManager.getConnection(url, user, password);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
        
            
        public static Connection getConnection() {
            connection = null;
            try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, password);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            if(connection==null) System.out.println("Connect failed!");

            return connection;
    }
}
