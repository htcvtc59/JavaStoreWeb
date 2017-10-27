/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.client.captcha;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.shop.admin.dto.AccountClientAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblAccountClientDAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
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
public class servletAccountStore extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.removeAttribute("username");
            session.removeAttribute("show");
            session.removeAttribute("nameg");
            session.removeAttribute("imageg");
            session.removeAttribute("namef");
            session.removeAttribute("imagef");

            request.getRequestDispatcher("trang_chu").forward(request, response);
        }

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
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        System.out.println(action);

        if (action.equals("form")) {

            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

            String user = request.getParameter("Username");
            String pass = request.getParameter("Password");

            boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

            if (verify && user != null && pass != null) {
                DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();
                AccountClientAdmin a = AccountClientAdmin.getInstance();
                a.setUsername(user);
                a.setPassword(pass);
                if (accountclientAdminDAO.loginAccountClient(a)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", user);
                    session.setAttribute("show", 1);

                    response.sendRedirect("trang_chu");
                } else {
                    response.sendRedirect("dang_nhap");
                }
            } else {
                response.sendRedirect("dang_nhap");
            }

        }

        if (action.equals("gg")) {

            Thread gg = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);

                        String id = data.get("id").getAsString();
                        String fullname = data.get("fullname").getAsString();
                        String givenname = data.get("givenname").getAsString();
                        String fimalyname = data.get("fimalyname").getAsString();
                        String imageurl = data.get("imageurl").getAsString();
                        String email = data.get("email").getAsString();
                        System.out.println(id + email + fullname + givenname + fimalyname + imageurl);
                        System.out.println("=============================================");

                        if (id != null) {
                            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                            tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();
                            AccountClientAdmin a = AccountClientAdmin.getInstance();
                            a.setRealname(fullname);
                            a.setIdaccount(id);
                            a.setEmail(email);
                            System.out.println(accountclientAdminDAO.insertAccountClient(a));

                            HttpSession session = request.getSession();
                            session.setAttribute("username", id);
                            session.setAttribute("show", 2);

                            session.setAttribute("nameg", fullname);
                            session.setAttribute("imageg", imageurl);

                            Map<String, Object> map = new HashMap<String, Object>();
                            map.put("status", true);
                            response.setContentType("application/json;charset=UTF-8");
                            response.getWriter().print(new Gson().toJson(map));
                        }
                    } catch (IOException ex) {
                        Logger.getLogger(servletAccountStore.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            });
            gg.run();

        }

        if (action.equals("fb")) {

            Thread fb = new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);

                        String idf = data.get("idf").getAsString();
                        String namef = data.get("namef").getAsString();
                        String emailf = data.get("emailf").getAsString();
                        String imagef = data.get("imagef").getAsString();
                        System.out.println(idf + namef + emailf + imagef);
                        if (idf != null) {
                            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
                            tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();
                            AccountClientAdmin a = AccountClientAdmin.getInstance();
                            a.setRealname(namef);
                            a.setIdaccount(idf);
                            a.setEmail(emailf);
                            System.out.println(accountclientAdminDAO.insertAccountClient(a));

                            HttpSession session = request.getSession();
                            session.setAttribute("username", idf);
                            session.setAttribute("show", 3);

                            session.setAttribute("namef", namef);
                            session.setAttribute("imagef", imagef);

                            Map<String, Object> map = new HashMap<String, Object>();
                            map.put("status", true);
                            response.setContentType("application/json;charset=UTF-8");
                            response.getWriter().print(new Gson().toJson(map));

                        }
                    } catch (IOException ex) {
                        Logger.getLogger(servletAccountStore.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            });
            fb.run();

        }

        if (action == null) {
            response.sendRedirect("dang_nhap");
        }

        if (action.equals("addclient")) {
            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
            tblAccountClientDAO accountclientAdminDAO = microsoftFactory.getAccountClientDAO();

            String realname = request.getParameter("txtcRealname");
            String user = request.getParameter("txtcUsername");
            String pass = request.getParameter("txtcPassword");
            String email = request.getParameter("txtcEmail");
            System.out.println(realname+user+pass+email);

            if (realname != null && user != null && pass != null && email != null) {
                AccountClientAdmin a = new AccountClientAdmin();
                a.setRealname(realname);
                a.setUsername(user);
                a.setPassword(pass);
                a.setEmail(email);

                switch (accountclientAdminDAO.insertAccountClient(a)) {
                    case 1:
                        request.setAttribute("status", "Đăng kí thành công");
                        RequestDispatcher rd = request.getRequestDispatcher("/dang_nhap");
                        rd.forward(request, response);

                        break;
                    case 2:
                        request.setAttribute("status", "Tên đăng nhập đã có người đăng kí");
                        RequestDispatcher rd1 = request.getRequestDispatcher("/dang_nhap");
                        rd1.forward(request, response);
                        break;
                    case 3:
                        request.setAttribute("status", "Email đã có người đăng kí");
                        RequestDispatcher rd2 = request.getRequestDispatcher("/dang_nhap");
                        rd2.forward(request, response);
                        break;

                    case -1:
                        request.setAttribute("status", "Email hoặc Tên đăng nhập đã có người đăng kí hoặc có lỗi gì đó");
                        RequestDispatcher rd3 = request.getRequestDispatcher("/dang_nhap");
                        rd3.forward(request, response);
                        break;
                    default:
                        RequestDispatcher rd4 = request.getRequestDispatcher("/dang_nhap");
                        rd4.forward(request, response);
                        break;
                }

            }
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
