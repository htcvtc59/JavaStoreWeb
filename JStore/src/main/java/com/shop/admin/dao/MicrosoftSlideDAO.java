package com.shop.admin.dao;

import com.shop.admin.dto.SlideAdmin;
import com.shop.admin.iconnectdb.MicrosoftDAOFactory;
import com.shop.admin.iconnectdb.idao.tblSlideDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MicrosoftSlideDAO implements tblSlideDAO {

    private static MicrosoftSlideDAO instance = null;

    public static MicrosoftSlideDAO getIntance() {
        if (instance == null) {
            instance = new MicrosoftSlideDAO();
        }
        return instance;
    }

    @Override
    public boolean insertSlideAdmin(SlideAdmin slide) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspInserttblSlide(?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, slide.getImage());
            cStmt.setString(3, slide.getLink());
            cStmt.setString(4, slide.getDescription());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean deleteSlideAdmin(int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspDeletetblSlide(?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public boolean updateSlideAdmin(SlideAdmin slide, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdatetblSlide(?,?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setString(3, slide.getImage());
            cStmt.setInt(4, slide.getDisplayorder());
            cStmt.setString(5, slide.getLink());
            cStmt.setString(6, slide.getDescription());
            cStmt.setBoolean(7, slide.isStatus());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public ArrayList<SlideAdmin> dataSlideAdmin() {
        ArrayList<SlideAdmin> arrSlideAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblSlide}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                SlideAdmin pro = new SlideAdmin();
                pro.setId(rs.getInt(1));
                pro.setImage(rs.getString(2));
                pro.setDisplayorder(rs.getInt(3));
                pro.setLink(rs.getString(4));
                pro.setDescription(rs.getString(5));
                pro.setCreateddate(rs.getDate(6));
                pro.setStatus(rs.getBoolean(7));

                arrSlideAdmin.add(pro);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftSlideDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrSlideAdmin;
    }

}
