/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.dao;

import com.shop.admin.dto.CategoryAdmin;
import com.shop.admin.iconnectdb.MicrosoftDAOFactory;
import com.shop.admin.iconnectdb.idao.tblCategoryDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MicrosoftCategoryDAO implements tblCategoryDAO {

    private static MicrosoftCategoryDAO instance = null;

    public static MicrosoftCategoryDAO getIntance() {
        if (instance == null) {
            instance = new MicrosoftCategoryDAO();
        }
        return instance;
    }

    @Override
    public boolean insertCategoryAdmin(CategoryAdmin category) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspInserttblCategory(?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, category.getName());
            cStmt.setString(3, category.getMetatitle());
            cStmt.setInt(4, category.getParentid());
            cStmt.setInt(5, category.getDisplayorder());
            cStmt.setString(6, category.getSeotitle());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean deleteCategoryAdmin(int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspDeletetblCategory(?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean updateCategoryAdmin(CategoryAdmin category, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdatetblCategory(?,?,?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setString(3, category.getName());
            cStmt.setString(4, category.getMetatitle());
            cStmt.setInt(5, category.getParentid());
            cStmt.setInt(6, category.getDisplayorder());
            cStmt.setString(7, category.getSeotitle());
            cStmt.setBoolean(8, category.isStatus());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public ArrayList<CategoryAdmin> dataCategoryAdmin() {
        ArrayList<CategoryAdmin> arrCategoryAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblCategory}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                CategoryAdmin category = new CategoryAdmin();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setMetatitle(rs.getString(3));
                category.setParentid(rs.getInt(4));
                category.setDisplayorder(rs.getInt(5));
                category.setSeotitle(rs.getString(6));
                category.setCreateddate(rs.getDate(7));
                category.setStatus(rs.getBoolean(8));
                arrCategoryAdmin.add(category);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrCategoryAdmin;
    }

    @Override
    public ArrayList<CategoryAdmin> dataCategoryOrder() {
        ArrayList<CategoryAdmin> arrCategoryAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblCategoryOrder}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                CategoryAdmin category = new CategoryAdmin();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setMetatitle(rs.getString(3));
                category.setParentid(rs.getInt(4));
                category.setDisplayorder(rs.getInt(5));
                category.setSeotitle(rs.getString(6));
                category.setCreateddate(rs.getDate(7));
                category.setStatus(rs.getBoolean(8));
                arrCategoryAdmin.add(category);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrCategoryAdmin;

    }

    @Override
    public ArrayList<CategoryAdmin> dataCategoryParentID(int parentid) {
        ArrayList<CategoryAdmin> arrCategoryAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblCategoryParentID(?)}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.setInt(1, parentid);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                CategoryAdmin category = new CategoryAdmin();
                category.setId(rs.getInt(1));
                category.setName(rs.getString(2));
                category.setMetatitle(rs.getString(3));
                category.setParentid(rs.getInt(4));
                category.setDisplayorder(rs.getInt(5));
                category.setSeotitle(rs.getString(6));
                category.setCreateddate(rs.getDate(7));
                category.setStatus(rs.getBoolean(8));
                arrCategoryAdmin.add(category);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrCategoryAdmin;
    }

}
