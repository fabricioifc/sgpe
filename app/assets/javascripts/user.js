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

$(document).on('click', 'a#user_token_action', function(){
  $("span#user_token").show();
  $(this).hide();
  return false;
});


// DATATABLE >>>>>
var dataTable = null;

document.addEventListener("turbolinks:before-cache", function() {
  if (dataTable !== null) {
    dataTable.destroy();
    dataTable = null;
  }
});

document.addEventListener("turbolinks:load", function() {

  $.avatar_toggle = $('div.avatar_toggle');
  $.password_toggle = $('div.password_toggle');
  $.password_toggle.css('display', 'none');

  var dataTableId = "table[id='users_datatable']";

  $(dataTableId).each(function(){
    dataTable = $(this).DataTable({
      autoWidth: false,
      responsive: true,
      destroy: true,
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      "language": {
          "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Portuguese-Brasil.json"
      },
      "drawCallback": function( settings ) {
        $( ".select2" ).select2({
          theme: "bootstrap"
        });
      },

      columns: [
        {
          width: "40%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "20%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "30%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "10%",
          className: "text-center",
          searchable: false,
          orderable: false
        },
      ],
      // order: [[1, 'asc']]

    });
  });

});
