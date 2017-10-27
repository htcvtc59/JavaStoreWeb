
package com.shop.admin.controller.i;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface iCategoryAdmin {

    public void httpInsertCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpUpdateCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpDeleteCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public void httpDataCategoryAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

}
