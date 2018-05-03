<%-- 
    Document   : pnzdata
    Created on : 21.02.2018, 13:37:52
    Author     : Nurasyl Dizim
--%>

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
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/style.css">
        <script type="text/javascript" src="../js/mainjs.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.js"></script>
        <script type="text/javascript" src="../js/jquery.js"></script>
    </head>
    <header><%
                    request.setCharacterEncoding("UTF-8");
                    String pnzName = request.getParameter("pnzName");
                    String pnzId = request.getParameter("pnzId");
                    int cityId = Integer.parseInt(request.getParameter("cityId"));
                    String month = request.getParameter("month");
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
					<li><a href="pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>" class="active">Заполнения</a></li>
					<li><a href="datamonth.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&name=<%=URLEncoder.encode("Январь", "UTF-8")%>&cityId=<%=cityId%>">Q ср.м</a></li>
					<li><a href="qaverage.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>">Прогноз q ср.м</a></li>
                                        <li><a href="pprognoz.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>">Прогностический P</a></li>
                                        <li><a href="pfact.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>">Фактический P</a></li>
				</ul>
			</nav>
		</div>
	</header>
    <body>
    <center>
        <select class="class-select" id="pnzListId" onchange="refreshFunction(<%=cityId %>)">
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
        <form method="POST" action="../PnzDataController">
            <div id="table-scroll" class="table-scroll">
             <div class="table-wrap">
            <table data-vertable="ver4" border="1">
            <tr class="row100 head"><th>Дата</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
            <tr class="row100">
                
                <td style="display: none"><input type="hidden" id="pnzName" name="pnzName" value="<%=pnzName%>"></td>
                <td style="display: none"><input type="hidden" id="pnzId" name="pnzId" value="<%=pnzId%>"></td>
                <td style="display: none"><input type="hidden" id="month" name="month" value="<%=month%>"></td>
                <td style="display: none"><input type="hidden" id="cityId" name="cityId" value="<%=cityId%>"></td>
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
                <td><input type="number" step="0.001"name="skIs"></td>
                <td><input type="number" step="0.001" name="formaldigid"></td>
                <td><input type="number" step="0.001" name="nsm"></td>
                <td><input type="number" step="0.001" name="hromSh"></td>
                <td><input type="number" step="0.001" name="sumU"></td>
                <td><input type="submit" step="0.001" name="ACTION" value="Save"></td>
            </tr>
            </table>
             </div>
            </div>
        </form>
  </div>
        <div class="month-picker">
  <fieldset class="month-picker-fieldset">
    <input type="radio" name="month" value="jan" id="jan" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=1&cityId=<%=cityId%>')" <% if(month.equals("1")){%>checked<%}%>>
    <label for="jan" class="month-picker-label">Янв</label>
    <input type="radio" name="month" value="feb" id="feb" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=2&cityId=<%=cityId%>')" <% if(month.equals("2")){%>checked<%}%>>
    <label for="feb" class="month-picker-label">Фев</label>
    <input type="radio" name="month" value="mar" id="mar" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=3&cityId=<%=cityId%>')" <% if(month.equals("3")){%>checked<%}%>>
    <label for="mar" class="month-picker-label">Март</label>
    <input type="radio" name="month" value="apr" id="apr" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=4&cityId=<%=cityId%>')" <% if(month.equals("4")){%>checked<%}%>>
    <label for="apr" class="month-picker-label">Апр</label>
    <input type="radio" name="month" value="may" id="may" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=5&cityId=<%=cityId%>')" <% if(month.equals("5")){%>checked<%}%>>
    <label for="may" class="month-picker-label">Май</label>
    <input type="radio" name="month" value="jun" id="jun" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=6&cityId=<%=cityId%>')" <% if(month.equals("6")){%>checked<%}%>>
    <label for="jun" class="month-picker-label">Июнь</label>
    <input type="radio" name="month" value="jul" id="jul" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=7&cityId=<%=cityId%>')" <% if(month.equals("7")){%>checked<%}%>>
    <label for="jul" class="month-picker-label">Июль</label>
    <input type="radio" name="month" value="aug" id="aug" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=8&cityId=<%=cityId%>')" <% if(month.equals("8")){%>checked<%}%>>
    <label for="aug" class="month-picker-label">Авг</label>
    <input type="radio" name="month" value="sep" id="sep" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=9&cityId=<%=cityId%>')" <% if(month.equals("9")){%>checked<%}%>>
    <label for="sep" class="month-picker-label">Сен</label>
    <input type="radio" name="month" value="oct" id="oct" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=10&cityId=<%=cityId%>')" <% if(month.equals("10")){%>checked<%}%>>
    <label for="oct" class="month-picker-label">Окт</label>
    <input type="radio" name="month" value="nov" id="nov" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=11&cityId=<%=cityId%>')" <% if(month.equals("11")){%>checked<%}%>>
    <label for="nov" class="month-picker-label">Ноб</label>
    <input type="radio" name="month" value="dec" id="dec" onclick="selectMonth('pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=URLEncoder.encode(pnzName, "UTF-8")%>&month=12&cityId=<%=cityId%>')" <% if(month.equals("12")){%>checked<%}%>>
    <label for="dec" class="month-picker-label">Дек</label>
  </fieldset>
