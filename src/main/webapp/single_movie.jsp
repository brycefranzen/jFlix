<%-- 
    Document   : single_movie
    Created on : Mar 16, 2015, 11:38:25 PM
    Author     : Bryce
--%>
<%
if(null == session.getAttribute("username")){  
  response.sendRedirect("index.jsp");
}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, maximum-scale=1">
        <title>${movie.Title}</title>
        <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
        <link href='css/jFlix.css' type='text/css' rel='stylesheet'>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script>
            $('.modal .close').click(function (e) {
                $('#mask').hide();
                $('#mask').css("opacity",0);    
                $('.window').hide();
            });   
        </script>
    </head>
    <body>
        <header>
            <%@include file="/modules/nav.html"%>
        </header>
            <a href="javascript:history.back()">
            <div class="backButton">
                <div class="container">
                    <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
                        <span class='back-text'>${backButton}</span>
                </div>
            </div>
        </a>
        <div class="container">
            <!-- Modal For Trailer-->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-body">
                    <object width="854" height="510">
                        <param name="movie" value="${trailerId}"></param>
                        <param name="allowFullScreen" value="true"></param>
                        <param name="allowscriptaccess" value="always"></param>
                        <embed src="${trailerId}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="854" height="510"></embed>
                    </object>
                  </div>
                </div>
              </div>
            </div>
            <!-- End Modal For Trailer-->
            <!--Modal for Sharing-->
            <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog" style="width: 500px;">
                <div class="modal-content" style="background-color: #fff; border-radius: 10px; padding: 30px;">
                    <h1>Checkout to Friend</h1><br>
                      <form action="ShareMovie?imdb=${movie.imdbID}" method="POST">
                            <div class="control-group form-group">
                            <label>Name of Friend:</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="sharedName" name="sharedName" required>
                                <span class="input-group-btn">
                                    <button type="submit" value="Submit" class="btn btn-success userSettingsButton">Checkout</button>
                                </span>
                            </div>
                            </div>
                      </form>
                </div>
              </div>
            </div>
            <!--End Modal for Sharing-->
            <div class="row">
                <div class="col-md-3" style="padding-top: 20px;">
                    <c:if test="${trailerId != 'noTrailer'}">
                        <div class="singlePosterImage" data-toggle="modal" data-target="#myModal">
                            <img class="img-responsive" src="${Poster}" alt="${movie.Title}"/>
                                <span id="movieTrailer" class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
                        </div>
                    </c:if>
                    <c:if test="${trailerId == 'noTrailer'}">
                        <img class="img-responsive" src="${Poster}" alt="${movie.Title}"/>
                    </c:if>
                    <div class="row">
                        <div class="col-md-12" style="padding-top: 10px">
                             <c:if test="${owned == 'true'}">
                                <c:choose>
                                    <c:when test="${shared == 'false'}">
                                        <br> 
                                        <button data-toggle="modal" data-target="#shareModal" class="btn btn-primary" style="width: 100%; height: 60px">Checkout to Friend&nbsp;&nbsp;<span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span></button>
                                        <br> <br>
                                  </c:when>
                                <c:otherwise>
                                     <br>
                                     <form action="ShareMovie?imdb=${movie.imdbID}" method="POST">
                                         <button type="submit" name="button" value="return" class="btn btn-primary" style="width: 100%; height: 60px">Return from Friend&nbsp;&nbsp;<span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span></button>
                                     </form>
                                <br>
                                </c:otherwise>
                                </c:choose>
                                <form action="RemoveMovie?imdb=${movie.imdbID}" method="POST">
                                <button type="submit" class="btn btn-success" style="width: 100%; height: 50px"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;&nbsp;Remove From Collection</button>
                                </form>
                            </c:if>
                            <c:if test="${owned != 'true'}">
                                <form action="AddMovie?poster=${Poster}&Title=${movie.Title}
                                  &genre=${movie.Genre}&imdb=${movie.imdbID}" method="POST">
                                <button type="submit" class="btn btn-primary" style="width: 100%; height: 50px"><span class="glyphicon glyphicon-download-alt" aria-hidden="true"></span>&nbsp;&nbsp;Add To My Collection</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>${movie.Title} (${movie.Year})</h2>
                        </div>
                    </div>
                    <div class="row" style="background-color: #d2d2d2; padding: 20px 0px;">
                        <div class="col-md-3">
                            <b>IMDB User Rating:</b> ${movie.imdbRating}
                        </div>
                        <div class="col-md-5">
                            <b>Genre:</b> ${movie.Genre}
                        </div>
                        <div class="col-md-4">
                            <b>Maturity Rating:</b> ${movie.Rated}
                        </div>
                    </div>
                    <div class="row" style="padding-bottom: 20px;">
                        <div class="col-md-12">
                            <h3>Plot:</h3>
                            <p>${movie.Plot}</p>
                        </div>
                        <div class="col-md-12">
                            <h3>Actors:</h3>
                            <p>${movie.Actors}</p>
                        </div>
                    </div>
                    <div class="row" style="background-color: #d2d2d2; padding: 20px 0px;">
                        <div class="col-md-3">
                            <b>Director:</b><br>
                            <p>${movie.Director}</p>
                        </div>
                        <div class="col-md-5">
                            <b>Writer:</b><br>
                            <p>${movie.Writer}</p>
                        </div>
                        <div class="col-md-4">
                            <b>Awards:</b><br>
                            <p>${movie.Awards}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            <%@include file="/modules/footer.html"%>
        </footer>
    </body>
</html>
