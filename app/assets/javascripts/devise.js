$(document).on('turbolinks:load', function(e) {
  $("#undestand").click(function () {
      $("#delete").attr("disabled", !this.checked);
  });
});