/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.dao;

import com.shop.admin.dto.ProductAdmin;
import com.shop.admin.iconnectdb.MicrosoftDAOFactory;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
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
public class MicrosoftProductDAO implements tblProductDAO {

    private static MicrosoftProductDAO instance = null;

    public static MicrosoftProductDAO getIntance() {
        if (instance == null) {
            instance = new MicrosoftProductDAO();
        }
        return instance;
    }

    @Override
    public boolean insertProductAdmin(ProductAdmin product) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspInserttblProduct(?,?,?,?,?,?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setString(2, product.getName());
            cStmt.setString(3, product.getMetatitle());
            cStmt.setString(4, product.getDescription());
            cStmt.setString(5, product.getImages());
            cStmt.setString(6, product.getMoreimages());
            cStmt.setDouble(7, product.getPrice());
            cStmt.setDouble(8, product.getPromotionprice());
            cStmt.setInt(9, product.getQuantity());
            cStmt.setInt(10, product.getCategoryid());
            cStmt.setString(11, product.getDetail());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;

    }

    @Override
    public boolean deleteProductAdmin(int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspDeletetblProduct(?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;

    }

    @Override
    public boolean updateProductAdmin(ProductAdmin product, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdatetblProduct(?,?,?,?,?,?,?,?,?,?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setString(3, product.getName());
            cStmt.setString(4, product.getMetatitle());
            cStmt.setString(5, product.getDescription());
            cStmt.setString(6, product.getImages());
            cStmt.setString(7, product.getMoreimages());
            cStmt.setDouble(8, product.getPrice());
            cStmt.setDouble(9, product.getPromotionprice());
            cStmt.setInt(10, product.getQuantity());
            cStmt.setInt(11, product.getCategoryid());
            cStmt.setString(12, product.getDetail());
            cStmt.setBoolean(13, product.isStatus());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;

    }

    @Override
    public ArrayList<ProductAdmin> dataProductAdmin() {
        ArrayList<ProductAdmin> arrProductAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblProduct}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                ProductAdmin pro = new ProductAdmin();
                pro.setId(rs.getInt(1));
                pro.setName(rs.getString(2));
                pro.setCode(rs.getString(3));
                pro.setMetatitle(rs.getString(4));
                pro.setDescription(rs.getString(5));
                pro.setImages(rs.getString(6));
                pro.setMoreimages(rs.getString(7));
                pro.setPrice(rs.getDouble(8));
                pro.setPromotionprice(rs.getDouble(9));
                pro.setIncludedvat(rs.getBoolean(10));
                pro.setQuantity(rs.getInt(11));
                pro.setCategoryid(rs.getInt(12));
                pro.setDetail(rs.getString(13));
                pro.setWarranty(rs.getInt(14));
                pro.setCreateddate(rs.getDate(15));
                pro.setStatus(rs.getBoolean(16));
                pro.setTophot(rs.getDate(17));
                pro.setViewcount(rs.getInt(18));

                arrProductAdmin.add(pro);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrProductAdmin;
    }

    @Override
    public ArrayList<ProductAdmin> dataidProductAdmin(int id) {
        ArrayList<ProductAdmin> arrProductAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDataIDtblProduct(?)}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.setInt(1, id);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                ProductAdmin pro = new ProductAdmin();
                pro.setId(rs.getInt(1));
                pro.setName(rs.getString(2));
                pro.setCode(rs.getString(3));
                pro.setMetatitle(rs.getString(4));
                pro.setDescription(rs.getString(5));
                pro.setImages(rs.getString(6));
                pro.setMoreimages(rs.getString(7));
                pro.setPrice(rs.getDouble(8));
                pro.setPromotionprice(rs.getDouble(9));
                pro.setIncludedvat(rs.getBoolean(10));
                pro.setQuantity(rs.getInt(11));
                pro.setCategoryid(rs.getInt(12));
                pro.setDetail(rs.getString(13));
                pro.setWarranty(rs.getInt(14));
                pro.setCreateddate(rs.getDate(15));
                pro.setStatus(rs.getBoolean(16));
                pro.setTophot(rs.getDate(17));
                pro.setViewcount(rs.getInt(18));

                arrProductAdmin.add(pro);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrProductAdmin;

    }

