/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.iconnectdb;


import com.shop.admin.iconnectdb.idao.tblAccountAdminDAO;
import com.shop.admin.iconnectdb.idao.tblAccountClientDAO;
import com.shop.admin.iconnectdb.idao.tblCategoryDAO;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
import com.shop.admin.iconnectdb.idao.tblSlideDAO;


/**
 *
 * @author MacOS
 */
public abstract class DAOFactory {

    public static final int Microsoft = 1;
//    public static final int Oracle = 2;
    

    public abstract tblAccountAdminDAO getAccountAdminDAO();
    public abstract tblProductDAO getProductDAO();
    public abstract tblCategoryDAO getCategoryDAO();
    public abstract tblSlideDAO getSlideDAO();
    public abstract tblAccountClientDAO getAccountClientDAO();

    public static DAOFactory getDAOFactory(int whichFactory) {
        switch (whichFactory) {
            case Microsoft:
                return new MicrosoftDAOFactory();
                
//            case Oracle:
//                return new OracleDAOFactory();
            default:
                return null;
        }
    }

}
