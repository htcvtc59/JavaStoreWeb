/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb;

import com.shop.admin.dao.MicrosoftAccountAdminDAO;
import com.shop.admin.dao.MicrosoftAccountClientDAO;
import com.shop.admin.dao.MicrosoftCategoryDAO;
import com.shop.admin.dao.MicrosoftProductDAO;
import com.shop.admin.dao.MicrosoftSlideDAO;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.shop.admin.iconnectdb.idao.tblAccountAdminDAO;
import com.shop.admin.iconnectdb.idao.tblAccountClientDAO;
import com.shop.admin.iconnectdb.idao.tblCategoryDAO;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
import com.shop.admin.iconnectdb.idao.tblSlideDAO;

/**
 *
 * @author MacOS
 */
public class MicrosoftDAOFactory extends DAOFactory {

    public static Connection createConnection() {
        Connection conn = null;
        try {
            Properties properties = new Properties();
            properties.load(new FileInputStream("C:\\Users\\MacOS\\Documents\\NetBeansProjects\\JStore\\database.properties"));
            String mssqllocalhost = properties.getProperty("mssqllocalhost");
            String mssqlport = properties.getProperty("mssqlport");
            String connect = properties.getProperty("mssqldriver");
            String username = properties.getProperty("mssqlusername");
            String password = properties.getProperty("mssqlpassword");
            String db = properties.getProperty("msssqldb");

            conn = DbContext.getConnection(mssqllocalhost, Integer.valueOf(mssqlport), db, username, password, connect);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(MicrosoftDAOFactory.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(MicrosoftDAOFactory.class.getName()).log(Level.SEVERE, null, ex);
        }

        return conn;
    }

    @Override
    public tblAccountAdminDAO getAccountAdminDAO() {
        return new MicrosoftAccountAdminDAO();
    }

    @Override
    public tblProductDAO getProductDAO() {
        return new MicrosoftProductDAO();
    }

    @Override
    public tblCategoryDAO getCategoryDAO() {
        return new MicrosoftCategoryDAO();
    }

    @Override
    public tblSlideDAO getSlideDAO() {
        return new MicrosoftSlideDAO();
    }

    @Override
    public tblAccountClientDAO getAccountClientDAO() {
        return new MicrosoftAccountClientDAO();
    }

}
