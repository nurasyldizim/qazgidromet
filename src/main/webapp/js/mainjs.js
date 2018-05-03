/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function calP(){
    var table = document.getElementById("table"), rows = parseInt(table.rows.length), p = parseFloat(parseFloat(table.rows[rows-3].cells[1].innerHTML)/parseFloat(table.rows[rows-3].cells[0].innerHTML));
    if(isNaN(p)){
            document.getElementById("calP").innerHTML = 0;
        }else{
            document.getElementById("calP").innerHTML = p;
        }
 }
 
function calSI(){
    var table = document.getElementById("table2"), columns=parseInt(table.rows[2].cells.length),
                rows = parseInt(table.rows.length), si = 0;
        for(var c = 2; c<columns; c++){
            for(var r = 2; r<rows-3; r++){
                if(parseFloat(table.rows[r].cells[c].innerHTML)>si){
                    si = parseFloat(table.rows[r].cells[c].innerHTML);
                }
            }
        }
    if(isNaN(si)){
            document.getElementById("calSI").innerHTML = "";
        }else{
            document.getElementById("calSI").innerHTML = si;
        }
 }
 
function countPdkN(){
    var table = document.getElementById("table2"), columns=parseInt(table.rows[2].cells.length),
                rows = parseInt(table.rows.length), n = 0;
        for(var c = 2; c<columns; c++){
            for(var r = 2; r<rows-3; r++){
                if(parseFloat(table.rows[r].cells[c].innerHTML)>1){
                    n++;
                }
            }
        }
    if(isNaN(n)){
            document.getElementById("pdkN").innerHTML = "";
        }else{
            document.getElementById("pdkN").innerHTML = n;
        }
 }
 
 function countEachPdkN(cell){
    var table = document.getElementById("table2"), rows = parseInt(table.rows.length), n = 0;
            for(var r = 2; r<rows-3; r++){
                if(parseFloat(table.rows[r].cells[cell].innerHTML) >1)
                    n++;
            }
    if(isNaN(n)){
            document.getElementById("eachPdkN"+cell).innerHTML = "";
        }else{
            document.getElementById("eachPdkN"+cell).innerHTML = n;
        }
 }


function calPDK(i,id){
    var table = document.getElementById("table"), data = parseFloat(table.rows[i+2].cells[id-1].innerHTML), pdk = parseFloat(table.rows[table.rows.length-1].cells[id-1].innerHTML);  

    if(isNaN(parseFloat(data/pdk))){
            document.getElementById(cell+"countEachM").innerHTML = "";
        }else{
           document.getElementById(String(id)+String(i)).innerHTML = parseFloat(data/pdk);
        }
 }

function showTableData(i,id){
    var table = document.getElementById("table"), data = table.rows[i+2].cells[id-1].innerHTML;
            document.getElementById(String(id)+String(i)).innerHTML = data;
 }

function countEachM(cell){
    var table = document.getElementById("table"), rows = parseInt(table.rows.length), m = 0;
            for(var r = 2; r<rows-7; r++){
                if(parseFloat(table.rows[r].cells[cell].innerHTML) >= parseFloat(table.rows[rows-3].cells[cell].innerHTML))
                    m++;
            }
    if(isNaN(m)){
            document.getElementById(cell+"countEachM").innerHTML = "";
        }else{
            document.getElementById(cell+"countEachM").innerHTML = m;
        }
 }

function countM(){
    var table = document.getElementById("table"), columns=parseInt(table.rows[2].cells.length),
                rows = parseInt(table.rows.length), m = 0;
        for(var c = 2; c<columns; c++){
            for(var r = 2; r<rows-7; r++){
                if(parseFloat(table.rows[r].cells[c].innerHTML) >= parseFloat(table.rows[rows-3].cells[c].innerHTML))
                    m++;
            }
        }
    if(isNaN(m)){
            document.getElementById("mValue").innerHTML = "";
        }else{
            document.getElementById("mValue").innerHTML = m;
        }
 }

function countN(){
    var table = document.getElementById("table"), columns=parseInt(table.rows[2].cells.length)-2,
                rows = parseInt(table.rows.length)-9, n = columns*rows;
    if(isNaN(n)){
            document.getElementById("nValue").innerHTML = "";
        }else{
            document.getElementById("nValue").innerHTML = n;
        }
 }

function qAvg15(cell){
    var table = document.getElementById("table"), qAvg=0; 
    qAvg = 1.5*parseFloat(table.rows[table.rows.length-2].cells[cell].innerHTML);
        if(isNaN(parseFloat(qAvg))){
            document.getElementById(cell+"qAvg15").innerHTML = "";
        }else{
            document.getElementById(cell+"qAvg15").innerHTML = qAvg;
        }
 }


