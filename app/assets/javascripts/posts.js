$(document).on('turbolinks:load', function(){
  $("table[role='datatable']").each(function(){
    $(this).DataTable({
      processing: true,
      serverSide: true,
      ajax: $(this).data('url'),
      "language": {
          "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Portuguese-Brasil.json"
      }

    });
  });
});
