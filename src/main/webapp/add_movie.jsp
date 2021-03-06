<%-- 
    Document   : add_movie
    Created on : Mar 10, 2015, 3:16:01 PM
    Author     : Bryce
--%>
<%@page import="java.io.IOException"%>
<%
if(null == session.getAttribute("username")){  
  response.sendRedirect("index.jsp");
}
request.getSession().setAttribute("page", "add_movie");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, maximum-scale=1">
        <title>Add Movie</title>
        <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href='css/jFlix.css' type='text/css' rel='stylesheet'>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    </head>
    <body>
        <header>
            <%@include file="/modules/nav.html"%>
        </header>
        <div class="container">
            <div class="row">
                <div class='text-center'>
                    <h1 class='page-title'>Search & Add</h1>
                </div>
                <div class="col-md-4 col-md-offset-4">
                    <form class='movie-search' action="Search" method="POST">
                        <div class="control-group form-group">
                            <div class="input-group">
                                <input type="text" autofocus class="form-control" name="search" id="search" placeholder="e.g. Movie Title">
                                <span class="input-group-btn">
                                  <button class="btn btn-primary" type="submit">Search</button>
                                </span> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <c:if test="${search == 'No Results'}">
                        <h3 class='text-center'>No Results Found</h3>
                    </c:if>
                    <c:if test="${search != 'No Results'}">
                        <c:forEach items="${search}" var="movie">
                            <div class="movieContainerOuter">
                                <div class='movieContainerInner'>
                                    <a href='SingleMovie?imdbID=${movie.imdbID}&collection=false'>
                                        <c:if test="${movie.url == 'http://image.tmdb.org/t/p/w185null'}">
                                            <img class='movieImg' src='http://www.vernellbrownjr.com/SorryNoImageAvailable.jpg' alt='${movie.Title}' title='${movie.Title}'/>

                                        </c:if>
                                        <c:if test="${movie.url != 'http://image.tmdb.org/t/p/w185null'}">
                                            <img class='movieImg' src='${movie.url}' alt='${movie.Title}' title='${movie.Title}'/>
                                        </c:if>
                                    </a>
                                </div>
                                <p class="movieTitle">${movie.Title}</p>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${additionComplete}">
                        <div class='alert alert-success' role='alert'>Movie added to collection.</div>
                    </c:if>
                    <c:if test="${display}">
                        <h2>Today's Popular Movies</h2>
                        <c:forEach items="${populars}" var="movie">
                            <div class="movieContainerOuter">
                                <div class='movieContainerInner'>
                                    <a href='PopularMovie?id=${movie.get("id")}'>
                                        <img class='movieImg' src='http://image.tmdb.org/t/p/w185${movie.get("poster_path")}' alt='${movie.get("title")}' title='${movie.get("title")}'/>
                                    </a>
                                </div>
                                <p class="movieTitle">${movie.get("title")}</p>
                            </div>
                        </c:forEach>
                    </c:if>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@include file="/modules/footer.html"%>
        </footer>
    </body>
</html>
