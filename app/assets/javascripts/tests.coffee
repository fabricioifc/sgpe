$(document).on 'turbolinks:load', ->
  $('table[id="test_datatable"]').each ->
    $(this).DataTable
      processing: true
      serverSide: true
      ajax: $(this).data('url')
      'language': 'url': '//cdn.datatables.net/plug-ins/1.10.15/i18n/Portuguese-Brasil.json'
      columns: [
        {
          width: '10%'
          className: ''
          searchable: true
          orderable: true
        }
        {
          width: '45%'
          className: ''
          searchable: true
          orderable: true
        }
        {
          width: '5%'
          className: 'text-center'
          searchable: false
          orderable: false
        }
        {
          width: '5%'
          className: 'text-center'
          searchable: false
          orderable: false
        }
        {
          width: '5%'
          className: 'text-center'
          searchable: false
          orderable: false
        }
      ]
  return
return
