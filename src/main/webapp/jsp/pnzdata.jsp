<%-- 
    Document   : pnzdata
    Created on : 21.02.2018, 13:37:52
    Author     : Nurasyl Dizim
--%>
<%
    String user = null;
    if (session.getAttribute("adminSession")==null) {
        response.sendRedirect("login.jsp");
    } else if(session.getAttribute("adminSession").equals("admin") || session.getAttribute("adminSession").equals("user")) {
        user = (String) session.getAttribute("emailSession");
    }else{
        response.sendRedirect("login.jsp");
    }
%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.PnzDataDao"%>
<%@page import="model.PnzData"%>
<%@page import="dao.PnzDao"%>
<%@page import="java.util.List"%>
<%@page import="model.Pnz"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>PNZ Data</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/mainjs.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
    </head>
    <header><%
                    request.setCharacterEncoding("UTF-8");
                    String pnzName = request.getParameter("pnzName");
                    String pnzId = request.getParameter("pnzId");
                    int cityId = Integer.parseInt(request.getParameter("cityId"));
                    String cityName = request.getParameter("cityName");
                    String month = request.getParameter("month");
                    String year = request.getParameter("year");
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    LocalDate localDate = LocalDate.now();
                %>
		<div class="container text-center">
			<div class="fh5co-navbar-brand">
                            <a class="fh5co-logo" href="<%=request.getContextPath()%>/">Qazgidromet</a>
                            <div style="text-align: right"><a><%=user%></a></div>
                                <div style="text-align: right"><a href="<%=request.getContextPath()%>/LogoutController">Выйти</a></div>
			</div>
			<nav id="fh5co-main-nav" role="navigation">
				<ul>
                                    <li><a href="<%=request.getContextPath()%>/">Главная</a></li>
					<li><a href="pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>" class="active">Заполнения</a></li>
					<li><a href="datamonth.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&name=<%=URLEncoder.encode("Январь", "UTF-8")%>&cityId=<%=cityId%>&cityName=<%=cityName%>">Q ср.м</a></li>
					<li><a href="qaverage.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>&cityName=<%=cityName%>">Прогноз q ср.м</a></li>
                                        <li><a href="pprognoz.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>&cityName=<%=cityName%>">Прогностический P</a></li>
                                        <li><a href="pfact.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>&cityName=<%=cityName%>">Фактический P</a></li>
				</ul>
			</nav>
		</div>
	</header>
                                <center>
                                <div class="neato-header">
                                    <h1><%=cityName%></h1>
                                </div>
                                </center>
    <center>
        <select class="class-select" id="pnzListId" onchange="refreshFunction('<%=cityId %>', '<%=year %>', '<%=cityName %>')">
        <%
            PnzDataDao pnzDataDao = new PnzDataDao();               
            PnzDao pnzDao = new PnzDao();
            List<Pnz> list = pnzDao.listPnzs(cityId);
            for (Pnz p : list) {
                if(p.getPnzId()==Integer.parseInt(pnzId)){
         %>
         <option selected="selected" value="<%=p.getPnzId()%>"><%=p.getPnzName()%></option>
          <%}else{%>
          <option value="<%=p.getPnzId()%>"><%=p.getPnzName()%></option>
          <%       
                }
          }%>
        </select> 
    </center>
  <div class="table100 ver4 m-b-110">
        <form method="POST" action="<%=request.getContextPath()%>/PnzDataController">
            <div id="table-scroll" class="table-scroll">
             <div class="table-wrap">
            <table data-vertable="ver4" border="1">
            <tr class="row100 head"><th>Дата</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
            <tr class="row100">
                
                <td style="display: none"><input type="hidden" id="pnzName" name="pnzName" value="<%=pnzName%>"></td>
                <td style="display: none"><input type="hidden" id="pnzId" name="pnzId" value="<%=pnzId%>"></td>
                <td style="display: none"><input type="hidden" id="month" name="month" value="<%=month%>"></td>
                <td style="display: none"><input type="hidden" id="cityId" name="cityId" value="<%=cityId%>"></td>
                <td style="display: none"><input type="hidden" id="cityName" name="cityName" value="<%=cityName%>"></td>
                <td style="display:none"><input type="hidden" name="year" value="<%=year%>"></td>
                <td><input type="datetime-local" min="2015-01-01 00:00" max="2030-01-01 00:00" step="3600"  name="pnzDateTime" required></td>
                <td><input type="number" step="0.001" name="bsh"></td>
                <td><input type="number" step="0.001" name="ds"></td>
                <td><input type="number" step="0.001" name="sr"></td>
                <td><input type="number" step="0.001" name="ou"></td>
                <td><input type="number" step="0.001" name="do_"></td>
                <td><input type="number" step="0.001" name="oa"></td>
                <td><input type="number" step="0.001" name="ozon"></td>
                <td><input type="number" step="0.001" name="serovodorod"></td>
                <td><input type="number" step="0.001" name="fenol"></td>
                <td><input type="number" step="0.001" name="fv"></td>
                <td><input type="number" step="0.001" name="hlor"></td>
                <td><input type="number" step="0.001" name="hv"></td>
                <td><input type="number" step="0.001" name="ammiak"></td>
                <td><input type="number" step="0.001" name="skIs"></td>
                <td><input type="number" step="0.001" name="formaldigid"></td>
                <td><input type="number" step="0.001" name="nsm"></td>
                <td><input type="number" step="0.001" name="hromSh"></td>
                <td><input type="number" step="0.001" name="sumU"></td>
                <td><input type="submit" name="ACTION" value="Save"></td>
            </tr>
            </table>
             </div>
            </div>
        </form>
  </div>
        <div class="year-picker">
                     <fieldset class="year-picker-fieldset">
    <input type="radio" name="year" value="2012" id="2012" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2012&cityName=<%=cityName%>')" <% if(year.equals("2012")){%>checked<%}%>>
    <label for="2012" class="year-picker-label">2012</label>
    <input type="radio" name="year" value="2013" id="2013" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2013&cityName=<%=cityName%>')" <% if(year.equals("2013")){%>checked<%}%>>
    <label for="2013" class="year-picker-label">2013</label>
    <input type="radio" name="year" value="2014" id="2014" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2014&cityName=<%=cityName%>')" <% if(year.equals("2014")){%>checked<%}%>>
    <label for="2014" class="year-picker-label">2014</label>
    <input type="radio" name="year" value="2015" id="2015" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2015&cityName=<%=cityName%>')" <% if(year.equals("2015")){%>checked<%}%>>
    <label for="2015" class="year-picker-label">2015</label>
    <input type="radio" name="year" value="2016" id="2016" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2016&cityName=<%=cityName%>')" <% if(year.equals("2016")){%>checked<%}%>>
    <label for="2016" class="year-picker-label">2016</label>
    <input type="radio" name="year" value="2017" id="2017" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2017&cityName=<%=cityName%>')" <% if(year.equals("2017")){%>checked<%}%>>
    <label for="2017" class="year-picker-label">2017</label>
    <input type="radio" name="year" value="2018" id="2018" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2018&cityName=<%=cityName%>')" <% if(year.equals("2018")){%>checked<%}%>>
    <label for="2018" class="year-picker-label">2018</label>
    <input type="radio" name="year" value="2019" id="2019" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2019&cityName=<%=cityName%>')" <% if(year.equals("2019")){%>checked<%}%>>
    <label for="2019" class="year-picker-label">2019</label>
    <input type="radio" name="year" value="2020" id="2020" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2020&cityName=<%=cityName%>')" <% if(year.equals("2020")){%>checked<%}%>>
    <label for="2020" class="year-picker-label">2020</label>
    <input type="radio" name="year" value="2021" id="2021" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2021&cityName=<%=cityName%>')" <% if(year.equals("2021")){%>checked<%}%>>
    <label for="2021" class="year-picker-label">2021</label>
    <input type="radio" name="year" value="2022" id="2022" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2022&cityName=<%=cityName%>')" <% if(year.equals("2022")){%>checked<%}%>>
    <label for="2022" class="year-picker-label">2022</label>
    <input type="radio" name="year" value="2023" id="2023" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2023&cityName=<%=cityName%>')" <% if(month.equals("2023")){%>checked<%}%>>
    <label for="2023" class="year-picker-label">2023</label>  
    <input type="radio" name="year2" value="2024" id="2024" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2024&cityName=<%=cityName%>')" <% if(year.equals("2024")){%>checked<%}%>>
    <label for="2024" class="year-picker-label">2024</label>
    <input type="radio" name="year2" value="2025" id="2025" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2025&cityName=<%=cityName%>')" <% if(year.equals("2025")){%>checked<%}%>>
    <label for="2025" class="year-picker-label">2025</label>
    <input type="radio" name="year2" value="2026" id="2026" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2026&cityName=<%=cityName%>')" <% if(year.equals("2026")){%>checked<%}%>>
    <label for="2026" class="year-picker-label">2026</label>
    <input type="radio" name="year2" value="2027" id="2027" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2027&cityName=<%=cityName%>')" <% if(year.equals("2027")){%>checked<%}%>>
    <label for="2027" class="year-picker-label">2027</label>
    <input type="radio" name="year2" value="2028" id="2028" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2028&cityName=<%=cityName%>')" <% if(year.equals("2028")){%>checked<%}%>>
    <label for="2028" class="year-picker-label">2028</label>
    <input type="radio" name="year2" value="2029" id="2029" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2029&cityName=<%=cityName%>')" <% if(year.equals("2029")){%>checked<%}%>>
    <label for="2029" class="year-picker-label">2029</label>
    <input type="radio" name="year2" value="2030" id="2030" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2030&cityName=<%=cityName%>')" <% if(year.equals("2030")){%>checked<%}%>>
    <label for="2030" class="year-picker-label">2030</label>
    <input type="radio" name="year2" value="2031" id="2031" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2031&cityName=<%=cityName%>')" <% if(year.equals("2031")){%>checked<%}%>>
    <label for="2031" class="year-picker-label">2031</label>
    <input type="radio" name="year2" value="2032" id="2032" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2032&cityName=<%=cityName%>')" <% if(year.equals("2032")){%>checked<%}%>>
    <label for="2032" class="year-picker-label">2032</label>
    <input type="radio" name="year2" value="2033" id="2033" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2033&cityName=<%=cityName%>')" <% if(year.equals("2033")){%>checked<%}%>>
    <label for="2033" class="year-picker-label">2033</label>
    <input type="radio" name="year2" value="2034" id="2034" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2034&cityName=<%=cityName%>')" <% if(year.equals("2034")){%>checked<%}%>>
    <label for="2034" class="year-picker-label">2034</label>
    <input type="radio" name="year2" value="2035" id="2035" onclick="selectYear('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=<%=month%>&cityId=<%=cityId%>&year=2035&cityName=<%=cityName%>')" <% if(month.equals("2035")){%>checked<%}%>>
    <label for="2035" class="year-picker-label">2035</label>
