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
    if (session.getAttribute("adminSession") == null) {
        response.sendRedirect("login.jsp");
    } else if (session.getAttribute("adminSession").equals("admin") || session.getAttribute("adminSession").equals("user")) {
        user = (String) session.getAttribute("emailSession");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
<head>
    <meta charset="utf-8">
    <title>Qazgidromet</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

</head>
<body>
    <header>
        <div class="container text-center">
            <div class="fh5co-navbar-brand">
                <a class="fh5co-logo" href="">Qazgidromet</a>
                <div style="text-align: right"><a><%=user%></a></div>
                <div style="text-align: right"><a href="<%=request.getContextPath()%>/LogoutController">Выйти</a></div>
            </div>
            <nav id="fh5co-main-nav" role="navigation">
                <ul>
                    <li><a href="" class="active">Главная</a></li>
                        <%
                                            if (session.getAttribute("adminSession") != null) {
                                                if (session.getAttribute("adminSession").equals("admin")) {%>
                    <li><a href="<%=request.getContextPath()%>/jsp/admin.jsp" class="">Админ</a></li>
                        <%}
                            }
                        %>
                </ul>
            </nav>
        </div>
    </header>

    <div class="heading-section text-center">
        <h2>Неблагоприятные метеорологические условия</h2>
    </div>
    <div class="row about">
        <div class="col-md-10 col-md-offset-1">
            <div class="col-md-6 col-sm-6 services-num services-num-text-right">
                <span class="number-holder">
                    <svg width="200px" height="290px" viewBox="0 0 145 360" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g id="tube2">
                    <path d="M30.4995435,83.0004 L40.1663913,85.4909222 L2.21163043,232.179811 C-0.60373913,243.066678 0.994086957,254.387233 6.7111087,264.065511 C12.4345217,273.746978 21.5900652,280.622222 32.4936304,283.428444 L37.523587,284.729511 C41.0451957,285.638344 44.5763913,286.072033 48.0596522,286.072033 C66.8149348,286.072033 83.9787826,273.459978 88.8841087,254.5116 L126.83887,107.8259 L136.505717,110.3228 L142.603022,86.7664778 L36.5904565,59.4504556 L30.4995435,83.0004 Z M62.200413,91.1735222 L104.824022,102.152867 L100.493913,118.862644 L55.0293696,118.862644 L62.200413,91.1735222 Z M94.6266957,141.564344 L89.5136522,161.335456 L75.2898043,157.6778 L69.6047391,179.652433 L83.8221957,183.316467 L78.0668261,205.565344 L63.8493696,201.901311 L58.157913,223.875944 L72.3753696,227.546356 L66.8628696,248.848133 C64.1913043,259.186511 53.5817391,265.436733 43.2150435,262.761256 L38.1786957,261.457 C33.1615217,260.1655 28.9464565,256.998933 26.3132391,252.537678 C23.686413,248.085989 22.9418261,242.872156 24.2424565,237.859222 L49.1653478,141.561156 L94.6266957,141.561156 L94.6266957,141.564344 Z" id="base"></path>
                    <ellipse id="bubble-one" cx="120.185522" cy="66.2778667" rx="5.58919565" ry="5.57736667"></ellipse>
                    <path d="M92.9106304,41.4045333 C97.2247609,41.4045333 100.724,37.9158889 100.724,33.6077 C100.724,29.2931333 97.2215652,25.8076778 92.9106304,25.8076778 C88.5837174,25.8076778 85.0844783,29.2963222 85.0844783,33.6077 C85.0844783,37.9190778 88.5837174,41.4045333 92.9106304,41.4045333 L92.9106304,41.4045333 Z" id="bubble-two"></path>
                    <ellipse id="bubble-three" cx="133.840543" cy="11.193" rx="10.29" ry="10.2682222"></ellipse>
                    </g>
                    </svg>
                </span>
                <div class="desc">
                    <h3>Параметр Р </h3>
                    <p>– это интегральный показатель загрязнения воздуха в городе, который является частотной характеристикой и представляет собой отношение числа существенно повышенных концентраций примесей в воздухе, измеренных в течение дня, к общему числу измерений в течение этого же дня. </p>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 services-num">
                <span class="number-holder">
                    <svg width="200px" height="290px" viewBox="0 0 145 360" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                    <g id="tube3">
                    <path d="M30.4995435,83.0004 L40.1663913,85.4909222 L2.21163043,232.179811 C-0.60373913,243.066678 0.994086957,254.387233 6.7111087,264.065511 C12.4345217,273.746978 21.5900652,280.622222 32.4936304,283.428444 L37.523587,284.729511 C41.0451957,285.638344 44.5763913,286.072033 48.0596522,286.072033 C66.8149348,286.072033 83.9787826,273.459978 88.8841087,254.5116 L126.83887,107.8259 L136.505717,110.3228 L142.603022,86.7664778 L36.5904565,59.4504556 L30.4995435,83.0004 Z M62.200413,91.1735222 L104.824022,102.152867 L100.493913,118.862644 L55.0293696,118.862644 L62.200413,91.1735222 Z M94.6266957,141.564344 L89.5136522,161.335456 L75.2898043,157.6778 L69.6047391,179.652433 L83.8221957,183.316467 L78.0668261,205.565344 L63.8493696,201.901311 L58.157913,223.875944 L72.3753696,227.546356 L66.8628696,248.848133 C64.1913043,259.186511 53.5817391,265.436733 43.2150435,262.761256 L38.1786957,261.457 C33.1615217,260.1655 28.9464565,256.998933 26.3132391,252.537678 C23.686413,248.085989 22.9418261,242.872156 24.2424565,237.859222 L49.1653478,141.561156 L94.6266957,141.561156 L94.6266957,141.564344 Z" id="base"></path>
                    <ellipse id="bubble-one" cx="120.185522" cy="66.2778667" rx="5.58919565" ry="5.57736667"></ellipse>
                    <path d="M92.9106304,41.4045333 C97.2247609,41.4045333 100.724,37.9158889 100.724,33.6077 C100.724,29.2931333 97.2215652,25.8076778 92.9106304,25.8076778 C88.5837174,25.8076778 85.0844783,29.2963222 85.0844783,33.6077 C85.0844783,37.9190778 88.5837174,41.4045333 92.9106304,41.4045333 L92.9106304,41.4045333 Z" id="bubble-two"></path>
                    <ellipse id="bubble-three" cx="133.840543" cy="11.193" rx="10.29" ry="10.2682222"></ellipse>
                    </g>
                    </svg>
                </span>
                <div class="desc">
                    <h3>Выверите город</h3>
                    <ul style="list-style-type:disc; width: 300px; height: 300px; overflow: auto; border: 1px solid #ddd;">
                        <%
                            request.setCharacterEncoding("UTF-8");
                            int year = Year.now().getValue();
                            PnzDao pnzDao = new PnzDao();
                            CityDao cityDao = new CityDao();
                            List<City> list = cityDao.listCitis();
                            for (City c : list) {
                                List<Pnz> list1 = pnzDao.listPnzs(c.getCityId());
                                if (list1.size() != 0) {
                        %>
                        <li><a href="<%=request.getContextPath()%>/jsp/pnzdata.jsp?cityId=<%=c.getCityId()%>&cityName=<%=c.getCityName()%>&pnzId=<%=list1.get(0).getPnzId()%>&pnzName=<%=list1.get(0).getPnzName()%>&month=1&year=<%=year%>"><%=c.getCityName()%></a></li>
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
                        <p>Научно-исследовательский центр РГП <a href="https://kazhydromet.kz/kk" target="_blank">"Казгидромет"</a>.<br>Made by students of <a href="http://iitu.kz" target="_blank">IITU</a> 
                    </div>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>


