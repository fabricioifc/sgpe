var dataTable = null;

document.addEventListener("turbolinks:before-cache", function() {
  if (dataTable !== null) {
    dataTable.destroy();
    dataTable = null;
  }
});

document.addEventListener("turbolinks:load", function() {

  var dataTableId = "table[id='grids_datatable']";

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

      columns: [
        {
          width: "10%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "65%",
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

        {
          width: "5%",
          className: "text-center",
          searchable: false,
          orderable: false
        },
        {
          width: "5%",
          className: "text-center",
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

document.addEventListener("turbolinks:load", function(event) {

  $(document).on('click', 'a#expand_all', function(e){
    $('.panel-collapse.collapse').collapse('show');
    e.preventDefault();
  });

  $(document).on('click', 'a#collapse_all', function(e){
    $('.panel-collapse.collapse.in').collapse('hide');
    e.preventDefault();
  });

  $(document).on('click', 'a.trigger.collapsed', function(e){
    $('.panel-collapse.collapse.in').collapse('hide');
    var href = $(this).attr('href');
    $(href).collapse('show');
    // $(this).find('div.panel-collapse').collapse('show');
  });

  $('#grid_disciplines').on('cocoon:after-insert', function(event, insertedItem) {
    $.ajustarGridDisciplinasCocoon(event);
  });

  $.init(event);

});

// Ajusta os ids dos paineis, evitando ids duplicados dinamicamente
$.ajustarGridDisciplinasCocoon = function(event){
  $('.panel-collapse.collapse.in').collapse('hide');
  var lastPanel = null;
  $("#grid_disciplines .panel").each(function (k, v) {
    $(v).find('a[role="button"]').attr('href', '#collapse' + k);
    $(v).find('div.panel-collapse').attr('id', 'collapse' + k);
    lastPanel = v;
  });
  $(lastPanel).find('div.panel-collapse').collapse('show');

  $.addSummernote();

  event.preventDefault();
  return false;
};

// Carrega configurações padrões
$.init = function(event) {
  $.ajustarGridDisciplinasCocoon(event);
  // $('.panel-collapse.collapse:last').collapse('show');
};


// $('ul.nav.nav-tabs').each(function(k, v) {
//   var id = k;
//   $(this).children().each(function(k, v){
//     var href = $(v).find('a').attr('href');
//     var target = $(v).find('a').data('target');
//
//     $(v).find('a').attr('href', href + id)
//     $(v).find('a').attr('data-target', target + id)
//
//   });
// });
//
// $('div.tab-content').each(function(k, v) {
//   var id = k;
//   $(this).children().each(function(k, v){
//     var div = $(v).attr('id');
//     var textarea = $(v).find('textarea').attr('id');
//
//     $(v).attr('id', div + id);
//     $(v).find('textarea').attr('id', textarea + id);
//
//   });
// });

// $(document).on('blur', 'input.grid_discipline_year', function(e){
//
//   var year = $(this).val();
//   var discipline = $(this).closest('div.nested-fields').find('div.panel-body').find('select').find('option:selected').text();
//   var span_text = $(this).closest('div.nested-fields').find('h3.panel-title a span.grid_discipline_text');
//   if (year !== '' && discipline !== '') {
//       $(span_text).text(discipline + ' (' + year + ')');
//   } else {
//     $(span_text).text('');
//   }
//
//   e.preventDefault();
//   return false;
// });
