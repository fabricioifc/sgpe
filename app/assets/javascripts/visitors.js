document.addEventListener("turbolinks:load", function(e) {
  var dataTableId = "table[id='planos_pesquisar_datatable']";

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
          width: "40%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "8%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "8%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "34%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "",
          searchable: true,
          orderable: true
        },
      ],
      // order: [[1, 'asc']]

    });
  });

});
