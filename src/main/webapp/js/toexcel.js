/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//export table to excel
      function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
      var dateValue = getParameterByName('date');
function generateExcel() {
    //getting data from our table
    var data_type = 'data:application/vnd.ms-excel';
    var table_div1 = document.getElementById('table');
    var table_div2 = document.getElementById('table2');
    var table_div3 = document.getElementById('table3');
    var table_html = (table_div1.outerHTML+table_div2.outerHTML+table_div3.outerHTML).replace(/ /g, '%20').replace(/\./g, ',');
    //var table_html = table_div1.outerHTML.replace(/ /g, '%20').replace(/\./g, ',');
      while (table_html.indexOf('о') != -1) table_html = table_html.replace('о', '&#1086;');
    var a = document.createElement('a');
    a.href = data_type + ', ' + table_html;
    a.download = dateValue;
    a.click();
}