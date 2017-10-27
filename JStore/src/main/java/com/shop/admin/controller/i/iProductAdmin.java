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
public interface iProductAdmin {

    public void httpInsertProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpUpdateProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpDeleteProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpDataProductAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
