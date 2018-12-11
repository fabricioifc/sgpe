document.addEventListener("turbolinks:load", function(e) {
  var dataTableId = "table[id='planos_pesquisar_datatable']";

  $(dataTableId).each(function(){
    dataTable = $(this).DataTable({
      autoWidth: false,
      responsive: true,
      destroy: true,
      processing: true,
      serverSide: true,
      ajax: {
        url: $(this).data('url')
          // data: function(d) {
          //   d.curso_id = $('#curso_id').val();
          // }
      },
      "language": {
          "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Portuguese-Brasil.json"
      },
      // order: [[ 0, "asc" ]],

      columns: [
        {
          width: "30%",
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
        // {
        //   width: "8%",
        //   className: "",
        //   searchable: true,
        //   orderable: true
        // },
        {
          width: "32%",
          className: "",
          searchable: true,
          orderable: true
        },
        {
          width: "25%",
          className: "",
          searchable: false,
          orderable: false
        },
        {
          width: "5%",
          className: "",
          searchable: false,
          orderable: false
        },
      ],
      // order: [[1, 'asc']]

    });
  });

});
