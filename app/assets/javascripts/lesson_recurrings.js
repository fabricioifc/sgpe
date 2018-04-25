document.addEventListener("turbolinks:load", function() {
  $(document).on('click', '.change-checked', function(){
    var cb = $(this).find('input[type="checkbox"]');
    $(cb).attr('checked', !cb.attr("checked"));
    if (cb.attr("checked")) {
      $(this).addClass('btn-success');
    } else {
      $(this).removeClass('btn-success');
    }
  });
});
