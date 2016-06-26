$(document).ready(function() {
  $("#search_result").hide();
});

function showResult(str) {
  if (str.length == 0) {
    $("#search_result").innerHTML = "";
    $("#search_result").hide();
    return;
  } else {
    $("#search_result").show();
  }
  $.ajax({
    url: "/diablo/search",
    type: 'GET',
    data: {
      query: str
    },
    dataType: 'json',
    success: function(data) {
      result = [];
      $.each(data, function(index, val) {
        result.push("<a href='careers?battle_tag=" + escape(val) + "' class='list-group-item'>" + val + "</a>")
      });
      $("#search_result").empty();
      $("#search_result").append(result);
      document.getElementById("search_result").style.border = "1px solid #A5ACB2";
    }
  });
}
