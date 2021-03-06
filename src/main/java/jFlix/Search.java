/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jFlix;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author Bryce
 */
@WebServlet(name = "Search", urlPatterns = {"/Search"})
public class Search extends HttpServlet {

    
    private List<Map> movies;
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

        String search = request.getParameter("search");
        search = search.trim();
        search = search.replace(" ", "+");
        
        //GET MOVIE LIST
        try {
            URL url = new URL("http://www.omdbapi.com/?s=" + search + "&r=json");       
            ObjectMapper mapper = new ObjectMapper();      
            Map<String, Object> map = mapper.readValue(url, Map.class);
            List list = (List)map.get("Search");

            //GET MOVIE ID's
            List<Object> imdbIDs = new ArrayList<>();
            for (Object item : list)
            {
                  Map<String, Object> innerMap = (Map<String, Object>)item;
                  for (String key : innerMap.keySet())
                  {
                      if (key.equals("imdbID")){
                          imdbIDs.add(innerMap.get(key));
                      }
                  }
            }

            //GET MOVIE POSTER LINKS
            movies = new ArrayList<>();
            for (Object item2: imdbIDs){
                URL url2 = new URL("http://api.themoviedb.org/3/find/" + item2 
                        + "?api_key=ee5b93a565655155882df541850c7364&external_source=imdb_id");
                ObjectMapper mapper2 = new ObjectMapper();
                Map<String, Object> map2 = mapper2.readValue(url2, Map.class);
                List<Object> movieResults = (List) map2.get("movie_results");
                
                for (Object temp : movieResults) {
                    Map<String, String> singleMovie = (Map) temp;
                    Map<String, String> toAdd = new HashMap<>();
                    String poster= "http://image.tmdb.org/t/p/w185";
                    poster += singleMovie.get("poster_path");
                    String title = singleMovie.get("title");
                    toAdd.put("url", poster);
                    toAdd.put("Title", title);
                    String imdbID = (String) item2;
                    toAdd.put("imdbID", imdbID);
                    movies.add(toAdd);
                }

                
                request.setAttribute("search", movies);
        }     
        } catch (Exception e) {
            request.setAttribute("search", "No Results");
        }
        request.getRequestDispatcher("add_movie.jsp").forward(request, response);
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
