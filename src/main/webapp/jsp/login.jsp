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
        <link rel="stylesheet" href="../css/login.css">
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


      <div id="login">

        <form method="post">

          <fieldset class="clearfix">

            <p><span class="fontawesome-user"></span><input type="text" value="E-mail" onBlur="if(this.value == '') this.value = 'E-mail'" onFocus="if(this.value == 'E-mail') this.value = ''" required></p> 
            <p><span class="fontawesome-lock"></span><input type="password"  value="Пароль" onBlur="if(this.value == '') this.value = 'Пароль'" onFocus="if(this.value == 'Пароль') this.value = ''" required></p> 
            <p><input type="submit" value="Войти"></p>

          </fieldset>

        </form>

          <p>Забыли пароль?<br> <a href="#" class="blue">Отправить письмо по электронной почте</a><span class="fontawesome-arrow-right"></span></p>

      </div> <!-- end login -->
      </div>
    <center><p>Научно-исследовательский центр РГП <a href="https://kazhydromet.kz/kk" target="_blank">"Казгидромет"</a>.</center>
    <center>Made by students of <a href="http://iitu.kz" target="_blank">IITU</a> </center>
    
    </body>
</html>
