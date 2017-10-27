/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.client;

import com.shop.admin.dto.ProductAdmin;
import com.shop.client.mail.Mailer;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MacOS
 */
public class servletMail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

        String name = request.getParameter("Name");
        String email = request.getParameter("Email");
        String phone = request.getParameter("Telephone");
        String subject = request.getParameter("Subject");
        String msg = request.getParameter("Message");

        if (name != null && email != null && phone != null && subject != null && msg != null) {
            ServletContext servletContext = this.getServletContext();
            String emailuser = servletContext.getInitParameter("emailuser");
            String emailpass = servletContext.getInitParameter("emailpass");

            String content = Mailer.HtmlContent(name, email, phone, subject, msg);

            Mailer.send(emailuser, emailpass, "htcvtc59@gmail.com", "Phản hồi của khách hàng về dịch vụ", "hihi", content);

            response.sendRedirect("khguimail");
        }

        if (request.getParameter("txtname") != null) {
            String cartname = request.getParameter("txtname");
            String cartphone = request.getParameter("txtmobile");
            String cartemail = request.getParameter("txtemail");
            String cartcity = request.getParameter("txtcity");

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            Hashtable content = cart.getContent();
            Enumeration e = content.keys();

            String product = "";
            Double total = 0.0;
            while (e.hasMoreElements()) {
                String id = e.nextElement().toString();
                CartChild cc = (CartChild) content.get(id);
                product += "<div><img src=" + cc.getProduct().getImages().toString() + " height='50' width='50' alt='...' />";
                product += "&nbsp;&nbsp;" + cc.getProduct().getName().toString();
                product += "&nbsp;&nbsp;" + cc.getQuantity();
                product += "&nbsp;&nbsp;" + cc.getQuantity() * cc.getProduct().getPrice();
                product += "</div></br>";
                total += cc.getQuantity() * cc.getProduct().getPrice();
            }

            product += "<div>Total:" + total + "</div>";
            
            
            System.out.println(product);
            

            ServletContext servletContext = this.getServletContext();
            String emailuser = servletContext.getInitParameter("emailuser");
            String emailpass = servletContext.getInitParameter("emailpass");

            String contentcart = Mailer.HtmlContentCart(cartname, cartemail, cartphone,cartcity, product);
            Mailer.send(emailuser, emailpass, "htcvtc59@gmail.com", "Đơn hàng cần vận chuyển", "Đơn hàng cần vận chuyển của khách hàng"+cartname, contentcart);
            
            session.removeAttribute("cart");
            request.setAttribute("cartmessage","Đơn hàng được đặt thành công!");
            RequestDispatcher rd = request.getRequestDispatcher("thanh_toan");
            rd.forward(request, response);
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
