<%-- 
    Document   : login
    Created on : 06.05.2018, 14:10:30
    Author     : user-22112
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="clouds">
            <div class="cloud x1"></div>
            <!-- Time for multiple clouds to dance around -->
            <div class="cloud x2"></div>
            <div class="cloud x3"></div>
            <div class="cloud x4"></div>
            <div class="cloud x5"></div>
        </div>

        <div class="container">
            <div id="wrap" class="wrap">
                <div class="wrap-inner">

                    <!--Login Section-->
                    <div class="section" id="section1">
                        <div class="form form--login">
                            <h1 class="alpha">Войти</h1>
                            <p>У вас есть доступ? Войдите в систему.</p>
                            <div>
                                <span style="color:red"><%=((String) session.getAttribute("errMessage") == null) ? "" : (String) session.getAttribute("errMessage")%></span>
                                <%session.setAttribute("errMessage", null);%>
                                <form id="login_form" class="form-wrap" method="post" action="<%=request.getContextPath()%>/LoginController">
                                    <input name="email" id="" class="inputbox email" type="email" placeholder="Email" pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$" required="true" />
                                    <input name="password" id="" class="inputbox password" type="password" placeholder="Пароль" required="true" />
                                    <p><a href="javascript:{}" onclick="document.getElementById('login_form').submit();
                       return false;" class="button">Войти <i class="icon-rocket"></i></a></p>
                                </form>
                            </div>
                            <hr />
                            <p>Забыли пароль? Отправить по <a class="scroll" href="#section3" data-section="3">Email &raquo;</a></p>
                        </div>
                    </div>
                    <!--END: Login Section-->

                    <!--Forget Password Section-->
                    <div class="section" id="section3">
                        <div class="form form--login">
                            <h1 class="alpha">Забыли пароль?</h1>
                            <p>Введите свой e-mail и мы вышлем Вам пароль</p>
                            <div>
                                <form id="email_form" class="form-wrap" method="post" action="<%=request.getContextPath()%>/EmailController">
                                    <input id="" name="email" class="inputbox email" type="email" pattern="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$" placeholder="Email" />
                                    <p><a href="javascript:{}" onclick="document.getElementById('email_form').submit();
                    return false;" class="button">Отправить <i class="icon-rocket"></i></a></p>
                                </form>
                            </div>
                            <hr />
                            <p>Вы сами вспомнили свой пароль?</p>
                            <p><a class="scroll" href="#section1" data-section="1">&laquo; Войти</a></p>
                        </div>
                    </div>
                    <!--END: Forget Password Section-->

                </div>
            </div>
        </div>
    <center><a href="#">Qazgidromet</a>.</center>
    <center>Научно-исследовательский центр РГП <a href="https://kazhydromet.kz/kk" target="_blank">"Казгидромет"</a>.</center>
    <center>Made by students of <a href="http://iitu.kz" target="_blank">IITU</a>.</center>

</body>
</html>
