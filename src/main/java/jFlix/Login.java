/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jFlix;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Bryce
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    
    
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
        
           try {
               //Gets the username and password that is typed in for logging in.
               
               
               String user = request.getParameter("username");
               String password = request.getParameter("password");
               
               user = user.toLowerCase();               
             
               Connection conn;
               Statement stmt;
               boolean message = false;
               PrintWriter out = response.getWriter();
               
               
               conn = new DBControl().connectDB();
               
               //query from the database all information from the user table
               String query = "SELECT * FROM user";
               stmt = conn.createStatement();
               
               //loops through all the users and checks them
               //executes the query and saves it into a ResultSet
               try (ResultSet rs = stmt.executeQuery(query)) {
                   //loops through all the users and checks them
                   while (rs.next()) {                       
                       if (rs.getString("username").equals(user)) { //only enters if it finds the username
                           if (BCrypt.checkpw(password, rs.getString("password"))) { //enters if pswd equal
                               //sets the session for the user and then redirects to their collections
                               request.getSession().setAttribute("username", user);
                               request.getSession().setAttribute("displayname", rs.getString("displayname"));
                               request.getSession().setAttribute("id", rs.getInt("id"));
                               request.getRequestDispatcher("Collection").forward(request, response);
                               rs.close();
                               message = false;
                               break;
                           }
                           else {
                               request.setAttribute("message", "Password Incorrect");
                               message = true;
                               break;
                           }
                       }
                       else {
                           request.setAttribute("message", "User does not Exist");
                           message = true;
                       }
                   }
               }
               stmt.close();
               conn.close();
               
               if (message){
                   request.getRequestDispatcher("login.jsp").forward(request, response);
               }  } catch (SQLException ex) {
               Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
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
