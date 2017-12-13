document.addEventListener("turbolinks:load", function(e) {
  // $("#accordion").find('a.trigger:first').click();
  // var link = "a[data-ano=" + new Date().getFullYear() + "]";
  // $("#accordion").find('a[data-abrir="true"]').click();

  $.checarPaineis();

  var dataTableId = "table[id='plans_datatable']";

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
      // order: [[ 6, "asc" ]],

      columns: [
        {
          width: "25%",
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
          width: "7%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "18%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "10%",
          className: "text-center",
          searchable: false,
          orderable: false
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

  var dataTableId = "table[id='plans_user_datatable']";

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
      // order: [[ 6, "asc" ]],

      columns: [
        {
          width: "25%",
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
          width: "7%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "18%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "10%",
          className: "text-center",
          searchable: false,
          orderable: false
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

$.checarPaineis = function(){
  var existe_planos_ano_atual = false;
  $("#accordion").find('a.trigger').each(function(){
    if ($(this).data('abrir') == true) {
      existe_planos_ano_atual = true;
      $.abrirPainel(this);
      return false;
    }
  });

  if (existe_planos_ano_atual == false) {
    $.abrirPainel($("#accordion").find('a.trigger:first'));
  }

  $('.panel-collapse').on('show.bs.collapse', function () {
    $(this).siblings('li.list-group-item').find('span > i').removeClass('fa-arrow-right fa-arrow-down');
    $(this).siblings('li.list-group-item').find('span > i').addClass('fa-arrow-down');
  });

  $('.panel-collapse').on('hide.bs.collapse', function () {
    $(this).siblings('li.list-group-item').find('span > i').removeClass('fa-arrow-right fa-arrow-down');
    $(this).siblings('li.list-group-item').find('span > i').addClass('fa-arrow-right');
  });
};

$.abrirPainel = function(painel) {
  $(painel).parent().find('span > i').removeClass('fa-arrow-right fa-arrow-down');
  $(painel).parent().find('span > i').addClass('fa-arrow-down');
  $(painel).click();
  // $(painel).parent().parent().find('div.panel-collapse').collapse('show');
};
