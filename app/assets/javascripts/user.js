$(document).on('turbolinks:load', function() {

  // $( ".select2" ).select2({});


});

// permite que o usuário exclua seu avatar
$(document).on('click', 'a.btn-remove-image', function(){

  $.avatar_toggle = $('.avatar_toggle');

  $('#user_remove_avatar').click();
  $.avatar_toggle.toggle('fast');
  $(this).toggleClass('btn-danger btn-info');

  return false;
});
