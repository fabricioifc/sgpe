document.addEventListener("turbolinks:load", function() {
  // $("#accordion").find('a.trigger:first').click();
  // var link = "a[data-ano=" + new Date().getFullYear() + "]";
  // $("#accordion").find('a[data-abrir="true"]').click();

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

});

$.abrirPainel = function(painel) {
  $(painel).parent().find('span > i').removeClass('fa-arrow-right fa-arrow-down');
  $(painel).parent().find('span > i').addClass('fa-arrow-down');
  $(painel).click();
  // $(painel).parent().parent().find('div.panel-collapse').collapse('show');
};
