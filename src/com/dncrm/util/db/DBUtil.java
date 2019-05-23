package com.dncrm.util.db;

import com.sun.rowset.CachedRowSetImpl;

import javax.sql.rowset.CachedRowSet;
import java.sql.*;

public class DBUtil {

    private static String url;
    private static String driver;
    private static String username;
    private static String password;
    private static Connection conn;

    public static String getUrl() {
        return url;
    }

    public static void setUrl(String url) {
        DBUtil.url = url;
    }

    public static void setDriver(String driver) {
        DBUtil.driver = driver;
    }

    public static String getDriver() {
        return driver;
    }

    public static String getUsername() {
        return username;
    }

    public static void setUsername(String username) {
        DBUtil.username = username;
    }

    public static String getPassword() {
        return password;
    }

    public static void setPassword(String password) {
        DBUtil.password = password;
    }

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName(driver);
                conn = DriverManager.getConnection(url, username, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }

    public static boolean executeSQL(String sql) throws SQLException {
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        boolean flag = stmt.execute(sql);
        stmt.close();
        conn.close();
        return flag;
    }

    public static ResultSet executeQuery(String sql) throws SQLException {
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        CachedRowSet crs = new CachedRowSetImpl();
        crs.populate(rs);
        stmt.close();
        conn.close();
        return crs;
    }

    public static int executeUpdate(String sql) throws SQLException {
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        int cnt = stmt.executeUpdate(sql);
        return cnt;
    }

    public static Connection getConn() {
        return conn;
    }

    public static void setConn(Connection conn) {
        DBUtil.conn = conn;
    }

}
