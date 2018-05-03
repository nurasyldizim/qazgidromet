<%-- 
    Document   : pprognoz
    Created on : 12.03.2018, 22:13:30
    Author     : Dizim Nurasyl
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="model.Pnz"%>
<%@page import="dao.PnzDao"%>
<%@page import="dao.PnzDataDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.PnzData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link rel="stylesheet" href="../css/style.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js">
  </script>

        <link rel="stylesheet" type="text/css" href="../css/datepicker.css">
        <link rel="stylesheet" type="text/css" href="../css/indicator.css">
        <link rel="stylesheet" type="text/css" href="../css/chart.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="text/javascript" src="../js/mainjs.js"></script>
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.js"></script>
        <script type="text/javascript" src="../js/datepicker2.js"></script>
        <script type="text/javascript" src="../js/toexcel.js"></script>

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
					<li><a href="pnzdata.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>">Заполнения</a></li>
					<li><a href="datamonth.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&name=<%=URLEncoder.encode("Январь", "UTF-8")%>&cityId=<%=cityId%>">Q ср.м</a></li>
					<li><a href="qaverage.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&month=1&cityId=<%=cityId%>">Прогноз q ср.м</a></li>
                                        <li><a href="pprognoz.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>">Прогностический P</a></li>
                                        <li><a href="pfact.jsp?pnzId=<%=pnzId%>&pnzName=<%=pnzName%>&date=<%=dtf.format(localDate)%>&cityId=<%=cityId%>" class="active">Фактический P</a></li>
				</ul>
			</nav>
		</div>
	</header>
    <body>
        <%
            String date = request.getParameter("date");
        %>
        
   <div class="date-picker">
	<div class="input">
            <div class="result">Дата: <span><%= date %></span></div>
		<button><i class="fa fa-calendar"></i></button>
	</div>
	<div class="calendar"></div>
</div>
              <div id="js-meter" class="meter">
  
  <span class="meter-label">Фактический P на <%= date %></span>
  <div class="meter-glass">
    <div class="meter-display">
      <div class="meter-range">
        <div class="meter-range-item meter-range-item--1"></div>
        <div class="meter-range-item meter-range-item--2"></div>
        <div class="meter-range-item meter-range-item--3"></div>
      </div>
      <div class="meter-needle"></div>
    </div>
  </div>
  
