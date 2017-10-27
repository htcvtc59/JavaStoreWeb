/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.dao;

import com.shop.admin.dto.AccountClientAdmin;
import com.shop.admin.iconnectdb.MicrosoftDAOFactory;
import com.shop.admin.iconnectdb.idao.tblAccountClientDAO;
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
public class MicrosoftAccountClientDAO implements tblAccountClientDAO {

    private static MicrosoftAccountClientDAO instance = null;

    public static MicrosoftAccountClientDAO getIntance() {
        if (instance == null) {
            instance = new MicrosoftAccountClientDAO();
        }
        return instance;
    }

    @Override
    public int insertAccountClient(AccountClientAdmin a) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspInserttblAccountClient(?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, a.getRealname());
            cStmt.setString(3, a.getIdaccount());
            cStmt.setString(4, a.getUsername());
            cStmt.setString(5, a.getPassword());
            cStmt.setString(6, a.getEmail());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result;

    }

    @Override
    public boolean deleteAccountClient(int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspDeletetblAccountClient(?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean updateAccountClient(AccountClientAdmin a, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdatetblAccountClient(?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setString(3, a.getNote());
            cStmt.setBoolean(4, a.isStatus());

            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return result == 1;
    }

    @Override
    public ArrayList<AccountClientAdmin> dataAccountClient() {
        ArrayList<AccountClientAdmin> arrAccountClientAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblAccountClient}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                AccountClientAdmin a = new AccountClientAdmin();
                a.setId(rs.getInt(1));
                a.setRealname(rs.getString(2));
                a.setIdaccount(rs.getString(3));
                a.setUsername(rs.getString(4));
                a.setPassword(rs.getString(5));
                a.setEmail(rs.getString(6));
                a.setSalt(rs.getString(7));
                a.setCreateddate(rs.getDate(8));
                a.setNote(rs.getString(9));
                a.setStatus(rs.getBoolean(10));

                arrAccountClientAdmin.add(a);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrAccountClientAdmin;

    }

    @Override
    public boolean loginAccountClient(AccountClientAdmin a) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspLoginAccountClient(?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, a.getUsername());
            cStmt.setString(3, a.getPassword());

            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftAccountClientDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return result == 1;

    }

}
