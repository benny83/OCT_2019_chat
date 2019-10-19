$(document).on('ready', function() {
  $('#chat_area').on('keypress', function(e) {
    if (e.which == 13) {
      $(this).closest('form').submit();
    }
  });
});
