// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require select2
// require select2-full
//= require dropdown
// require bootstrap
//= require datatables
//= require datatables/dataTables.bootstrap
//= require tinymce
//= require cocoon
//= require summernote
//= require summernote/locales/pt-BR
//= require_tree .

$(function() {
  $(document.body).off('click', 'nav.pagination a');
  $(document.body).on('click', 'nav.pagination a', function(e) {
    e.preventDefault();
    var loadingHTML = "<div class='loading'>Carregando...</div>";
    $("table.datatable").html(loadingHTML).load($(this).attr("href"));
    return false;
  });
});

// Função utilizada para adicionar editor HTML em textarea com data-provider = summernote
$.addSummernote = function(){
  // $('[data-provider="summernote"]').each(function() {
    $('[data-provider="summernote"]').summernote({
      lang: 'pt-BR',
      height: 200,
      toolbar: [
        ['insert', ['link']], // no insert buttons
        // ["style", ["style"]],
        // ["color", ["color"]],
        ["style", ["bold", "italic", "underline", "clear"]],
        // ["para", ["ul"]],
        // ["height", ["height"]],
        ["help", ["help"]]
     ]
    });
  // });
};

document.addEventListener("turbolinks:load", function() {

  var $cache = $('.fixed-on-scroll');

  if ($cache.length > 0) {

    var vTop = $($cache).offset().top - parseFloat($($cache).css('margin-top').replace(/auto/, 0));

    $(window).scroll(function (event) {
      // pega a posição atual (vertical) da tela
      var y = $(this).scrollTop();

      // Se a posição for maior que o elemento adiciona a classe stuck,
      // caso contrário remove a mesma classe
      if (y >= vTop) {
        $($cache).addClass('stuck');
      } else {
        $($cache).removeClass('stuck');
      }
    });

  }

});
