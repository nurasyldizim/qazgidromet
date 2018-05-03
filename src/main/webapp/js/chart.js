/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawCharts);
function drawCharts() {
    var barDataTemp = [
    ['Day', 'ПНЗ1', 'ПНЗ2', 'ПНЗ3','ПНЗ4', 'ПНЗ5'],
    ['1:00',  0,  0, 0, 0, 0],
    ['7:00',  0,  0, 0, 0, 0],
    ['13:00',  0,  0, 0, 0, 0],
    ['19:00',  0,  0, 0, 0, 0]
  ];
var selectChart = document.getElementById("chartSelect");
var columnNumber = selectChart.options[selectChart.selectedIndex].value;
document.getElementById("optionName").innerHTML = selectChart.options[selectChart.selectedIndex].value;;
var table = document.getElementById("table"),rows = parseInt(table.rows.length);
            for(var r = 2; r<rows-8; r++){

                switch (table.rows[r].cells[0].innerHTML+table.rows[r].cells[1].innerHTML) {
                    case "ПНЗ11:00":
                        barDataTemp[1][1] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ17:00":
                        barDataTemp[2][1] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ113:00":
                        barDataTemp[3][1] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ119:00":
                        barDataTemp[4][1] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ21:00":
                        barDataTemp[1][2] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ27:00":
                        barDataTemp[2][2] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ213:00":
                        barDataTemp[3][2] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ219:00":
                        barDataTemp[4][2] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ31:00":
                        barDataTemp[1][3] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ37:00":
                        barDataTemp[2][3] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ313:00":
                        barDataTemp[3][3] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ319:00":
                        barDataTemp[4][3] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ41:00":
                        barDataTemp[1][4] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ47:00":
                        barDataTemp[2][4] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ413:00":
                        barDataTemp[3][4] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ419:00":
                        barDataTemp[4][4] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ51:00":
                        barDataTemp[1][5] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ57:00":
                        barDataTemp[2][5] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ513:00":
                        barDataTemp[3][5] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break;
                    case "ПНЗ519:00":
                        barDataTemp[4][5] = parseFloat(table.rows[r].cells[columnNumber].innerHTML);
                        break; 
                    default :
}
        }
         var barData = google.visualization.arrayToDataTable(barDataTemp);
  var barOptions = {
    focusTarget: 'category',
    backgroundColor: 'transparent',
    colors: ['cornflowerblue','Yellow','tomato', 'ForestGreen','DarkSlateGrey'],
    fontName: 'Open Sans',
    chartArea: {
      left: 50,
      top: 10,
      width: '100%',
      height: '70%'
    },
    bar: {
      groupWidth: '80%'
    },
    hAxis: {
      textStyle: {
        fontSize: 11
      }
    },
    vAxis: {
      minValue: 0,
      maxValue: 1,
      baselineColor: '#DDD',
      gridlines: {
        color: '#DDD',
        count: 10
      },
      textStyle: {
        fontSize: 11
      }
    },
    legend: {
      position: 'bottom',
      textStyle: {
        fontSize: 12
      }
    },
    animation: {
      duration: 1200,
      easing: 'out',
			startup: true
    }
  };
  // draw bar chart twice so it animates
  var barChart = new google.visualization.ColumnChart(document.getElementById('bar-chart'));
  //barChart.draw(barZeroData, barOptions);
  barChart.draw(barData, barOptions);
  google.visualization.events.addListener(chart, 'ready', function() {
            console.log(chart.getChart().getImageURI());
                document.getElementById('png').innerHTML = '<a href="' + chart.getChart().getImageURI() + '">Printable version</a>';
        });
}
