/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.client;

import com.google.gson.Gson;
import com.shop.admin.dto.ProductAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MacOS
 */
public class servletSearchProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String currentpage = request.getParameter("currentpage");
        if (keyword != null && currentpage != null) {
            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
            tblProductDAO productDAO = microsoftFactory.getProductDAO();
            ArrayList<ProductAdmin> productAdminss = productDAO.dataidProductAdminSearch(Integer.parseInt(currentpage), 7, keyword);
            int totalpage = productDAO.dataProductSearchTotalPage(Integer.parseInt(currentpage), 7, keyword);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("listpro", productAdminss);
            map.put("newTotalPages",totalpage);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(new Gson().toJson(map));

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
