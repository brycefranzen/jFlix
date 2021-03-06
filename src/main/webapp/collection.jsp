<%-- 
    Document   : add_movie
    Created on : Mar 10, 2015, 3:16:01 PM
    Author     : Bryce
--%>
<%
if(null == session.getAttribute("username")){  
  response.sendRedirect("index.jsp");
}
request.getSession().setAttribute("page", "collection");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, maximum-scale=1">
        <title>My Collection</title>
        <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href='css/jFlix.css' type='text/css' rel='stylesheet'>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    </head>
    <body>
        <header>
            <%@include file="/modules/nav.html"%>
        </header>
        <div class="container">
            <h1 class='page-title'>Collection</h1>
            <div class="row">
                <div class="col-md-2 col-md-offset-3">
                    <form action="SortCollection?genres=${genres}" method="POST" name="sortGenre">
                        <div class="control-group form-group">
                            <select class="form-control" name="sortGenre" onchange="this.form.submit();">
                                <option value="NULL">Filter</option>
                                <option vale="Shared">Shared</option>
                                <c:forEach items="${genres}" var="genre">
                                    <option value="${genre}">${genre}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="col-md-4">
                    <form action="SearchCollection?genres=${genres}" method="POST">
                        <div class="control-group form-group">
                            <div class="input-group">
                                <input type="text" class="form-control" name="search" id="search" placeholder="Search Collection"/>
                                <span class="input-group-btn">
                                  <button class="btn btn-primary" type="submit">Search</button>
                                </span> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <c:forEach items="${ownedMovies}" var="Option">
                <div class="movieContainerOuter">
                    <div class='movieContainerInner'>
                        <a href='SingleMovie?imdbID=${Option.imdbID}&collection=true&shared=${Option.shared}'>
                            <c:if test="${Option.Poster == 'N/A'}">
                                <!--Need to use the shared variable in Option to-->
                                <!--Make the little corner lent appear-->
                                <img class='movieImg' src='http://www.vernellbrownjr.com/SorryNoImageAvailable.jpg' alt='${Option.Title}' title='${Option.Title}'/>
                                
                            </c:if>
                            <c:if test="${Option.Poster != 'N/A'}">
                                <img class='movieImg' src='${Option.Poster}' alt='${Option.Title}' title='${Option.Title}'/>
                            </c:if>
                            <c:if test="${Option.shared == true}">
                                <div class="sharedBanner">
                                    <span>Shared</span>
                                </div>
                                <div class="sharedName">
                                    <div class="sharedNameName">${Option.sharedName}</div>
                                    <div class="sharedNameButton">
                                        <form action="ShareMovie?imdb=${Option.imdbID}" method="POST">
                                         <button type="submit" name="button" value="return" class="btn btn-primary">Return</button>
                                        </form>
                                    </div>
                                </div>
                            </c:if>
                        </a>
                    </div>
                    <p class="movieTitle">${Option.Title}</p>
                </div>
            </c:forEach>
        </div>
        <footer>
            <%@include file="/modules/footer.html"%>
        </footer>
    </body>
</html>