</div>
           
               <div class="table100 ver4 m-b-110">
                <form name=frm method="POST">
        <table data-vertable="ver4" border="1">
            <tr class="row100 head"><th>Дата</th><th>Срок</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
            <%
            List pnzMinlist =  pnzDataDao.minPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month));
            List pnzMaxlist =  pnzDataDao.maxPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month));
            List pnzAvglist =  pnzDataDao.avgPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month));
            Iterator iterMin = pnzMinlist.iterator();
            Iterator iterMax = pnzMaxlist.iterator();
            Iterator iterAvg = pnzAvglist.iterator();
            List<PnzData> pnzDatalist =  pnzDataDao.listPnzDatas(Integer.parseInt(pnzId),Integer.parseInt(month));  
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
                <td><input style="width: 80px;" name="dateWithoutTime<%=pd.getPnzDataId()%>" type="datetime" value="<%=sdf.format(dateWithoutTime)%>"></td>
                <td><input id="time" name="time<%=pd.getPnzDataId()%>" type="time" value="<%=time%>"></td>
                <td><input name="bsh<%=pd.getPnzDataId()%>" value="<%=pd.getBsh()%>"></td>
                <td><input name="ds<%=pd.getPnzDataId()%>" value="<%=pd.getDs()%>"></td>
                <td><input name="sr<%=pd.getPnzDataId()%>" value="<%=pd.getSr()%>"></td>
                <td><input name="ou<%=pd.getPnzDataId()%>" value="<%=pd.getOu()%>"></td>
                <td><input name="do_<%=pd.getPnzDataId()%>" value="<%=pd.getDo_()%>"></td>
                <td><input name="oa<%=pd.getPnzDataId()%>" value="<%=pd.getOa()%>"></td>
                <td><input name="ozon<%=pd.getPnzDataId()%>" value="<%=pd.getOzon()%>"></td>
                <td><input name="serovodorod<%=pd.getPnzDataId()%>" value="<%=pd.getSerovodorod()%>"></td>
                <td><input name="fenol<%=pd.getPnzDataId()%>" value="<%=pd.getFenol()%>"></td>
                <td><input name="fv<%=pd.getPnzDataId()%>" value="<%=pd.getFv()%>"></td>
                <td><input name="hlor<%=pd.getPnzDataId()%>" value="<%=pd.getHlor()%>"></td>
                <td><input name="hv<%=pd.getPnzDataId()%>" value="<%=pd.getHv()%>"></td>
                <td><input name="ammiak<%=pd.getPnzDataId()%>" value="<%=pd.getAmmiak()%>"></td>
                <td><input name="skIs<%=pd.getPnzDataId()%>" value="<%=pd.getSkIs()%>"></td>
                <td><input name="formaldigid<%=pd.getPnzDataId()%>" value="<%=pd.getFormaldigid()%>"></td>
                <td><input name="nsm<%=pd.getPnzDataId()%>" value="<%=pd.getNsm()%>"></td>
                <td><input name="hromSh<%=pd.getPnzDataId()%>" value="<%=pd.getHromSh()%>"></td>
                <td><input name="sumU<%=pd.getPnzDataId()%>" value="<%=pd.getSumU()%>"></td>  
                <td><input type="submit" name="ACTION" value="Edit" onclick="getEditConfirmation(<%=pd.getPnzDataId()%>)"></td>
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
                <td name="bsh<%=objMin[0]%>"><%=objMin[0]%></td>
                <td name="ds<%=objMin[1]%>"><%=objMin[1]%></td>
                <td name="sr<%=objMin[2]%>"><%=objMin[2]%></td>
                <td name="ou<%=objMin[3]%>"><%=objMin[3]%></td>
                <td name="do_<%=objMin[4]%>"><%=objMin[4]%></td>
                <td name="oa<%=objMin[5]%>"><%=objMin[5]%></td>
                <td name="ozon<%=objMin[6]%>"><%=objMin[6]%></td>
                <td name="serovodorod<%=objMin[7]%>"><%=objMin[7]%></td>
                <td name="fenol<%=objMin[8]%>"><%=objMin[8]%></td>
                <td name="fv<%=objMin[9]%>"><%=objMin[9]%></td>
                <td name="hlor<%=objMin[10]%>"><%=objMin[10]%></td>
                <td name="hv<%=objMin[11]%>"><%=objMin[11]%></td>
                <td name="ammiak<%=objMin[12]%>"><%=objMin[12]%></td>
                <td name="skIs<%=objMin[13]%>"><%=objMin[13]%></td>
                <td name="formaldigid<%=objMin[14]%>"><%=objMin[14]%></td>
                <td name="nsm<%=objMin[15]%>"><%=objMin[15]%></td>
                <td name="hromSh<%=objMin[16]%>"><%=objMin[16]%></td>
                <td name="sumU<%=objMin[17]%>"><%=objMin[17]%></td>
            </tr> 
            <tr>
                <td></td>
                <td>Макс</td>
                <td name="bsh<%=objMax[0]%>"><%=objMax[0]%></td>
                <td name="ds<%=objMax[1]%>"><%=objMax[1]%></td>
                <td name="sr<%=objMax[2]%>"><%=objMax[2]%></td>
                <td name="ou<%=objMax[3]%>"><%=objMax[3]%></td>
                <td name="do_<%=objMax[4]%>"><%=objMax[4]%></td>
                <td name="oa<%=objMax[5]%>"><%=objMax[5]%></td>
                <td name="ozon<%=objMax[6]%>"><%=objMax[6]%></td>
                <td name="serovodorod<%=objMax[7]%>"><%=objMax[7]%></td>
                <td name="fenol<%=objMax[8]%>"><%=objMax[8]%></td>
                <td name="fv<%=objMax[9]%>"><%=objMax[9]%></td>
                <td name="hlor<%=objMax[10]%>"><%=objMax[10]%></td>
                <td name="hv<%=objMax[11]%>"><%=objMax[11]%></td>
                <td name="ammiak<%=objMax[12]%>"><%=objMax[12]%></td>
                <td name="skIs<%=objMax[13]%>"><%=objMax[13]%></td>
                <td name="formaldigid<%=objMax[14]%>"><%=objMax[14]%></td>
                <td name="nsm<%=objMax[15]%>"><%=objMax[15]%></td>
                <td name="hromSh<%=objMax[16]%>"><%=objMax[16]%></td>
                <td name="sumU<%=objMax[17]%>"><%=objMax[17]%></td>
            </tr>  
            </tr>     
            <tr>
                <td></td>
                <td>Ср</td>
                <td name="bsh<%=objAvg[0]%>"><%=objAvg[0]%></td>
                <td name="ds<%=objAvg[1]%>"><%=objAvg[1]%></td>
                <td name="sr<%=objAvg[2]%>"><%=objAvg[2]%></td>
                <td name="ou<%=objAvg[3]%>"><%=objAvg[3]%></td>
                <td name="do_<%=objAvg[4]%>"><%=objAvg[4]%></td>
                <td name="oa<%=objAvg[5]%>"><%=objAvg[5]%></td>
                <td name="ozon<%=objAvg[6]%>"><%=objAvg[6]%></td>
                <td name="serovodorod<%=objAvg[7]%>"><%=objAvg[7]%></td>
                <td name="fenol<%=objAvg[8]%>"><%=objAvg[8]%></td>
                <td name="fv<%=objAvg[9]%>"><%=objAvg[9]%></td>
                <td name="hlor<%=objAvg[10]%>"><%=objAvg[10]%></td>
                <td name="hv<%=objAvg[11]%>"><%=objAvg[11]%></td>
                <td name="ammiak<%=objAvg[12]%>"><%=objAvg[12]%></td>
                <td name="skIs<%=objAvg[13]%>"><%=objAvg[13]%></td>
                <td name="formaldigid<%=objAvg[14]%>"><%=objAvg[14]%></td>
                <td name="nsm<%=objAvg[15]%>"><%=objAvg[15]%></td>
                <td name="hromSh<%=objAvg[16]%>"><%=objAvg[16]%></td>
                <td name="sumU<%=objAvg[17]%>"><%=objAvg[17]%></td>
            </tr> 
            </tr> 
            <% } %>
        </table>
            </form>
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
