$(document).on('turbolinks:before-visit', function(e) {
  if ($('form#plans_form').length > 0) {
    if ($('form#plans_form').serialize() != $('form#plans_form').data('serialize')) {
      console.log(e);
      var message = "Existem alterações não salvas nesta página."
      if (!confirm(message)) {
        return e.preventDefault();
      }
    }
  }
});

document.addEventListener("turbolinks:load", function(e) {
  if ($('form#plans_form').length > 0) {
    $('form#plans_form').data('serialize', $('form#plans_form').serialize());
    console.log($('form#plans_form').data('serialize'));
  } else {
    $('form#plans_form').data('serialize', null);
  }

  $.checarPaineis();

  var dataTableId = "table[id='plans_datatable']";

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
      // order: [[ 6, "asc" ]],

      columns: [
        {
          width: "8%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "37%",
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
          width: "5%",
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

// seta o foco no primeiro textarea da tela
$(document).on('shown.bs.tab', 'ul.nav-tabs li a', function(event){
  var target = event.target.attributes.href.value;
  $(target +' textarea').eq(0).focus();

});