</fieldset>
        </div>
    <div class="month-picker">
  <fieldset class="month-picker-fieldset">
    <input type="radio" name="month" value="jan" id="jan" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=1&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("1")){%>checked<%}%>>
    <label for="jan" class="month-picker-label">Январь</label>
    <input type="radio" name="month" value="feb" id="feb" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=2&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("2")){%>checked<%}%>>
    <label for="feb" class="month-picker-label">Февраль</label>
    <input type="radio" name="month" value="mar" id="mar" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=3&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("3")){%>checked<%}%>>
    <label for="mar" class="month-picker-label">Март</label>
    <input type="radio" name="month" value="apr" id="apr" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=4&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("4")){%>checked<%}%>>
    <label for="apr" class="month-picker-label">Апрель</label>
    <input type="radio" name="month" value="may" id="may" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=5&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("5")){%>checked<%}%>>
    <label for="may" class="month-picker-label">Май</label>
    <input type="radio" name="month" value="jun" id="jun" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=6&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("6")){%>checked<%}%>>
    <label for="jun" class="month-picker-label">Июнь</label>
    <input type="radio" name="month" value="jul" id="jul" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=7&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("7")){%>checked<%}%>>
    <label for="jul" class="month-picker-label">Июль</label>
    <input type="radio" name="month" value="aug" id="aug" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=8&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("8")){%>checked<%}%>>
    <label for="aug" class="month-picker-label">Август</label>
    <input type="radio" name="month" value="sep" id="sep" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=9&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("9")){%>checked<%}%>>
    <label for="sep" class="month-picker-label">Сентябрь</label>
    <input type="radio" name="month" value="oct" id="oct" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=10&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("10")){%>checked<%}%>>
    <label for="oct" class="month-picker-label">Октябрь</label>
    <input type="radio" name="month" value="nov" id="nov" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=11&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("11")){%>checked<%}%>>
    <label for="nov" class="month-picker-label">Нобябрь</label>
    <input type="radio" name="month" value="dec" id="dec" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=12&cityId=<%=cityId%>&year=<%=year%>&cityName=<%=cityName%>')" <% if(month.equals("12")){%>checked<%}%>>
    <label for="dec" class="month-picker-label">Декабрь</label>
  </fieldset>
