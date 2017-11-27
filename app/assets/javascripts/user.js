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
          width: "20%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "25%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "50%",
          className: "",
          searchable: false,
          orderable: false
        },
        {
          width: "5%",
          className: "text-center",
          searchable: false,
          orderable: false
        },
      ],
      // order: [[1, 'asc']]

    });
  });

});
