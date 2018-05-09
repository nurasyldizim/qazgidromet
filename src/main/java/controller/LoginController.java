/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDao;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author user-22112
 */
public class LoginController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        EncDecPassword encDec = null;
        try {
            encDec = new EncDecPassword();
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
        String email = request.getParameter("email");
        String password = null;
        try {
            password = encDec.encrypt(request.getParameter("password"));
        } catch (NoSuchPaddingException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidAlgorithmParameterException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvalidKeyException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (BadPaddingException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalBlockSizeException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);

        UserDao userDao = new UserDao();
        String userValidate = userDao.authenticateUser(user);
        if (userValidate.equals("Admin")) {
            HttpSession session = request.getSession();
            session.setAttribute("emailSession", email);
            session.setAttribute("adminSession", "admin");
            response.sendRedirect("jsp/admin.jsp");
        } else if (userValidate.equals("User")) {
            HttpSession session = request.getSession();
            session.setAttribute("emailSession", email);
            session.setAttribute("adminSession", "user");
            response.sendRedirect("jsp/index.jsp");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("errMessage", userValidate);
            response.sendRedirect("jsp/login.jsp");
        }

    }
}