</div>
  <button onclick="generateExcel()">Export to Excel</button>
  <br />
  <br />
  <div class="table100 ver4 m-b-110">
                <table id="table" width="220" border="1">
                    <tr><td colspan="20">Расчетная матрица для "P" </td></tr>
        <tr><th></th><th>Срок</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
        <%
            int rowCount = 0;
            PnzDataDao pnzDataDao = new PnzDataDao();               
            PnzDao pnzDao = new PnzDao();
            List<Pnz> list = pnzDao.listPnzs(cityId);
            for (Pnz p : list) {   
                ArrayList<PnzData>[] pnzDatalist = pnzDataDao.listPnzDatasToFP(p.getPnzId(),date); 
            for (int i = 0; i<4; i++) {
                    Iterator iterDataList = pnzDatalist[i].iterator();
                    if(pnzDatalist[i].size()!=0){
                    Object[] objData = (Object[]) iterDataList.next();
                    rowCount++;
    %>
        <tr>
            <td><%=p.getPnzName()%></td>
                <%if(i==0){%>
                <td>1:00</td>
                <%}if(i==1){%>
                <td>7:00</td>
                <%}if(i==2){%>
                <td>13:00</td>
                <%}if(i==3){%>
                <td>19:00</td>
                <%}%>
            <td><%=objData[0]%></td>
            <td><%=objData[1]%></td>
            <td><%=objData[2]%></td>
            <td><%=objData[3]%></td>
            <td><%=objData[4]%></td>
            <td><%=objData[5]%></td>
            <td><%=objData[6]%></td>
            <td><%=objData[7]%></td>
            <td><%=objData[8]%></td>
            <td><%=objData[9]%></td>
            <td><%=objData[10]%></td>
            <td><%=objData[11]%></td>
            <td><%=objData[12]%></td>
            <td><%=objData[13]%></td>
            <td><%=objData[14]%></td>
            <td><%=objData[15]%></td>
            <td><%=objData[16]%></td>
            <td><%=objData[16]%></td>
                
        </tr>
        <%}}}%>
        <tr>
                <td></td>
                <td>макс</td>
                <td id="2max"><script>calculateQMaxToP(2);</script></td>
                <td id="3max"><script>calculateQMaxToP(3);</script></td>
                <td id="4max"><script>calculateQMaxToP(4);</script></td>
                <td id="5max"><script>calculateQMaxToP(5);</script></td>
                <td id="6max"><script>calculateQMaxToP(6);</script></td>
                <td id="7max"><script>calculateQMaxToP(7);</script></td>
                <td id="8max"><script>calculateQMaxToP(8);</script></td>
                <td id="9max"><script>calculateQMaxToP(9);</script></td>
                <td id="10max"><script>calculateQMaxToP(10);</script></td>
                <td id="11max"><script>calculateQMaxToP(11);</script></td>
                <td id="12max"><script>calculateQMaxToP(12);</script></td>
                <td id="13max"><script>calculateQMaxToP(13);</script></td>
                <td id="14max"><script>calculateQMaxToP(14);</script></td>
                <td id="15max"><script>calculateQMaxToP(15);</script></td>
                <td id="16max"><script>calculateQMaxToP(16);</script></td>
                <td id="17max"><script>calculateQMaxToP(17);</script></td>
                <td id="18max"><script>calculateQMaxToP(18);</script></td> 
                <td id="19max"><script>calculateQMaxToP(19);</script></td>  
            </tr>
            <tr>
                <td></td>
                <td>мин</td>
                <td id="2min"><script>calculateQMinToP(2);</script></td>
                <td id="3min"><script>calculateQMinToP(3);</script></td>
                <td id="4min"><script>calculateQMinToP(4);</script></td>
                <td id="5min"><script>calculateQMinToP(5);</script></td>
                <td id="6min"><script>calculateQMinToP(6);</script></td>
                <td id="7min"><script>calculateQMinToP(7);</script></td>
                <td id="8min"><script>calculateQMinToP(8);</script></td>
                <td id="9min"><script>calculateQMinToP(9);</script></td>
                <td id="10min"><script>calculateQMinToP(10);</script></td>
                <td id="11min"><script>calculateQMinToP(11);</script></td>
                <td id="12min"><script>calculateQMinToP(12);</script></td>
                <td id="13min"><script>calculateQMinToP(13);</script></td>
                <td id="14min"><script>calculateQMinToP(14);</script></td>
                <td id="15min"><script>calculateQMinToP(15);</script></td>
                <td id="16min"><script>calculateQMinToP(16);</script></td>
                <td id="17min"><script>calculateQMinToP(17);</script></td>
                <td id="18min"><script>calculateQMinToP(18);</script></td> 
                <td id="19min"><script>calculateQMinToP(19);</script></td>
            </tr>
        <tr>
                <td></td>
                <td>ср</td>
                <td id="2id"><script>calculateQAvgToP(2);</script></td>
                <td id="3id"><script>calculateQAvgToP(3);</script></td>
                <td id="4id"><script>calculateQAvgToP(4);</script></td>
                <td id="5id"><script>calculateQAvgToP(5);</script></td>
                <td id="6id"><script>calculateQAvgToP(6);</script></td>
                <td id="7id"><script>calculateQAvgToP(7);</script></td>
                <td id="8id"><script>calculateQAvgToP(8);</script></td>
                <td id="9id"><script>calculateQAvgToP(9);</script></td>
                <td id="10id"><script>calculateQAvgToP(10);</script></td>
                <td id="11id"><script>calculateQAvgToP(11);</script></td>
                <td id="12id"><script>calculateQAvgToP(12);</script></td>
                <td id="13id"><script>calculateQAvgToP(13);</script></td>
                <td id="14id"><script>calculateQAvgToP(14);</script></td>
                <td id="15id"><script>calculateQAvgToP(15);</script></td>
                <td id="16id"><script>calculateQAvgToP(16);</script></td>
                <td id="17id"><script>calculateQAvgToP(17);</script></td>
                <td id="18id"><script>calculateQAvgToP(18);</script></td> 
                <td id="19id"><script>calculateQAvgToP(19);</script></td> 
            </tr>
            <%
               int counter = 0;
               double[] array = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
               ArrayList<PnzData>[] pnzDatalist = pnzDataDao.listQAvgToPP(date); 
            for (int i = 0; i<4; i++) {
                    Iterator iterQAvgList = pnzDatalist[i].iterator();
                    Object[] temp = (Object[]) iterQAvgList.next();
                    if(temp[0]!=null){
                        counter++;
                        for(int j =0; j<18; j++){
                        array[j] = array[j] + (Double)temp[j];
                    }
                    }
            }
            %>
            <tr>
                <td></td>
                <td>q ср.сезон  ПНЗ</td>
                <%if(counter==4){%>
                <td><%=array[0]/4%></td>
                <td><%=array[1]/4%></td>
                <td><%=array[2]/4%></td>
                <td><%=array[3]/4%></td>
                <td><%=array[4]/4%></td>
                <td><%=array[5]/4%></td>
                <td><%=array[6]/4%></td>
                <td><%=array[7]/4%></td>
                <td><%=array[8]/4%></td>
                <td><%=array[9]/4%></td>
                <td><%=array[10]/4%></td>
                <td><%=array[11]/4%></td>
                <td><%=array[12]/4%></td>
                <td><%=array[13]/4%></td>
                <td><%=array[14]/4%></td>
                <td><%=array[15]/4%></td>
                <td><%=array[16]/4%></td>
                <td><%=array[17]/4%></td>
                <%}else{%>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <%}%>  
            </tr>
            <tr>
                <td></td>
                <td>1.5q ср.сезон  ПНЗ</td>
                <td id="2qAvg15"><script>qAvg15(2);</script></td>
                <td id="3qAvg15"><script>qAvg15(3);</script></td>
                <td id="4qAvg15"><script>qAvg15(4);</script></td>
                <td id="5qAvg15"><script>qAvg15(5);</script></td>
                <td id="6qAvg15"><script>qAvg15(6);</script></td>
                <td id="7qAvg15"><script>qAvg15(7);</script></td>
                <td id="8qAvg15"><script>qAvg15(8);</script></td>
                <td id="9qAvg15"><script>qAvg15(9);</script></td>
                <td id="10qAvg15"><script>qAvg15(10);</script></td>
                <td id="11qAvg15"><script>qAvg15(11);</script></td>
                <td id="12qAvg15"><script>qAvg15(12);</script></td>
                <td id="13qAvg15"><script>qAvg15(13);</script></td>
                <td id="14qAvg15"><script>qAvg15(14);</script></td>
                <td id="15qAvg15"><script>qAvg15(15);</script></td>
                <td id="16qAvg15"><script>qAvg15(16);</script></td>
                <td id="17qAvg15"><script>qAvg15(17);</script></td>
                <td id="18qAvg15"><script>qAvg15(18);</script></td> 
                <td id="19qAvg15"><script>qAvg15(19);</script></td> 
            </tr>
            <tr>
                <td>n</td>
                <td>m</td>
                <td colspan="18"><center>число превышений 1,5 q</center></td>
            </tr>
            <tr>
                <td id="nValue"><script>countN();</script></td>
                <td id="mValue"><script>countM();</script></td>
                <td id="2countEachM"><script>countEachM(2);</script></td>
                <td id="3countEachM"><script>countEachM(3);</script></td>
                <td id="4countEachM"><script>countEachM(4);</script></td>
                <td id="5countEachM"><script>countEachM(5);</script></td>
                <td id="6countEachM"><script>countEachM(6);</script></td>
                <td id="7countEachM"><script>countEachM(7);</script></td>
                <td id="8countEachM"><script>countEachM(8);</script></td>
                <td id="9countEachM"><script>countEachM(9);</script></td>
                <td id="10countEachM"><script>countEachM(10);</script></td>
                <td id="11countEachM"><script>countEachM(11);</script></td>
                <td id="12countEachM"><script>countEachM(12);</script></td>
                <td id="13countEachM"><script>countEachM(13);</script></td>
                <td id="14countEachM"><script>countEachM(14);</script></td>
                <td id="15countEachM"><script>countEachM(15);</script></td>
                <td id="16countEachM"><script>countEachM(16);</script></td>
                <td id="17countEachM"><script>countEachM(17);</script></td>
                <td id="18countEachM"><script>countEachM(18);</script></td> 
                <td id="19countEachM"><script>countEachM(19);</script></td> 
            </tr>
            <tr><td colspan="20"><center>ПДК</center></td></tr>
            <tr>
                <td>ПДК</td>
                <td></td>
                <td>0.5000</td>
                <td>0.5000</td>
                <td></td>
                <td>0.5000</td>
                <td>0.2000</td>
                <td>0.4000</td>
                <td>0.1600</td>
                <td>0.0080</td>
                <td>0.0100</td>
                <td>0.0200</td>
                <td>0.1000</td>
                <td>0.2000</td>
                <td>0.2000</td>
                <td>0.3000</td>
                <td>0.0500</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
    </table>
            <br>
            <br>
            <table id="table2" width="220" border="1">
                <tr><td colspan="20">Расчетная матрица для "ПДК" </td></tr>
                <tr><th></th><th>Срок</th><th>Взвешенные частицы(пыль)</th><th>Диоксид серы</th><th>Сульфаты растворимые</th><th>Оксид углерода</th><th>Диоксид азота</th><th>Оксид азота</th><th>Озон</th><th>Сероводород</th><th>Фенол</th><th>Фтористый водород</th><th>Хлор</th><th>Хлористый водород</th><th>Аммиак</th><th>Серная кислота и сульфаты</th><th>Формальдегид</th><th>Неорганические соединения мышьяк</th><th>Хром шестивалентный</th><th>Суммарные углеводороды</th></tr>   
            <%
                for(int i =0; i<rowCount; i++){
            %>
                <tr>
                    <td id="1<%=i%>"><script>showTableData(<%=i%>,1);</script></td>
                    <td id="2<%=i%>"><script>showTableData(<%=i%>,2);</script></td>
                    <td id="3<%=i%>"><script>calPDK(<%=i%>,3);</script></td>
                    <td id="4<%=i%>"><script>calPDK(<%=i%>,4);</script></td>
                    <td id="5<%=i%>"><script>calPDK(<%=i%>,5);</script></td>
                    <td id="6<%=i%>"><script>calPDK(<%=i%>,6);</script></td>
                    <td id="7<%=i%>"><script>calPDK(<%=i%>,7);</script></td>
                    <td id="8<%=i%>"><script>calPDK(<%=i%>,8);</script></td>
                    <td id="9<%=i%>"><script>calPDK(<%=i%>,9);</script></td>
                    <td id="10<%=i%>"><script>calPDK(<%=i%>,10);</script></td>
                    <td id="11<%=i%>"><script>calPDK(<%=i%>,11);</script></td>
                    <td id="12<%=i%>"><script>calPDK(<%=i%>,12);</script></td>
                    <td id="13<%=i%>"><script>calPDK(<%=i%>,13);</script></td>
                    <td id="14<%=i%>"><script>calPDK(<%=i%>,14);</script></td>
                    <td id="15<%=i%>"><script>calPDK(<%=i%>,15);</script></td>
                    <td id="16<%=i%>"><script>calPDK(<%=i%>,16);</script></td>
                    <td id="17<%=i%>"><script>calPDK(<%=i%>,17);</script></td>
                    <td id="18<%=i%>"><script>calPDK(<%=i%>,18);</script></td>
                    <td id="19<%=i%>"><script>calPDK(<%=i%>,19);</script></td>
                    <td id="20<%=i%>"><script>calPDK(<%=i%>,20);</script></td>
            </tr>
            <%}%>
            <tr>
                <td>ПДК</td>
                <td></td>
                <td>0.5000</td>
                <td>0.5000</td>
                <td></td>
                <td>0.5000</td>
                <td>0.2000</td>
                <td>0.4000</td>
                <td>0.1600</td>
                <td>0.0080</td>
                <td>0.0100</td>
                <td>0.0200</td>
                <td>0.1000</td>
                <td>0.2000</td>
                <td>0.2000</td>
                <td>0.3000</td>
                <td>0.0500</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr><td colspan="20"><center>число случаев превышений  ПДК</center></td></tr>
            <tr>
                <td>Число случаев</td>
                <td id="pdkN"><script>countPdkN();</script></td>
                <td id="eachPdkN2"><script>countEachPdkN(2)</script></td>
                <td id="eachPdkN3"><script>countEachPdkN(3)</script></td>
                <td id="eachPdkN4"><script>countEachPdkN(4)</script></td>
                <td id="eachPdkN5"><script>countEachPdkN(5)</script></td>
                <td id="eachPdkN6"><script>countEachPdkN(6)</script></td>
                <td id="eachPdkN7"><script>countEachPdkN(7)</script></td>
                <td id="eachPdkN8"><script>countEachPdkN(8)</script></td>
                <td id="eachPdkN9"><script>countEachPdkN(9)</script></td>
                <td id="eachPdkN10"><script>countEachPdkN(10)</script></td>
                <td id="eachPdkN11"><script>countEachPdkN(11)</script></td>
                <td id="eachPdkN12"><script>countEachPdkN(12)</script></td>
                <td id="eachPdkN13"><script>countEachPdkN(13)</script></td>
                <td id="eachPdkN14"><script>countEachPdkN(14)</script></td>
                <td id="eachPdkN15"><script>countEachPdkN(15)</script></td>
                <td id="eachPdkN16"><script>countEachPdkN(16)</script></td>
                <td id="eachPdkN17"><script>countEachPdkN(17)</script></td>
                <td id="eachPdkN18"><script>countEachPdkN(18)</script></td>
                <td id="eachPdkN19"><script>countEachPdkN(19)</script></td>
            </tr>
            </table>
            <br>
            <br>
            <table id="table3" width="220" border="1">
                <tr><td colspan="2">Расчетная матрица для "ПДК" </td></tr>
                <tr><th>P</th><th>СИ</th></tr>
                <tr>
                    <td id="calP"><script>calP();</script></td>
                    <td id="calSI"><script>calSI();</script></td>
                </tr>              
            </table>
  </div>
            <script type="text/javascript" src="../js/indicator.js"></script>
            <script type="text/javascript" src="https://www.google.com/jsapi"></script>
            <script type="text/javascript" src="../js/chart.js"></script>
    <center> <select style="width: 500px;" class="class-select" id="chartSelect" onchange="drawCharts()">
                <option value="2">Взвешенные частицы (пыль)</option>
                <option value="3">Диоксид серы</option>
                <option value="4">Сульфаты растворимые</option>
                <option value="5">Оксид углерода</option>
                <option value="6">Диоксид азота</option>
                <option value="7">Оксид азота</option>
                <option value="8">Озон</option>
                <option value="9">Сероводород</option>
                <option value="10">Фенол</option>
                <option value="11">Фтористый водород</option>
                <option value="12">Хлор</option>
                <option value="13">Хлористый водород</option>
                <option value="14">Аммиак</option>
                <option value="15">Серная кислота и сульфаты</option>
                <option value="16">Формальдегид</option>
                <option value="17">Неорганические соединения мышьяка</option>
                <option value="18">Хром шестивалентный</option>
                <option value="19">Суммарные углеводороды</option>
        </select></center>
            <div class="chart">
                <h2>Диаграмма по ПНЗ</h2>
                <h5 id="optionName"></h5>
                <div id="bar-chart"></div>
                <div id="png"></div>
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
