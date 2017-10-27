/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.controller.httpservlet;

import com.shop.admin.controller.i.iAccountClient;
import com.shop.admin.dto.AccountClientAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblAccountClientDAO;
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
public class httpAccountClientAdmin extends HttpServlet implements iAccountClient {

    private static httpAccountClientAdmin instance = null;

    protected httpAccountClientAdmin() {

    }

    public static httpAccountClientAdmin getInstance() {
        if (instance == null) {
            instance = new httpAccountClientAdmin();
        }
        return instance;
    }

    @Override
    public void httpUpdateAccountClientAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountClientDAO accountAdminDAO = microsoftFactory.getAccountClientDAO();

        String action = request.getParameter("action");
        String id = request.getParameter("aaidu");
        String note = request.getParameter("aanoteu");
        boolean status = false;
        if (request.getParameter("aastatusu") != null) {
            status = true;
        }

        if (action.equals("update") && id != null && note != null) {
            AccountClientAdmin a = AccountClientAdmin.getInstance();
            a.setNote(note);
            a.setStatus(status);
            if (accountAdminDAO.updateAccountClient(a, Integer.valueOf(id))) {
                response.sendRedirect("tk_nguoi_dung/data");
            }
        }
    }

    @Override
    public void httpDeleteAccountClientAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (action.equals("delete") && id != null) {
            if (accountclientAdminDAO.deleteAccountClient(Integer.valueOf(id))) {
                response.sendRedirect("tk_nguoi_dung/data");
            }
        }
    }

    @Override
    public void httpDataAccountClientAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();
        String action = request.getParameter("action");
        if (action.equals("data")) {
            ArrayList<AccountClientAdmin> listAccountClientAdmin = accountclientAdminDAO.dataAccountClient();
            request.setAttribute("listAcoutnClient", listAccountClientAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/tk_nguoi_dung");
            rd.forward(request, response);
        }

    }

}
