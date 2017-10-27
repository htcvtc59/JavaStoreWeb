package com.shop.admin.controller.httpservlet;

import com.shop.admin.controller.i.iSlideAdmin;
import com.shop.admin.dto.SlideAdmin;
import com.shop.admin.iconnectdb.DAOFactory;
import com.shop.admin.iconnectdb.idao.tblSlideDAO;
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
public class httpSlideAdmin extends HttpServlet implements iSlideAdmin {

    private static httpSlideAdmin instance = null;

    protected httpSlideAdmin() {

    }

    public static httpSlideAdmin getInstance() {
        if (instance == null) {
            instance = new httpSlideAdmin();
        }
        return instance;
    }

    @Override
    public void httpInsertSlideAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblSlideDAO slideDAO = microsoftFactory.getSlideDAO();
        String action = request.getParameter("action");

        String image = request.getParameter("txtSlideImages");
        String link = request.getParameter("txtSlideLink");
        String description = request.getParameter("txtSlideDescription");

        if (action.equals("add") && image != null && link != null && description != null) {
            SlideAdmin slide = SlideAdmin.getInstance();

            slide.setImage(image);
            slide.setLink(link);
            slide.setDescription(description);

            if (slideDAO.insertSlideAdmin(slide)) {
                
                response.sendRedirect("anh_show/data");
            }

        } else {

            response.sendRedirect("anh_show/data");
        }
    }

    @Override
    public void httpUpdateSlideAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblSlideDAO slideDAO = microsoftFactory.getSlideDAO();

        String action = request.getParameter("action");
        String id = request.getParameter("txtSlideIdU");
        String image = request.getParameter("txtSlideImageU");
        String disorder = request.getParameter("txtSlideDisplayOrderU");
        String link = request.getParameter("txtSlideLinkU");
        String des = request.getParameter("txtSlideDescriptionU");
        
        boolean status = false;
        if (request.getParameter("txtSlideStatusU") != null) {
            status = true;
        }

        if (action.equals("update") && id != null && image != null && disorder != null
                && link != null && des != null) {
            SlideAdmin slide = SlideAdmin.getInstance();
            
            slide.setImage(image);
            slide.setDisplayorder(Integer.parseInt(disorder));
            slide.setLink(link);
            slide.setDescription(des);
            slide.setStatus(status);

            if (slideDAO.updateSlideAdmin(slide, Integer.valueOf(id))) {

            }
        }
    }

    @Override
    public void httpDeleteSlideAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblSlideDAO slideDAO = microsoftFactory.getSlideDAO();
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (action.equals("delete") && id != null) {
            if (slideDAO.deleteSlideAdmin(Integer.valueOf(id))) {
                response.sendRedirect("anh_show/data");
            }
        }
    }

    @Override
    public void httpDataSlideAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOFactory microsoftFactory = DAOFactory.getDAOFactory(DAOFactory.Microsoft);
        tblSlideDAO slideDAO = microsoftFactory.getSlideDAO();
        String action = request.getParameter("action");
        if (action.equals("data")) {
            ArrayList<SlideAdmin> listSlideAdmin = slideDAO.dataSlideAdmin();
            request.setAttribute("listSlide", listSlideAdmin);
            RequestDispatcher rd = request.getRequestDispatcher("/admin/anh_show");
            rd.forward(request, response);
        }
    }

}
