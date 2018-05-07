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
	<head>
	<meta charset="utf-8">
        <link rel='stylesheet prefetch' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>
	<title>Qazgidromet</title>
        <link rel="stylesheet" href="../css/style.css">
        <link rel="stylesheet" href="../css/admin.css">
        <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>        
	</head>
	<body>
	<header>
		<div class="container text-center">
			<div class="fh5co-navbar-brand">
				<a class="fh5co-logo" href="">Qazgidromet</a>
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
    <h1>Добавить нового пользователя</h1>
    <p>введите данные</p>
    <form method="post" action="../AdminController">
    <fieldset class="container">
  <div class="wrapper">
    <label for="tbUnm" class="lbl-tb"><i class="fa fa-user fa-fw"></i> Имя</label>
    <br />
    <input name="firstName" id="tbUnm" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbEmail" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Фамилия</label>
    <br />
    <input name="lastName" id="tbEmail" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
  </div>
  <div class="wrapper">
    <label for="tbEmail" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Должность</label>
    <br />
    <input name="workName" id="tbEmail" type="text" class="frm-ctrl tb" spellcheck="false" autocomplete="off" />
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
    <label for="tbEmail" class="lbl-tb"><i class="fa fa-envelope-o fa-fw"></i> Админ</label>
    <br />
    <input name="isAdmin" id="tbEmail" type="checkbox" class="frm-ctrl tb" spellcheck="false"  />
  </div>
  <div class="wrapper">
      <input type="submit" name="ACTION" value="Добавить" class="frm-ctrl btn" />
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
        <tr id="<%=u.getId()%>">
            <td><%=u.getFirstName()%></td>
            <td><%=u.getSecondName()%></td>
            <td><%=u.getEmail()%></td>
            <td><%=encDec.decrypt(u.getPassword())%></td>
            <td><a><%if(u.isAdmin()==true){%><i class="glyphicon glyphicon-ok"></i><%}else{%><i class="glyphicon glyphicon-remove"><%}%></a></td>
            <td><%=u.getWorkName()%></td>
            <td><a><i class="glyphicon glyphicon-pencil"></i></a> <a><i class="glyphicon glyphicon-trash"></i></a></td>
        </tr>
      <%}%>
    </tbody>
  </table>
</div>      

<div class="pop-up-container">
</div>
<script type="text/javascript" src="../js/admin.js"></script>
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