</div>
           
               <div class="table100 ver4 m-b-110">
                <form name=frm method="POST">
        <table data-vertable="ver4" border="1">
            <tr class="row100 head"><th>Дата</th><th>Срок</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
            <%
            List pnzMinlist =  pnzDataDao.minPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month),Integer.parseInt(year));
            List pnzMaxlist =  pnzDataDao.maxPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month),Integer.parseInt(year));
            List pnzAvglist =  pnzDataDao.avgPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month),Integer.parseInt(year));
            Iterator iterMin = pnzMinlist.iterator();
            Iterator iterMax = pnzMaxlist.iterator();
            Iterator iterAvg = pnzAvglist.iterator();
            List<PnzData> pnzDatalist =  pnzDataDao.listPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month),Integer.parseInt(year));  
            for(PnzData pd : pnzDatalist){
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
                Date dateWithoutTime = sdf.parse(sdf.format(pd.getPnzDateTime()));
                SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
                String time = localDateFormat.format(pd.getPnzDateTime());       
            %>
            <tr class="row100">
                <td style="display: none"><input type="hidden" id="pnzName" name="pnzName" value="<%=pnzName%>"></td>
                <td style="display: none"><input type="hidden" id="pnzId" name="pnzId" value="<%=pnzId%>"></td>
                <td style="display: none"><input type="hidden" id="month" name="month" value="<%=month%>"></td>
                <td style="display:none"><input type="hidden" name="pnzDataId" value="<%=pd.getPnzDataId()%>"></td>
                <td style="display:none"><input type="hidden" name="cityId" value="<%=cityId%>"></td>
                <td style="display:none"><input type="hidden" name="cityName" value="<%=cityName%>"></td>
                <td style="display:none"><input type="hidden" name="year" value="<%=year%>"></td>
                <td><input style="width: 80px;" name="dateWithoutTime<%=pd.getPnzDataId()%>" type="datetime" value="<%=sdf.format(dateWithoutTime)%>"></td>
                <td><input id="time" name="time<%=pd.getPnzDataId()%>" type="time" value="<%=time%>"></td>
                <td><input type="number" step="0.001" name="bsh<%=pd.getPnzDataId()%>" value="<%=pd.getBsh()%>"></td>
                <td><input type="number" step="0.001" name="ds<%=pd.getPnzDataId()%>" value="<%=pd.getDs()%>"></td>
                <td><input type="number" step="0.001" name="sr<%=pd.getPnzDataId()%>" value="<%=pd.getSr()%>"></td>
                <td><input type="number" step="0.001" name="ou<%=pd.getPnzDataId()%>" value="<%=pd.getOu()%>"></td>
                <td><input type="number" step="0.001" name="do_<%=pd.getPnzDataId()%>" value="<%=pd.getDo_()%>"></td>
                <td><input type="number" step="0.001" name="oa<%=pd.getPnzDataId()%>" value="<%=pd.getOa()%>"></td>
                <td><input type="number" step="0.001" name="ozon<%=pd.getPnzDataId()%>" value="<%=pd.getOzon()%>"></td>
                <td><input type="number" step="0.001" name="serovodorod<%=pd.getPnzDataId()%>" value="<%=pd.getSerovodorod()%>"></td>
                <td><input type="number" step="0.001" name="fenol<%=pd.getPnzDataId()%>" value="<%=pd.getFenol()%>"></td>
                <td><input type="number" step="0.001" name="fv<%=pd.getPnzDataId()%>" value="<%=pd.getFv()%>"></td>
                <td><input type="number" step="0.001" name="hlor<%=pd.getPnzDataId()%>" value="<%=pd.getHlor()%>"></td>
                <td><input type="number" step="0.001" name="hv<%=pd.getPnzDataId()%>" value="<%=pd.getHv()%>"></td>
                <td><input type="number" step="0.001" name="ammiak<%=pd.getPnzDataId()%>" value="<%=pd.getAmmiak()%>"></td>
                <td><input type="number" step="0.001" name="skIs<%=pd.getPnzDataId()%>" value="<%=pd.getSkIs()%>"></td>
                <td><input type="number" step="0.001" name="formaldigid<%=pd.getPnzDataId()%>" value="<%=pd.getFormaldigid()%>"></td>
                <td><input type="number" step="0.001" name="nsm<%=pd.getPnzDataId()%>" value="<%=pd.getNsm()%>"></td>
                <td><input type="number" step="0.001" name="hromSh<%=pd.getPnzDataId()%>" value="<%=pd.getHromSh()%>"></td>
                <td><input type="number" step="0.001" name="sumU<%=pd.getPnzDataId()%>" value="<%=pd.getSumU()%>"></td>  
                <td><input  type="submit" name="ACTION" value="Edit" onclick="getEditConfirmation(<%=pd.getPnzDataId()%>)"></td>
                <td><input type="submit" name="ACTION" value="Delete" onclick="getDeleteConfirmation(<%=pd.getPnzDataId()%>)"></td>
            </tr>
            <% }
            Object[] objMin = (Object[]) iterMin.next();
            Object[] objMax = (Object[]) iterMax.next();
            Object[] objAvg = (Object[]) iterAvg.next();
            if (objMin[0]!=null)
            {
            %>
               <tr>
                <td></td>
                <td>Мин</td>
                <td><%=objMin[0]%></td>
                <td><%=objMin[1]%></td>
                <td><%=objMin[2]%></td>
                <td><%=objMin[3]%></td>
                <td><%=objMin[4]%></td>
                <td><%=objMin[5]%></td>
                <td><%=objMin[6]%></td>
                <td><%=objMin[7]%></td>
                <td><%=objMin[8]%></td>
                <td><%=objMin[9]%></td>
                <td><%=objMin[10]%></td>
                <td><%=objMin[11]%></td>
                <td><%=objMin[12]%></td>
                <td><%=objMin[13]%></td>
                <td><%=objMin[14]%></td>
                <td><%=objMin[15]%></td>
                <td><%=objMin[16]%></td>
                <td><%=objMin[17]%></td>
            </tr> 
            <tr>
                <td></td>
                <td>Макс</td>
                <td><%=objMax[0]%></td>
                <td><%=objMax[1]%></td>
                <td><%=objMax[2]%></td>
                <td><%=objMax[3]%></td>
                <td><%=objMax[4]%></td>
                <td><%=objMax[5]%></td>
                <td><%=objMax[6]%></td>
                <td><%=objMax[7]%></td>
                <td><%=objMax[8]%></td>
                <td><%=objMax[9]%></td>
                <td><%=objMax[10]%></td>
                <td><%=objMax[11]%></td>
                <td><%=objMax[12]%></td>
                <td><%=objMax[13]%></td>
                <td><%=objMax[14]%></td>
                <td><%=objMax[15]%></td>
                <td><%=objMax[16]%></td>
                <td><%=objMax[17]%></td>
            </tr>   
            <tr>
                <td></td>
                <td>Ср</td>
                <td><%=objAvg[0]%></td>
                <td><%=objAvg[1]%></td>
                <td><%=objAvg[2]%></td>
                <td><%=objAvg[3]%></td>
                <td><%=objAvg[4]%></td>
                <td><%=objAvg[5]%></td>
                <td><%=objAvg[6]%></td>
                <td><%=objAvg[7]%></td>
                <td><%=objAvg[8]%></td>
                <td><%=objAvg[9]%></td>
                <td><%=objAvg[10]%></td>
                <td><%=objAvg[11]%></td>
                <td><%=objAvg[12]%></td>
                <td><%=objAvg[13]%></td>
                <td><%=objAvg[14]%></td>
                <td><%=objAvg[15]%></td>
                <td><%=objAvg[16]%></td>
                <td><%=objAvg[17]%></td>
            </tr> 
            <% } %>
        </table>
            </form>
               </div>
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
</html>
