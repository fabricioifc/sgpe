var dataTable = null;

document.addEventListener("turbolinks:before-cache", function() {
  if (dataTable !== null) {
    dataTable.destroy();
    dataTable = null;
  }
});

document.addEventListener("turbolinks:load", function() {

  var dataTableId = "table[id='coordenadors_datatable']";

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
          width: "25%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "19%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "11%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "7%",
          className: "",
          searchable: false,
          orderable: false
        },
        {
          width: "7%",
          className: "",
          searchable: false,
          orderable: false
        },
        {
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "11%",
          className: "text-center",
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
