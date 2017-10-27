/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.client;

import com.shop.client.TransactionAPI.payment.baokim.BaoKimPayment;
import com.stripe.Stripe;
import com.stripe.exception.APIConnectionException;
import com.stripe.exception.APIException;
import com.stripe.exception.AuthenticationException;
import com.stripe.exception.CardException;
import com.stripe.exception.InvalidRequestException;
import com.stripe.model.Charge;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
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
public class servletOtherPayment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, AuthenticationException, InvalidRequestException, APIConnectionException, CardException, APIException {
        String action = request.getParameter("action");
        if (action.equals("paypal")) {
            HttpSession session = request.getSession();
            session.removeAttribute("cart");
            request.setAttribute("cartmessage", "Thanh toán thành công!");
            RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
            rd.forward(request, response);
        }

        if (action.equals("paybkim")) {

            BaoKimPayment bkpay = new BaoKimPayment();

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            Hashtable content = cart.getContent();
            Enumeration e = content.keys();
            Double total = 0.0;
            String namesp = "";
            String description = "";

            while (e.hasMoreElements()) {
                String id = e.nextElement().toString();
                CartChild cc = (CartChild) content.get(id);
                namesp += cc.getProduct().getId() + "/";
                total += cc.getProduct().getPromotionprice() * cc.getQuantity();
                description += "MaSP-" + cc.getProduct().getId() + "-"
                        + "Gia-" + cc.getProduct().getPromotionprice() + "-" + "SoLuong-"
                        + cc.getQuantity() + "/";
            }
            System.out.println(namesp);
            String createRequestUrl = bkpay.createRequestUrl(namesp, "dev.baokim@bk.vn", String.valueOf(total * 1000), "1000", "1000", description, "http://localhost:8084/JStore/dichvuthanhtoankhac?action=bkpay", "http://localhost:8084/JStore/errorpay.jsp", "http://localhost:8084/JStore/");
            System.out.println(createRequestUrl);
            response.sendRedirect(createRequestUrl);

        }

        if (action.equals("bkpay")) {
            HttpSession session = request.getSession();
            session.removeAttribute("cart");
            request.setAttribute("cartmessage", "Thanh toán thành công!");
            RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
            rd.forward(request, response);
        }

        if (action.equals("stripe")) {

            try {
                Stripe.apiKey = "sk_test_8hzWYGE96PtV4vnZNFImFFzM";

                String token = request.getParameter("stripeToken");

                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                Hashtable content = cart.getContent();
                Enumeration e = content.keys();
                Double price = 0.0;
                while (e.hasMoreElements()) {
                    String id = e.nextElement().toString();
                    CartChild cc = (CartChild) content.get(id);
                    price += cc.getProduct().getPromotionprice() * cc.getQuantity();
                }
                int priceint = (int) Math.round(price);

                Map<String, Object> params = new HashMap<String, Object>();
                params.put("amount", priceint*100);
                params.put("currency", "usd");
                params.put("description", "Store");
                params.put("source", token);

                Charge charge = Charge.create(params);

                System.out.println(charge + "-----------");

                if (charge.getStatus().equals("succeeded")) {
                    HttpSession sessionc = request.getSession();
                    sessionc.removeAttribute("cart");
                    request.setAttribute("cartmessage", "Thanh toán thành công!");
                    RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
                    rd.forward(request, response);
                }

            } catch (AuthenticationException ex) {
                Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvalidRequestException ex) {
                Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
            } catch (APIConnectionException ex) {
                Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
            } catch (CardException ex) {
                System.out.println(ex.getParam() + "==============");
                System.out.println(ex.getCharge() + "+++++++++++++++++");
                Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
            } catch (APIException ex) {
                Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
            }

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
        try {
            processRequest(request, response);
        } catch (AuthenticationException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidRequestException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (APIConnectionException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (CardException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (APIException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (AuthenticationException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidRequestException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (APIConnectionException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (CardException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (APIException ex) {
            Logger.getLogger(servletOtherPayment.class.getName()).log(Level.SEVERE, null, ex);
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
