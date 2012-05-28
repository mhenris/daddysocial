$(function() {
  $('#ajax_message').dialog({
    modal: true,
    width: 400,
    height: 160,
    resizable: false,
    autoOpen: false,
    show: 'fade',
    hide: 'fade'
  })
  $('#map').dialog({
    modal: true,
    width: 700,
    height: 500,
    resizable: false,
    autoOpen: false,
    show: 'fade',
    hide: 'fade'
  })
  $('#tabs').tabs({
    select: function(event, ui) {                   
      window.location.replace(ui.tab.hash);
    }
  });
});

function showAjaxMessage(words) {
  $("#ajax_message").dialog("open");
}

function mapUser(url) {
  $("#map").dialog("open");
  $("#iframe").attr("src",url);
  return false;
}
