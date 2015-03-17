<%-- 
    Document   : add_movie
    Created on : Mar 10, 2015, 3:16:01 PM
    Author     : Bryce
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Movie</title>
        <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    </head>
    <body>
        <header>
            <%@include file="/modules/nav.html"%>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1 style="margin-top: 0px;">Search Movies / Add to Your Collection</h1>
                </div>
                <form action="Search" method="POST">
                    <div class="control-group form-group col-md-4">
                        <div class="input-group">
                            <input type="text" autofocus class="form-control" name="search" id="search" placeholder="e.g. Movie Title">
                            <span class="input-group-btn">
                              <button class="btn btn-primary" type="button">Search</button>
                            </span> 
                        </div>
                    </div>
                </form>
            </div>
            <div class="row">
                <div id="loading" class="col-md-12" style="text-align: center; font-size: 14pt; height: 20px;"></div>
                <div class="col-md-12">
                    <div id="out" style="padding-top: 20px;">
                        <!--content goes here-->
                        <c:forEach items="${search}" var="movie">
                                <div class='movieContainer'>
                                    <a href='SingleMovie?imdbID=${movie.imdbID}'>
                                        <img class='movieImg' src='${movie.Poster}' alt='${movie.Title}' title='${movie.Title}'/>
                                    </a>
                                </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@include file="/modules/footer.html"%>
        </footer>
    </body>
</html>
