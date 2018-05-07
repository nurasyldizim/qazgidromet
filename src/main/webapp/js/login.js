/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(function() {
  $('a.scroll').on('click',function ( event ) {
    event.preventDefault();

    var $anchor  = $(this),
        $section = $anchor.attr('data-section');
    
    if ( $section === '3' ) {
      $('#wrap .wrap-inner').addClass('goto-' + '2');
    } else {
      $('#wrap .wrap-inner').removeClass('goto-2 goto-3');
    }
  });
});