function calculateQMinToP(cell){
    var table = document.getElementById("table"), minVal = parseFloat(table.rows[2].cells[cell].innerHTML);   
    for(var i = 2; i < table.rows.length-2; i++){
            if(minVal > parseFloat(table.rows[i].cells[cell].innerHTML))
            minVal = parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(minVal))){
            document.getElementById(cell+"min").innerHTML = "";
        }else{
            document.getElementById(cell+"min").innerHTML = minVal;
        }
 }
 
function calculateQMaxToP(cell){
    var table = document.getElementById("table"), maxVal = parseFloat(table.rows[2].cells[cell].innerHTML);   
    for(var i = 2; i < table.rows.length-1; i++){
            if(maxVal < parseFloat(table.rows[i].cells[cell].innerHTML))
            maxVal = parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(maxVal))){
            document.getElementById(cell+"max").innerHTML = "";
        }else{
            document.getElementById(cell+"max").innerHTML = maxVal;
        }
 }

 function calculateQAvgToP(cell){
    var table = document.getElementById("table"), sumVal = 0, rowCount = table.rows.length - 5;
        for(var i = 2; i < table.rows.length-3; i++){
            sumVal = sumVal + parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(sumVal / rowCount))){
            document.getElementById(cell+"id").innerHTML = "";
        }else{
            document.getElementById(cell+"id").innerHTML = parseFloat(sumVal / rowCount);
        }
 }

 function calculateQAvg(cell){
    var table = document.getElementById("table"), sumVal = 0, rowCount = table.rows.length - 2;
        for(var i = 1; i < table.rows.length-1; i++){
            sumVal = sumVal + parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(sumVal / rowCount))){
            document.getElementById(cell+"id").innerHTML = "";
        }else{
            document.getElementById(cell+"id").innerHTML = parseFloat(sumVal / rowCount);
        }
 }

function calculateAvgAll(cell){
    var table = document.getElementById("table"), sumVal = 0, rowCount = table.rows.length - 2;
        for(var i = 1; i < table.rows.length-1; i++){
            sumVal = sumVal + parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(sumVal / rowCount))){
            document.getElementById(cell+"id").innerHTML = "";
        }else{
            document.getElementById(cell+"id").innerHTML = parseFloat(sumVal / rowCount);
        }
 }

 function calculateAvg(cell, pnz){
    var table = document.getElementById("table"+pnz), sumVal = 0, rowCount = table.rows.length - 2;
        for(var i = 1; i < table.rows.length-1; i++){
            sumVal = sumVal + parseFloat(table.rows[i].cells[cell].innerHTML);
        }
        if(isNaN(parseFloat(sumVal / rowCount))){
            document.getElementById(cell+"id"+pnz).innerHTML = "";
        }else{
            document.getElementById(cell+"id"+pnz).innerHTML = parseFloat(sumVal / rowCount);
        }
 }
 
  
function refreshFunction(cityId) {
    var pnzList = document.getElementById("pnzListId");
    var pnzId = pnzList.options[pnzList.selectedIndex].value;
    var pnzName = encodeURIComponent(pnzList.options[pnzList.selectedIndex].text);
    location.href = "pnzdata.jsp?pnzId=" + pnzId +"&pnzName=" + pnzName + "&month=1" +"&cityId="+cityId;
    }

function refreshFunctionMonth(pnzId, pnzName, cityId) {
    var monthList = document.getElementById("monthListId");
    var month = monthList.options[monthList.selectedIndex].value;
    location.href = "qaverage.jsp?month="+month+"&pnzId="+pnzId+"&pnzName="+pnzName+"&cityId="+cityId;
    }

 
function selectMonth(hrefMonth){
    location.href = hrefMonth;
}
function getEditConfirmation(id){
    var retVal = confirm("Вы действительно хотите изменить этот запись?");
    if( retVal == true ){
        var f=document.frm;
         f.method="post";
         f.action='../PnzDataController?id='+id;
         f.submit();
       return true;
    }
    else{
       return false;
    }
 }
 
 function getDeleteConfirmation(id){
    var retVal = confirm("Вы действительно хотите удалить этот запись?");
    if( retVal == true ){
         var f=document.frm;
         f.method="post";
         f.action='../PnzDataController?id='+id;
         f.submit();
       return true;
    }
    else{
       return false;
    }
 }
 