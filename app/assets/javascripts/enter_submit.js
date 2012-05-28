$(function() {
  $('.enter_submit').live("keypress", function(e) {
    if(e.which == 13) { $(this).parent("form").submit(); }
  })
});
