/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.controller.httpservlet;

import com.shop.admin.controller.i.iProductAdmin;
import com.shop.admin.dto.ProductAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MacOS
 */
public class httpProductAdmin extends HttpServlet implements iProductAdmin {

    private static httpProductAdmin instance = null;

    protected httpProductAdmin() {

    }

    public static httpProductAdmin getInstance() {
        if (instance == null) {
            instance = new httpProductAdmin();
        }
        return instance;
    }

    @Override
    public void httpInsertProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        String action = request.getParameter("action");

        String name = request.getParameter("txtProName");
        String metatitle = request.getParameter("txtProMetaTitle");
        String description = request.getParameter("txtProDes");
        String images = request.getParameter("txtProImgUrl");
        String imagesmore = request.getParameter("txtProImgUrlmore");
        String price = request.getParameter("txtProPrice");
        String promotionprice = request.getParameter("txtProPromotionPrice");
        String quantity = request.getParameter("txtProQuantity");
        String categoryid = request.getParameter("txtProCategoryID");
        String detail = request.getParameter("txtProDetail");

        if (action.equals("add") && name != null && metatitle != null && description != null
                && images != null && imagesmore != null && price != null
                && promotionprice != null && quantity != null && categoryid != null && detail != null) {

            ProductAdmin product = ProductAdmin.getInstance();
            product.setName(name);
            product.setMetatitle(metatitle);
            product.setDescription(description);
            product.setImages(images);
            product.setMoreimages(imagesmore);
            product.setPrice(Double.parseDouble(price));
            product.setPromotionprice(Double.parseDouble(promotionprice));
            product.setQuantity(Integer.parseInt(quantity));
            product.setCategoryid(Integer.parseInt(categoryid));
            product.setDetail(detail);
            if (productDAO.insertProductAdmin(product)) {

                ArrayList<ProductAdmin> listProductAdmin = productDAO.dataProductAdmin();
                request.setAttribute("listProduct", listProductAdmin);
                RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp");
                rd.forward(request, response);
            }
        }
    }

    @Override
    public void httpUpdateProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        String action = request.getParameter("action");

        String id = request.getParameter("txtProID");
        String name = request.getParameter("txtProName");
        String metatitle = request.getParameter("txtProMetaTitle");
        String description = request.getParameter("txtProDes");
        String images = request.getParameter("txtProImgUrl");
        String imagesmore = request.getParameter("txtProImgUrlmore");
        String price = request.getParameter("txtProPrice");
        String promotionprice = request.getParameter("txtProPromotionPrice");
        String quantity = request.getParameter("txtProQuantity");
        String categoryid = request.getParameter("txtProCategoryID");
        String detail = request.getParameter("txtProDetail");
        
        boolean status = false;
        if (request.getParameter("txtProStatus") != null) {
            status = true;
        }

        if (action.equals("update") && name != null && metatitle != null && description != null
                && images != null && imagesmore != null && price != null
                && promotionprice != null && quantity != null && categoryid != null && detail != null) {

            ProductAdmin product = ProductAdmin.getInstance();
            product.setName(name);
            product.setMetatitle(metatitle);
            product.setDescription(description);
            product.setImages(images);
            product.setMoreimages(imagesmore);
            product.setPrice(Double.parseDouble(price));
            product.setPromotionprice(Double.parseDouble(promotionprice));
            product.setQuantity(Integer.parseInt(quantity));
            product.setCategoryid(Integer.parseInt(categoryid));
            product.setDetail(detail);
            product.setStatus(status);

            if (productDAO.updateProductAdmin(product, Integer.parseInt(id))) {

                ArrayList<ProductAdmin> listProductAdmin = productDAO.dataProductAdmin();
                request.setAttribute("listProduct", listProductAdmin);
                RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp");
                rd.forward(request, response);
            }
        }

    }

    @Override
    public void httpDeleteProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (action.equals("delete") && id != null) {
            if (productDAO.deleteProductAdmin(Integer.valueOf(id))) {

                ArrayList<ProductAdmin> listProductAdmin = productDAO.dataProductAdmin();
                request.setAttribute("listProduct", listProductAdmin);
                RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp");
                rd.forward(request, response);
            }
        }

    }

    @Override
    public void httpDataProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        String action = request.getParameter("action");
        if (action.equals("data")) {
            ArrayList<ProductAdmin> listProductAdmin = productDAO.dataProductAdmin();
            request.setAttribute("listProduct", listProductAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp");
            rd.forward(request, response);
        }
    }

}
