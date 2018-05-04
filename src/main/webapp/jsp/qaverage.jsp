<%-- 
    Document   : qaverage
    Created on : 11.03.2018, 21:42:38
    Author     : Dizim Nurasyl
--%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.URLEncoder"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.Year"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.PnzData"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="model.Pnz"%>
<%@page import="dao.PnzDao"%>
<%@page import="dao.PnzDataDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="../js/mainjs.js"></script>
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <header><%
                    request.setCharacterEncoding("UTF-8");
                    String pnzName = request.getParameter("pnzName");
                    String pnzId = request.getParameter("pnzId");
                    int cityId = Integer.parseInt(request.getParameter("cityId"));
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    LocalDate localDate = LocalDate.now();
                %>
		<div class="container text-center">
			<div class="fh5co-navbar-brand">
                            <a class="fh5co-logo" href="../">Qazgidromet</a>
			</div>
			<nav id="fh5co-main-nav" role="navigation">
				<ul>
                                    <li><a href="../">Главная</a></li>
					<li><a href="pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>" >Заполнения</a></li>
					<li><a href="datamonth.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&name=<%=URLEncoder.encode("Январь", "UTF-8")%>&cityId=<%=cityId%>">Q ср.м</a></li>
					<li><a href="qaverage.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>" class="active">Прогноз q ср.м</a></li>
                                        <li><a href="pprognoz.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>">Прогностический P</a></li>
                                        <li><a href="pfact.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>">Фактический P</a></li>
				</ul>
			</nav>
		</div>
	</header>
    <body>
         <%
            String month = request.getParameter("month");
            request.setAttribute("monthId", month);
            LinkedHashMap map = new LinkedHashMap();
            map.put("1", "Январь");
            map.put("2", "Февраль");
            map.put("3", "Март");
            map.put("4", "Апрель");
            map.put("5", "Май");
            map.put("6", "Июнь");
            map.put("7", "Июль");
            map.put("8", "Август");
            map.put("9", "Сентябрь");
            map.put("10", "Октябрь");
            map.put("11", "Ноябрь");
            map.put("12", "Декабрь");
    request.setAttribute("MyMap", map);
%>
    <center>
<select class="class-select" id="monthListId" onchange="refreshFunctionMonth('<%=pnzId %>', '<%=pnzName %>', '<%=cityId%>')">
         <c:forEach items="${MyMap}" var="mapItem">
             <option value="${mapItem.key}" ${mapItem.key eq monthId ? "selected": ""}>${mapItem.value}</option>
         </c:forEach>
</select>   
    </center>
<div class="table100 ver4 m-b-110">
    <table id="table" data border="1">
            <tr class="row100 head"><th></th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
<%  
            int monthInt = Integer.parseInt(month);
            Date date = new Date();
            int currentYear = Year.now().getValue();
            int lastYear = Year.now().getValue()-1;
            int monthCurrent = date.getMonth()+1;
            if(monthInt > monthCurrent){
                currentYear = currentYear-1;
                lastYear = lastYear-1;
            }
            PnzDataDao pnzDataDao = new PnzDataDao();
            ArrayList<PnzData>[] qAvglist = pnzDataDao.qAvgPnzDatas(monthInt, cityId);
                for (int i = 0; i<4; i++) {
                    Iterator iterQAvgList = qAvglist[i].iterator();
                    Object[] objQAvg = (Object[]) iterQAvgList.next();
            %>
            <tr class="row100">
                <c:choose>
                    <c:when test = "${param.month == 1}">
                        <%if(i==0){%>
                        <td><%=map.get("12")%> <%=currentYear-2%></td>
                        <%}if(i==1){%>
                        <td><%=map.get(month)%> <%=currentYear-1%></td>
                        <%}if(i==2){%>
                        <td><%=map.get(String.valueOf(monthInt+1))%> <%=currentYear-1%></td>
                        <%}if(i==3){%>
                        <td><%=map.get("12")%> <%=currentYear-1%></td>
                        <%}%>
                    </c:when>
         
                    <c:when test = "${param.month == 12}">
                       <%if(i==0){%>
                       <td><%=map.get(String.valueOf(monthInt-1))%> <%=currentYear-1%></td>
                       <%}if(i==1){%>
                       <td><%=map.get(month)%> <%=currentYear-1%></td>
                       <%}if(i==2){%>
                       <td><%=map.get("1")%> <%=currentYear%></td>
                       <%}if(i==3){%>
                       <td><%=map.get(String.valueOf(monthInt-1))%> <%=currentYear%></td>
                       <%}%>
                    </c:when>

                    <c:otherwise>
                       <%if(i==0){%>
                       <td><%=map.get(String.valueOf(monthInt-1))%> <%=currentYear-1%></td>
                       <%}if(i==1){%>
                       <td><%=map.get(month)%> <%=currentYear-1%></td>
                       <%}if(i==2){%>
                       <td><%=map.get(String.valueOf(monthInt+1))%> <%=currentYear-1%></td>
                       <%}if(i==3){%>
                       <td><%=map.get(String.valueOf(monthInt-1))%> <%=currentYear%></td>
                       <%}%>
                    </c:otherwise>
                </c:choose>
                <td><%=objQAvg[0]%></td>
                <td><%=objQAvg[1]%></td>
                <td><%=objQAvg[2]%></td>
                <td><%=objQAvg[3]%></td>
                <td><%=objQAvg[4]%></td>
                <td><%=objQAvg[5]%></td>
                <td><%=objQAvg[6]%></td>
                <td><%=objQAvg[7]%></td>
                <td><%=objQAvg[8]%></td>
                <td><%=objQAvg[9]%></td>
                <td><%=objQAvg[10]%></td>
                <td><%=objQAvg[11]%></td>
                <td><%=objQAvg[12]%></td>
                <td><%=objQAvg[13]%></td>
                <td><%=objQAvg[14]%></td>
                <td><%=objQAvg[15]%></td>
                <td><%=objQAvg[16]%></td>
                <td><%=objQAvg[17]%></td>  
            </tr>
     <%  }%>
            <tr class="row100">
                <td><%=map.get(month)%><%=currentYear%></td>
                <td id="1id"><script>calculateQAvg(1);</script></td>
                <td id="2id"><script>calculateQAvg(2);</script></td>
                <td id="3id"><script>calculateQAvg(3);</script></td>
                <td id="4id"><script>calculateQAvg(4);</script></td>
                <td id="5id"><script>calculateQAvg(5);</script></td>
                <td id="6id"><script>calculateQAvg(6);</script></td>
                <td id="7id"><script>calculateQAvg(7);</script></td>
                <td id="8id"><script>calculateQAvg(8);</script></td>
                <td id="9id"><script>calculateQAvg(9);</script></td>
                <td id="10id"><script>calculateQAvg(10);</script></td>
                <td id="11id"><script>calculateQAvg(11);</script></td>
                <td id="12id"><script>calculateQAvg(12);</script></td>
                <td id="13id"><script>calculateQAvg(13);</script></td>
                <td id="14id"><script>calculateQAvg(14);</script></td>
                <td id="15id"><script>calculateQAvg(15);</script></td>
                <td id="16id"><script>calculateQAvg(16);</script></td>
                <td id="17id"><script>calculateQAvg(17);</script></td>
                 <td id="18id"><script>calculateQAvg(18);</script></td> 
            </tr>
                
            </table>
</div>
    </body>
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
</html>
