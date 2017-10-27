/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.controller.httpservlet;

import com.shop.admin.controller.i.iCategoryAdmin;
import com.shop.admin.dto.CategoryAdmin;
import com.shop.admin.dto.ProductAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblCategoryDAO;
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
public class httpCategoryAdmin extends HttpServlet implements iCategoryAdmin {

    private static httpCategoryAdmin instance = null;

    protected httpCategoryAdmin() {

    }

    public static httpCategoryAdmin getInstance() {
        if (instance == null) {
            instance = new httpCategoryAdmin();
        }
        return instance;
    }

    @Override
    public void httpInsertCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblCategoryDAO categoryDAO = microsoftFactory.getCategoryDAO();
        String action = request.getParameter("action");

        String name = request.getParameter("txtName");
        String metatitle = request.getParameter("txtMetaTitle");
        String parentid = request.getParameter("txtParentID");
        String displayorder = request.getParameter("txtDisplayOrder");
        String seotile = request.getParameter("txtSeoTitle");

        if (action.equals("add") && name != null && metatitle != null && parentid != null && displayorder != null && seotile != null) {
            CategoryAdmin category = CategoryAdmin.getInstance();
            category.setName(name);
            category.setMetatitle(metatitle);
            category.setParentid(Integer.parseInt(parentid));
            category.setDisplayorder(Integer.parseInt(displayorder));
            category.setSeotitle(seotile);

            if (categoryDAO.insertCategoryAdmin(category)) {
                response.sendRedirect("the_loai/data");
            }
        } else {
            response.sendRedirect("the_loai/data");
        }

    }

    @Override
    public void httpUpdateCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblCategoryDAO categoryDAO = microsoftFactory.getCategoryDAO();

        String action = request.getParameter("action");
        String id = request.getParameter("txtIdU");
        String name = request.getParameter("txtNameU");
        String metatitle = request.getParameter("txtMetaTitleU");
        String parentid = request.getParameter("txtParentIDU");
        String displayorder = request.getParameter("txtDisplayOrderU");
        String seotitle = request.getParameter("txtSeoTitleU");
        boolean status = false;
        if (request.getParameter("txtStatusU") != null) {
            status = true;
        }

        if (action.equals("update") && id != null && name != null && metatitle != null
                && parentid != null && displayorder != null && seotitle != null) {
            CategoryAdmin cate = CategoryAdmin.getInstance();
            cate.setName(name);
            cate.setMetatitle(metatitle);
            cate.setParentid(Integer.valueOf(parentid));
            cate.setDisplayorder(Integer.valueOf(displayorder));
            cate.setSeotitle(seotitle);
            cate.setStatus(status);

            if (categoryDAO.updateCategoryAdmin(cate, Integer.valueOf(id))) {

            }
        }
    }

    @Override
    public void httpDeleteCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblCategoryDAO categoryDAO = microsoftFactory.getCategoryDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (action.equals("delete") && id != null) {
            if (categoryDAO.deleteCategoryAdmin(Integer.valueOf(id))) {
                response.sendRedirect("the_loai/data");
            }
        }

    }

    @Override
    public void httpDataCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblCategoryDAO categoryDAO = microsoftFactory.getCategoryDAO();
        String action = request.getParameter("action");
        if (action.equals("data")) {
            ArrayList<CategoryAdmin> listAccountAdmin = categoryDAO.dataCategoryAdmin();
            request.setAttribute("listCategory", listAccountAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/the_loai");
            rd.forward(request, response);
        }

        if (action.equals("cdata")) {
            ArrayList<CategoryAdmin> listAccountAdmin = categoryDAO.dataCategoryAdmin();
            request.setAttribute("listCategoryPro", listAccountAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp_create");
            rd.forward(request, response);
        }

        if (action.equals("udata")) {
            String id = request.getParameter("id");
            if (id != null) {
                tblProductDAO productDAO = microsoftFactory.getProductDAO();
                ArrayList<ProductAdmin> listProductAdmin = productDAO.dataidProductAdmin(Integer.parseInt(id));
                ArrayList<CategoryAdmin> listAccountAdmin = categoryDAO.dataCategoryAdmin();
                request.setAttribute("listProduct", listProductAdmin);
                request.setAttribute("listCategoryPro", listAccountAdmin);
                RequestDispatcher rd = request.getRequestDispatcher("/admin/san_pham_sp_update");
                rd.forward(request, response);
            }
        }

    }

}
