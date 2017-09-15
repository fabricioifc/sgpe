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

document.addEventListener("turbolinks:load", function() {

  $(document).on('click', 'a#expand_all', function(e){
    $('.panel-collapse.collapse').collapse('show');
    e.preventDefault();
  });

  $(document).on('click', 'a#collapse_all', function(e){
    $('.panel-collapse.collapse.in').collapse('hide');
    e.preventDefault();
  });

  $(document).on('click', 'a.trigger', function(){
    $('.panel-collapse.collapse.in').collapse('hide');
    $(this).find('div.panel-collapse').collapse('show');
  });

  $('#grid_disciplines').on('cocoon:after-insert', function(e, insertedItem) {
    $('.panel-collapse.collapse.in').collapse('hide');
    var lastPanel = null;
    $("#grid_disciplines .panel").each(function (k, v) {
      $(v).find('a[role="button"]').attr('href', '#collapse' + k);
      $(v).find('div.panel-collapse').attr('id', 'collapse' + k);
      lastPanel = v;
    });
    $(lastPanel).find('div.panel-collapse').collapse('show');

  });

  $('.panel-collapse.collapse').collapse('show');

});
