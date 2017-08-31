$(document).on('turbolinks:load', function() {

  $.avatar_toggle = $('div.avatar_toggle');
  $.password_toggle = $('div.password_toggle');
  $.password_toggle.css('display', 'none');

});

// permite que o usuário exclua seu avatar
$(document).on('click', 'a.btn-remove-image', function(){

  $('#user_remove_avatar').click();
  $.avatar_toggle.toggle('fast');
  $(this).toggleClass('btn-danger btn-info');

  if ($(this).find('span').text() == 'Excluir avatar') {
    $(this).find('span').text('Incluir avatar');
  } else {
    $(this).find('span').text('Excluir avatar');
  }

  return false;
});

$(document).on('click', 'a.btn-change-password', function(){

  $.password_toggle.toggle();
  $('input[type="password"]').first().focus();
  $(this).parent().parent().remove();

  return false;
});