    @Override
    public boolean updateviewProductAdmin(ProductAdmin product, int id) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call uspUpdateViewtblProduct(?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, id);
            cStmt.setInt(3, product.getViewcount());

            cStmt.execute();
            result = cStmt.getInt(1);
        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return result == 1;
    }

    @Override
    public ArrayList<ProductAdmin> dataidProductAdminCate(int cateid) {
        ArrayList<ProductAdmin> arrProductAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call uspDatatblProductCategory(?)}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.setInt(1, cateid);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                ProductAdmin pro = new ProductAdmin();
                pro.setId(rs.getInt(1));
                pro.setName(rs.getString(2));
                pro.setCode(rs.getString(3));
                pro.setMetatitle(rs.getString(4));
                pro.setDescription(rs.getString(5));
                pro.setImages(rs.getString(6));
                pro.setMoreimages(rs.getString(7));
                pro.setPrice(rs.getDouble(8));
                pro.setPromotionprice(rs.getDouble(9));
                pro.setIncludedvat(rs.getBoolean(10));
                pro.setQuantity(rs.getInt(11));
                pro.setCategoryid(rs.getInt(12));
                pro.setDetail(rs.getString(13));
                pro.setWarranty(rs.getInt(14));
                pro.setCreateddate(rs.getDate(15));
                pro.setStatus(rs.getBoolean(16));
                pro.setTophot(rs.getDate(17));
                pro.setViewcount(rs.getInt(18));

                arrProductAdmin.add(pro);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrProductAdmin;

    }

    @Override
    public ArrayList<ProductAdmin> dataidProductAdminSearch(int currentpage, int limit, String name) {
        ArrayList<ProductAdmin> arrProductAdmin = new ArrayList<>();
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{Call customPage(?,?,?)}";

        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.setInt(1, currentpage);
            cStmt.setInt(2, limit);
            cStmt.setString(3, name);

            ResultSet rs = cStmt.executeQuery();
            while (rs.next()) {
                ProductAdmin pro = new ProductAdmin();
                pro.setId(rs.getInt(1));
                pro.setName(rs.getString(2));
                pro.setCode(rs.getString(3));
                pro.setMetatitle(rs.getString(4));
                pro.setDescription(rs.getString(5));
                pro.setImages(rs.getString(6));
                pro.setMoreimages(rs.getString(7));
                pro.setPrice(rs.getDouble(8));
                pro.setPromotionprice(rs.getDouble(9));
                pro.setIncludedvat(rs.getBoolean(10));
                pro.setQuantity(rs.getInt(11));
                pro.setCategoryid(rs.getInt(12));
                pro.setDetail(rs.getString(13));
                pro.setWarranty(rs.getInt(14));
                pro.setCreateddate(rs.getDate(15));
                pro.setStatus(rs.getBoolean(16));
                pro.setTophot(rs.getDate(17));
                pro.setViewcount(rs.getInt(18));

                arrProductAdmin.add(pro);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return arrProductAdmin;

    }

    @Override
    public int dataProductSearchTotalPage(int currentpage, int limit, String name) {
        int result = 0;
        Connection conn = null;
        CallableStatement cStmt = null;
        String sql = "{?=Call customPage(?,?,?)}";
        try {
            conn = MicrosoftDAOFactory.createConnection();
            cStmt = conn.prepareCall(sql);
            cStmt.registerOutParameter(1, Types.INTEGER);
            cStmt.setInt(2, currentpage);
            cStmt.setInt(3, limit);
            cStmt.setString(4, name);

            cStmt.execute();
            result = cStmt.getInt(1);

        } catch (SQLException ex) {
            Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (cStmt != null) {
                try {
                    cStmt.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MicrosoftProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        return result;
    }

}
