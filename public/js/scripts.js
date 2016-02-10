(function() {
  $('.complete-checkbox').on('change', function() {
    $(this).closest('form').submit();
  });
}())
