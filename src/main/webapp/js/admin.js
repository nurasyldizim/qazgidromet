/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('.pop-up').hide(0);
$('.pop-up-container').hide(0);
$('.pop-up-button').click(function(){
  $('.pop-up-container').show(0);
  $('.pop-up').fadeIn(300);
  $('.pop-up-button').hide(0);
});
$('.pop-up span').click(function() {
  $('.pop-up-container').hide(0);
  $('.pop-up').hide(0);
  $('.pop-up-button').show(0);
});

$('.pop-up-link').click(function(event){
    var id = event.target.id;  
    var name = document.getElementById ( "name"+id ).textContent;
    var surname = document.getElementById ( "surname"+id ).textContent;
    var work = document.getElementById ("work" +id).textContent;
    var email = document.getElementById ( "email"+id ).textContent;
    var password = document.getElementById ( "password"+id ).textContent;
    var admin = document.getElementById ( "admin"+id).textContent;
    document.getElementById("tbName").value = name;
    document.getElementById("tbSurname").value = surname;
    document.getElementById("tbWork").value = work;
    document.getElementById("tbEmail").value = email;
    document.getElementById("tbPwd1").value = password;
    document.getElementById("userId").value = id;
    document.getElementById("popHeader").innerHTML = "Изменить пользователя";
    document.getElementById("tbSumbit").value = "Изменить";
    if(admin == "Да"){
        document.getElementById("ioslide").checked = true;
    }else{
        document.getElementById("ioslide").checked = false;
    }
 
  $('.pop-up-container').show(0);
  $('.pop-up').fadeIn(300);
  $('.pop-up-link').hide(0);
});
$('.pop-up span').click(function() {
    document.getElementById("tbName").value = "";
    document.getElementById("tbSurname").value = "";
    document.getElementById("tbWork").value = "";
    document.getElementById("tbEmail").value = "";
    document.getElementById("tbPwd1").value = "";
    document.getElementById("userId").value = "";
    document.getElementById("popHeader").innerHTML = "Добавить нового пользователя";
    document.getElementById("tbSumbit").value = "Добавить";
    document.getElementById("ioslide").checked = false;
  $('.pop-up-container').hide(0);
  $('.pop-up').hide(0);
  $('.pop-up-link').show(0);
});

$('.pop-up-delete').click(function(event){
  var id = event.target.id; 
  var retVal = confirm("Вы действительно хотите удалить этого пользователя?");
    if( retVal == true ){
         var f=document.frm;
         f.method="post";
         f.action='../AdminController?id='+id+'&ACTION=Удалить';
         f.submit();
       return true;
    }
    else{
       return false;
    }
});