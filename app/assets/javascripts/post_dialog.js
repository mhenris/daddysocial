$(function() {
  $('#post_dialog').dialog({
    modal: true,
    width: 560,
    height: 500,
    resizable: false,
    autoOpen: false,
    show: 'fade',
    hide: 'fade'
  });

  $(".view_post").click(function() {
    $.getScript(this.href);
    return false;
  });
});

