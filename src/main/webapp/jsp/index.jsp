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
	<title>Qazgidromet</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        
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
	<div class="heading-section text-center">
            <h2>Наблюдения за загрязнением атмосферного воздуха</h2>
        </div>
        <div class="row about">
            <div class="col-md-10 col-md-offset-1">
                    <div class="col-md-6 col-sm-6 services-num services-num-text-right">
                            <span class="number-holder">01</span>
                            <div class="desc">
                                    <h3>Параметр Р </h3>
                                    <p>– это интегральный показатель загрязнения воздуха в городе, который является частотной характеристикой и представляет собой отношение числа существенно повышенных концентраций примесей в воздухе, измеренных в течение дня, к общему числу измерений в течение этого же дня. </p>
                                    <h3>Параметр Cи </h3>
                                    <p>– наибольшая измеренная разовая концентрация примеси, деленная на ПДК. Она определяется из данных наблюдений на станции за одной примесью, или на всех станциях рассматриваемой территории за всеми примесями за месяц или за год. Обычно оценивается количество городов, в которых СИ > 5 или СИ > 10. </p>
                            </div>
                    </div>
                    <div class="col-md-6 col-sm-6 services-num">
                            <span class="number-holder">02</span>
                            <div class="desc">
                                    <h3>Выверите город</h3>
      <ul style="list-style-type:disc; width: 300px; height: 300px; overflow: auto; border: 1px solid #ddd;">
        <%
            request.setCharacterEncoding("UTF-8");
            PnzDao pnzDao = new PnzDao();
            CityDao cityDao = new CityDao();               
            List<City> list = cityDao.listCitis();
            for (City c : list) {
                List<Pnz> list1 = pnzDao.listPnzs(c.getCityId());
                if(list1.size()!=0){
         %>
         <li><a href="jsp/pnzdata.jsp?cityId=<%=c.getCityId() %>&pnzId=<%=list1.get(0).getPnzId() %>&pnzName=<%=list1.get(0).getPnzName() %>&month=1"><%=c.getCityName() %></a></li>
          <%  }     
          }%>
          </ul>

                            </div>
                    </div>
            </div>
        </div>

	<footer>
		<div id="footer" class="fh5co-border-line">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center">
						<p>IITU 2018 <a href="#">Qazgidromet</a>.<br>Made by students of <a href="http://iitu.kz" target="_blank">IITU</a> 
					</div>
				</div>
			</div>
		</div>
	</footer>

	</body>
</html>


