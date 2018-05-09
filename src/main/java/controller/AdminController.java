/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDao;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;

/**
 *
 * @author user-22112
 */
public class AdminController extends HttpServlet {

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
            throws ServletException, IOException, UnsupportedEncodingException, NoSuchPaddingException, NoSuchAlgorithmException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        EncDecPassword encDec = new EncDecPassword();
        String action = request.getParameter("ACTION");
        try {
            if (action.equals("Добавить")) {
                String firstName = request.getParameter("firstName");
                String secondName = request.getParameter("secondName");
                String workName = request.getParameter("workName");
                String email = request.getParameter("email");
                String password = encDec.encrypt(request.getParameter("password"));
                boolean isAdmin = false;
                if (request.getParameter("isAdmin") == null) {
                    isAdmin = false;
                } else if (request.getParameter("isAdmin").equals("on")) {
                    isAdmin = true;
                }
                String isAdded = null;
                try {
                    UserDao u = new UserDao();
                    isAdded = u.addUser(firstName, secondName, workName, email, password, isAdmin);
                    if (isAdded == null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("errMessage", "Пользователь не довавлен. Праверьте данные");
                        response.sendRedirect("jsp/admin.jsp");
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("errMessage", "Пользователь добавлен.");
                        response.sendRedirect("jsp/admin.jsp");
                    }
                } catch (HibernateException e) {
                    System.err.println(e);
                    response.sendRedirect("jsp/admin.jsp");
                }
            } else if (action.equals("Удалить")) {
                int id = Integer.parseInt(request.getParameter("id"));
                UserDao u = new UserDao();
                String isDeleted = u.deleteUser(id);
                if (isDeleted == null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("errMessage", "Пользователь не удален. Попробуйте еще раз");
                    response.sendRedirect("jsp/admin.jsp");
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("errMessage", "Пользователь удален.");
                    response.sendRedirect("jsp/admin.jsp");
                }

            } else if (action.equals("Изменить")) {
                String firstName = request.getParameter("firstName");
                String secondName = request.getParameter("secondName");
                String workName = request.getParameter("workName");
                String email = request.getParameter("email");
                String password = encDec.encrypt(request.getParameter("password"));
                Integer id = Integer.parseInt(request.getParameter("id"));
                boolean isAdmin = false;
                if (request.getParameter("isAdmin") == null) {
                    isAdmin = false;
                } else if (request.getParameter("isAdmin").equals("on")) {
                    isAdmin = true;
                }
                String isUpdated = null;
                try {
                    UserDao u = new UserDao();
                    isUpdated = u.updateUser(id, firstName, secondName, workName, email, password, isAdmin);
                    if (isUpdated == null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("errMessage", "Пользователь не изменен. Проверьте данные");
                        response.sendRedirect("jsp/admin.jsp");
                    } else {
                        HttpSession session = request.getSession();
                        session.setAttribute("errMessage", "Пользователь изменен.");
                        response.sendRedirect("jsp/admin.jsp");
                    }
                } catch (HibernateException e) {
                    System.err.println(e);
                    response.sendRedirect("jsp/admin.jsp");
                }
            }
        } catch (Exception e) {
            System.out.println(e);
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
            throws ServletException, IOException, UnsupportedEncodingException {
        try {
            processRequest(request, response);
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
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
