/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.shop.admin.controller.i;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MacOS
 */
public interface iAccountAdmin {
    public void httpInsertAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    public void httpUpdateAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    public void httpDeleteAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    public void httpDataAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    public void httpLoginAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
    public void httpLogoutAccountAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
