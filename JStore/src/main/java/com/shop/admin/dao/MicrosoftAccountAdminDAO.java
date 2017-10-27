/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.dao;

import com.shop.admin.dto.AccountAdmin;
import com.shop.admin.iconnectdb.MicrosoftDAOFactory;
import com.shop.admin.iconnectdb.idao.tblAccountAdminDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MacOS
 */
public class MicrosoftAccountAdminDAO implements tblAccountAdminDAO {

    private static MicrosoftAccountAdminDAO instance = null;

    public static MicrosoftAccountAdminDAO getIntance() {
        if (instance == null) {
            instance = new MicrosoftAccountAdminDAO();
        }
        return instance;
    }

    @Override
    public boolean insertAccountAdmin(AccountAdmin a) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspInserttblAccountAdmin(?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, a.getUsername());
            cStmt.setString(3, a.getPassword());
            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;

    }

    @Override
    public boolean deleteAccountAdmin(int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspDeletetblAccountAdmin(?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean updateAccountAdmin(AccountAdmin a, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdatetblAccountAdmin(?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setString(3, a.getPassword());
            cStmt.setString(4, a.getNote());
            cStmt.setBoolean(5, a.isStatus());

            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return result == 1;
    }


    @Override
    public ArrayList<AccountAdmin> dataAccountAdmin() {
        ArrayList<AccountAdmin> arrAccountAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblAccountAdmin}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                AccountAdmin a = new AccountAdmin();
                a.setId(rs.getInt(1));
                a.setUsername(rs.getString(2));
                a.setPassword(rs.getString(3));
                a.setSalt(rs.getString(4));
                a.setNote(rs.getString(5));
                a.setStatus(rs.getBoolean(6));
                arrAccountAdmin.add(a);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrAccountAdmin;
    }

    @Override
    public boolean loginAccountAdmin(AccountAdmin a) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspLoginAccountAdmin(?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, a.getUsername());
            cStmt.setString(3, a.getPassword());

            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountAdminDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return result == 1;

    }

}
