var dataTable = null;

document.addEventListener("turbolinks:before-cache", function() {
  if (dataTable !== null) {
    dataTable.destroy();
    dataTable = null;
  }
});

document.addEventListener("turbolinks:load", function() {

  var dataTableId = "table[id='courses_datatable']";

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
          width: "5%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "15%",
          className: "text-center",
          searchable: true,
          orderable: true
        },
        {
          width: "10%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "5%",
          className: "",
          searchable: false,
          orderable: false
        },
        {
          width: "10%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "15%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "15%",
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