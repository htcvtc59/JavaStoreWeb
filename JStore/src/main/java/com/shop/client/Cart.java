/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.client;

import com.shop.admin.dto.ProductAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblProductDAO;
import java.util.Enumeration;
import java.util.Hashtable;

/**
 *
 * @author MacOS
 */
public class Cart {
    
    private Hashtable content;
    
    public Hashtable getContent() {
        return content;
    }
    
    public void setContent(Hashtable content) {
        this.content = content;
    }
    
    public Cart() {
        content = new Hashtable();
    }
    
    public void addItem(String id, int quantity) {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        
        ProductAdmin pa = productDAO.dataidProductAdmin(Integer.parseInt(id)).get(0);
        
        if (content == null) {
            content = new Hashtable();
            CartChild cc = new CartChild(pa, quantity);
            content.put(id, cc);
        } else {
            if (!content.containsKey(id)) {
                CartChild cc = new CartChild(pa, quantity);
                content.put(id, cc);
            } else {
                Enumeration e = content.keys();
                while (e.hasMoreElements()) {
                    String keysid = (String) e.nextElement();
                    CartChild cc = (CartChild) content.get(keysid);
                    cc.setQuantity(cc.getQuantity() + quantity);
                }
                
            }
        }
        
    }
    
    public void deleteItem(String id) {
        Enumeration e = content.keys();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            if (key.equals(id)) {
                content.remove(key);
            }
        }
    }
    
    public void updateItem(String id, int quantity) {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblProductDAO productDAO = microsoftFactory.getProductDAO();
        ProductAdmin pa = productDAO.dataidProductAdmin(Integer.parseInt(id)).get(0);
        Enumeration e = content.keys();
        while (e.hasMoreElements()) {
            String key = (String) e.nextElement();
            if (key.equals(id)) {
                CartChild cc = (CartChild) content.get(key);
                cc.setQuantity(quantity);
            }
        }
        
    }
    
}
