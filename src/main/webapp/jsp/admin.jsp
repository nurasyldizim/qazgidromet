<%@page import="controller.EncDecPassword"%>
<%@page import="model.User"%>
<%@page import="dao.UserDao"%>
<%@page import="java.time.Year"%>
<%@page import="model.Pnz"%>
<%@page import="dao.PnzDao"%>
<%@page import="model.City"%>
<%@page import="java.util.List"%>
<%@page import="dao.CityDao"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%
    String user = null;
    if (session.getAttribute("adminSession")==null) {
        response.sendRedirect("login.jsp");
    } else if(session.getAttribute("adminSession").equals("admin")) {
        user = (String) session.getAttribute("emailSession");
    }else{
        response.sendRedirect("login.jsp");
    }
%>
	<head>
	<meta charset="utf-8">
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>
	<title>Qazgidromet</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css">
        <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>        
	</head>
	<body>
	<header>
		<div class="container text-center">
			<div class="fh5co-navbar-brand">
				<a class="fh5co-logo" href="<%=request.getContextPath()%>/index.jsp">Qazgidromet</a>
                                <div style="text-align: right"><a><%=user%></a></div>
                                <div style="text-align: right"><a href="<%=request.getContextPath()%>/LogoutController">Выйти</a></div>
			</div>
    
			<nav id="fh5co-main-nav" role="navigation">
				<ul>
                                        <li><a href="" class="active">Главная</a></li>
				</ul>
			</nav>
		</div>
	</header>
            <div class="container">
                <h2>Пользаватели <button class="pop-up-button">Добавить</button></h2>
                <div class="pop-up">
  <span>x</span>
  <div class="pop-up-text">
      <h1 id="popHeader">Добавить нового пользователя</h1>
    <p>введите данные</p>
    <form name="frm" method="post" action="<%=request.getContextPath()%>/AdminController">
    <fieldset class="container">
  <div class="wrapper">
      <input id="userId" type="hidden" name="id" />
    <label for="tbName" class="lbl-tb"><i class="fa fa-user fa-fw"></i> Имя</label>
    <br />
    <input name="firstName" id="tbName" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbSurname" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Фамилия</label>
    <br />
    <input name="secondName" id="tbSurname" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbWork" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Должность</label>
    <br />
    <input name="workName" id="tbWork" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbEmail" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Email</label>
    <br />
    <input name="email" id="tbEmail" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbPwd1" class="lbl-tb"><i class="fa fa-unlock fa-fw"></i> Пароль</label>
    <br />
    <input name="password" id="tbPwd1" type="password" class="frm-ctrl tb" />
  </div>
  <div class="wrapper">
    <label for="tbPwd2" class="lbl-tb"><i class="fa fa-unlock fa-fw"></i> Повторите пароль</label>
    <br />
    <input name="confirmPassword" id="tbPwd2" type="password" class="frm-ctrl tb" />
  </div>
  <div class="wrapper">
    <label for="tbAdmin" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Админ</label>
    <br />
    <div id="wrapper">
		<div class="ioslide">		
                    <input name="isAdmin" type="checkbox" class="iostyle" id="ioslide" checked="false"/>
			<label for="ioslide"></label>
		</div>
	</div>
  </div>
  <div class="wrapper">
      <input type="submit" id="tbSumbit" name="ACTION" value="Добавить" class="pop-up-button2" />
  </div>
</fieldset>
    </form>
  </div>
</div>
                              
  <table class="table table-condensed">
    <thead>
      <tr>
        <th>Имя</th>
        <th>Фамилия</th>
        <th>Email</th>
        <th>Пароль</th>
        <th>Админ</th>
        <th>Должность</th>
        <th>---------</th>
      </tr>
    </thead>
    <tbody>
        <%
            request.setCharacterEncoding("UTF-8");
            EncDecPassword encDec = new EncDecPassword();
            UserDao userDao = new UserDao();              
            List<User> list = userDao.listUsers();
            for ( User u : list) {
         %>
        <tr>
            <td id="name<%=u.getId()%>"><%=u.getFirstName()%></td>
            <td id="surname<%=u.getId()%>"><%=u.getSecondName()%></td>
            <td id="email<%=u.getId()%>"><%=u.getEmail()%></td>
            <td id="password<%=u.getId()%>"><%=encDec.decrypt(u.getPassword())%></td>
            <td id="admin<%=u.getId()%>"><%if(u.isAdmin()==true){%><a><i class="glyphicon glyphicon-ok">Да</i></a><%}else{%><a><i class="glyphicon glyphicon-remove">Нет</i><%}%></a></td>
            <td id="work<%=u.getId()%>"><%=u.getWorkName()%></td>
            <td><a class="pop-up-link"><i id="<%=u.getId()%>"class="glyphicon glyphicon-pencil"></i></a> <a class="pop-up-delete"><i id="<%=u.getId()%>" class="glyphicon glyphicon-trash"></i></a></td>
        </tr>
      <%}%>
    </tbody>
  </table>
</div>      

<div class="pop-up-container">
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/admin.js"></script>
	<footer>
		<div id="footer" class="fh5co-border-line">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center">
						<p>Научно-исследовательский центр РГП <a href="https://kazhydromet.kz/kk" target="_blank">"Казгидромет"</a>.<br>Made by students of <a href="http://iitu.kz" target="_blank">IITU</a> 
					</div>
				</div>
			</div>
		</div>
	</footer>
	</body>
</html>


