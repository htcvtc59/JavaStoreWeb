/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.controller.httpservlet;

import com.shop.admin.controller.i.iAccountAdmin;
import com.shop.admin.dto.AccountAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblAccountAdminDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MacOS
 */
public class httpAccountAdmin extends HttpServlet implements iAccountAdmin {

    private static httpAccountAdmin instance = null;

    protected httpAccountAdmin() {

    }

    public static httpAccountAdmin getInstance() {
        if (instance == null) {
            instance = new httpAccountAdmin();
        }
        return instance;
    }

    @Override
    public void httpInsertAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountAdminDAO accountAdminDAO = microsoftFactory.getAccountAdminDAO();
        String action = request.getParameter("action");
        String username = request.getParameter("txtuser");
        String password = request.getParameter("txtpass");

        if (action.equals("add") && username != null && password != null) {
            AccountAdmin a = AccountAdmin.getInstance();
            a.setUsername(username);
            a.setPassword(password);
            if (accountAdminDAO.insertAccountAdmin(a)) {
                response.sendRedirect("tai_khoan/data");
            }
        } else {
            response.sendRedirect("tai_khoan/data");
        }
    }

    @Override
    public void httpUpdateAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountAdminDAO accountAdminDAO = microsoftFactory.getAccountAdminDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("aaidu");
        String pass = request.getParameter("aapassu");
        String note = request.getParameter("aanoteu");
        boolean status = false;
        if (request.getParameter("aastatusu") != null) {
            status = true;
        }

        if (action.equals("update") && id != null && pass != null && note != null) {
            AccountAdmin a = AccountAdmin.getInstance();
            a.setPassword(pass);
            a.setNote(note);
            a.setStatus(status);
            if (accountAdminDAO.updateAccountAdmin(a, Integer.valueOf(id))) {

            }
        }

    }

    @Override
    public void httpDeleteAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountAdminDAO accountAdminDAO = microsoftFactory.getAccountAdminDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (action.equals("delete") && id != null) {
            if (accountAdminDAO.deleteAccountAdmin(Integer.valueOf(id))) {
                response.sendRedirect("tai_khoan/data");
            }
        }
    }

    @Override
    public void httpDataAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountAdminDAO accountAdminDAO = microsoftFactory.getAccountAdminDAO();
        String action = request.getParameter("action");
        if (action.equals("data")) {
            ArrayList<AccountAdmin> listAccountAdmin = accountAdminDAO.dataAccountAdmin();
            request.setAttribute("listAA", listAccountAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/tai_khoan");
            rd.forward(request, response);
        }

    }

    @Override
    public void httpLoginAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblAccountAdminDAO accountAdminDAO = microsoftFactory.getAccountAdminDAO();
        String username = request.getParameter("qtusername");
        String password = request.getParameter("qtpassword");

        if (username != null && password != null) {
            AccountAdmin a = AccountAdmin.getInstance();
            a.setUsername(username);
            a.setPassword(password);
            if (accountAdminDAO.loginAccountAdmin(a)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        }

    }

    @Override
    public void httpLogoutAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("Logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("username");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
