/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jFlix;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Bryce
 */
@WebServlet(name = "Collection", urlPatterns = {"/Collection"})
public class Collection extends HttpServlet {

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

        Connection conn = new DBControl().connectDB();
        
        List<Map> ownedMovies = new ArrayList<>();
        List<String> allGenres = new ArrayList<>();
        try {
            Statement stmt = conn.createStatement();
            
            String query = "SELECT * FROM ownership WHERE userId=" 
                    + request.getSession().getAttribute("id") + " ORDER BY movieTitle";
            
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Map<String, Object> option = new HashMap<>();

                option.put("imdbID", rs.getString("imdbId"));
                option.put("Title", rs.getString("movieTitle"));
                option.put("Poster", rs.getString("moviePoster"));
                option.put("shared", rs.getBoolean("shared"));
                option.put("sharedName", rs.getString("sharedName"));
                String movieGenre = rs.getString("movieGenre");
                String[] genres = movieGenre.split(",");
                
                for (String genre : genres) {
                    genre = genre.trim();
                    if (allGenres.isEmpty()) {
                        allGenres.add(genre);
                    }
                    if (!(allGenres.contains(genre))) {
                        allGenres.add(genre);
                    }
                }
                ownedMovies.add(option);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Collection.class.getName()).log(Level.SEVERE, null, ex);
        }
        Collections.sort(allGenres);
        request.setAttribute("genres", allGenres);

        request.setAttribute("ownedMovies", ownedMovies);
        request.getRequestDispatcher("collection.jsp").forward(request, response);
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
