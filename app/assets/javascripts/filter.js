$( document ).ready(function(){
  $('#search').on('keyup', filterText)
  $('#filter-unread').on('click', filterUnread)
  $('#filter-read').on('click', filterRead)
  $('#show-everything').on('click', showItAll)

})

function filterText(event) {
  event.preventDefault();
  var filter = $( "#search" ).val().toLowerCase();
  $(".card").each(function(){
    var data = $(this).find('.link-title').context.innerText
    if (data.includes(filter)) {
      $(this).show()
    } else {
      $(this).hide()
    };
  });
}

function filterUnread() {
  $('.card').each(function() {
    var readStatus = $(this).find(".mark-read").html();
    if (readStatus.includes("Mark as Read")) {
      $(this).show()
    }  else {
      $(this).hide()
    };
  });
}

function filterRead() {
  $('.card').each(function() {
    var readStatus = $(this).find(".mark-read").html();
    if (readStatus.includes("Mark as Unread")) {
      $(this).show()
    }  else {
      $(this).hide()
    };
  });
}

function showItAll() {
  $('.card').each(function() {
    $(this).show();
  });
}
