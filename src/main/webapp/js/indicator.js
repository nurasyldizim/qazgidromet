/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// JS is for prototype examples only, this will not be in the production code

// Fill range:
// -90, -75, -50, -25, 0, 25, 75, 90
var table = document.getElementById("table3");
var fill = table.rows[2].cells[0].innerHTML;
var count90min = 90;
var count90plus = 0;
for (i = 0; i < 1; i+=0.0055555556) { 
    if(fill==0){
        fill=count90min*-1;
        break;
    }else if(fill==1){
        fill = count90plus;
        break;
    }
    if(count90min>0){
        count90min--;
        if(i<fill && fill<i+0.0055555556){
            fill=count90min*-1;
            break;
        }
    }else if(count90plus<90){
        if(i<fill && fill<i+0.0055555556){
            fill=count90plus;
            break;
        }
        count90plus++;
    }
}
var meter = document.getElementById("js-meter");

meter.className = meter.className + " fill-" + fill + " fill-lump-" + fill;