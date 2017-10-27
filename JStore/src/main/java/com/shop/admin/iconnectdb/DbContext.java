/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MacOS
 */
public class DbContext {

    private static DbContext instance = null;

    private DbContext() {
    }

    public static DbContext Instance() {
        if (instance == null) {
            instance = new DbContext();
        }
        return instance;
    }

    public static Connection getConnection(String server, int port, String db, String account, String pass, String connect) {
        Connection conn = null;

        try {
            Class.forName(connect);
            conn = DriverManager.getConnection("jdbc:sqlserver://" + server + ":" + port + ";databaseName=" + db, account, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DbContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DbContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }

}
