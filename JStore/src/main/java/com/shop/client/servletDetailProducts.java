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
import com.shop.client.encodedecode.EncryptionDecryption;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MacOS
 */
public class servletDetailProducts extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gg = request.getParameter("gg");
        EncryptionDecryption ed = null;
        try {
            ed = new EncryptionDecryption();
        } catch (Exception ex) {
            Logger.getLogger(servletDetailProducts.class.getName()).log(Level.SEVERE, null, ex);
        }
        String id = ed.decrypt(gg);
//        System.out.println(id);
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();

        ArrayList<ProductAdmin> productAdmins = productDAO.dataidProductAdminCate(Integer.parseInt(id));

        if (Integer.parseInt(id) == 1 && id != null) {
            request.setAttribute("listproductAdmins", productAdmins);
            RequestDispatcher rd = request.getRequestDispatcher("san_pham");
            rd.forward(request, response);
        }

        if (Integer.parseInt(id) == 13 && id != null) {
            request.setAttribute("listproductAdmins", productAdmins);
            RequestDispatcher rd = request.getRequestDispatcher("san_pham");
            rd.forward(request, response);
        }

        if (Integer.parseInt(id) == 9 && id != null) {
            response.sendRedirect("drinks.jsp");
        }

    }

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

        if (request.getParameter("key") != null) {
            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
            tblProductDAO productDAO = microsoftFactory.getProductDAO();
            String idd = request.getParameter("key");
            ArrayList<ProductAdmin> productAdminss = productDAO.dataidProductAdminCate(Integer.parseInt(idd));

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print(new Gson().toJson(productAdminss));

        }
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
