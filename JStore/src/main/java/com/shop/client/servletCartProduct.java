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
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author MacOS
 */
public class servletCartProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("actionCheckout") != null && request.getParameter("actionCheckout").equals("checkout")) {

            DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
            tblProductDAO productDAO = microsoftFactory.getProductDAO();
            for (int i = 1; i <= productDAO.dataProductAdmin().size(); i++) {
                if (request.getParameter("shipping_" + i) != null) {

                    String id_item = request.getParameter("shipping_" + i);
                    String quantity_item = request.getParameter("quantity_" + i);

                    HttpSession session = request.getSession();
                    Cart cart = (Cart) session.getAttribute("cart");
                    if (cart == null) {
                        cart = new Cart();
                    }
                    cart.addItem(id_item, Integer.parseInt(quantity_item));
                    session.setAttribute("cart", cart);
                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("thanh_toan");
                    rd.forward(request, response);
                }
            }

        }
        String action = null;
        if (request.getParameter("action") != null) {
            action = request.getParameter("action");

            switch (action) {
                case "delete":
                    String id = request.getParameter("id");
                    if (id != null) {
                        HttpSession session2 = request.getSession();
                        Cart cart2 = (Cart) session2.getAttribute("cart");
                        if (cart2 == null) {
                            cart2 = new Cart();
                        }
                        cart2.deleteItem(id);
                        session2.setAttribute("cart", cart2);

                        Map<String, Object> map = new HashMap<String, Object>();
                        boolean status = true;
                        map.put("status", status);
                        Hashtable content2 = cart2.getContent();
                        Enumeration e2 = content2.keys();
                        Double total2 = 0.0;

                        while (e2.hasMoreElements()) {
                            String id2 = e2.nextElement().toString();
                            CartChild cc2 = (CartChild) content2.get(id2);
                            total2 += cc2.getProduct().getPromotionprice()* cc2.getQuantity();
                        }

                        map.put("total2", total2);
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().print(new Gson().toJson(map));

                    }

                    break;

                default:
                    break;
            }

        } else {

            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            try {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line).append('\n');
                }
            } finally {
                reader.close();
            }

            ArrayList<CartChild> arr = new ArrayList<>();

            JSONArray arrjson = new JSONArray(sb.toString());
            for (Object t : arrjson) {
                JSONObject objjson = new JSONObject(t.toString());
                CartChild cc = new CartChild();
                ProductAdmin b = new ProductAdmin();
                cc.setQuantity(Integer.parseInt(objjson.get("quantity").toString()));
                b.setId(Integer.parseInt(objjson.get("id").toString()));
                cc.setProduct(b);
                arr.add(cc);
                action = objjson.get("action").toString();
            }

            System.out.println(sb.toString());

            if (action.equals("update")) {
                HttpSession sessionu = request.getSession();
                Cart cartu = (Cart) sessionu.getAttribute("cart");
                if (cartu == null) {
                    cartu = new Cart();
                }
                for (CartChild c : arr) {
                    cartu.updateItem(String.valueOf(c.getProduct().getId()), c.getQuantity());
                }
                sessionu.setAttribute("cart", cartu);

                Map<String, Object> map = new HashMap<String, Object>();
                boolean status = true;
                map.put("status", status);
                map.put("id", arr.get(0).getProduct().getId());

                Hashtable content2 = cartu.getContent();
                Enumeration e2 = content2.keys();
                Double total2 = 0.0;

                while (e2.hasMoreElements()) {
                    String id2 = e2.nextElement().toString();
                    CartChild cc2 = (CartChild) content2.get(id2);
                    map.put("price2" + id2, cc2.getProduct().getPromotionprice() * cc2.getQuantity());
                    total2 += cc2.getProduct().getPromotionprice() * cc2.getQuantity();
                }

                map.put("total2", total2);

                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print(new Gson().toJson(map));
                System.out.println(new Gson().toJson(map));

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
