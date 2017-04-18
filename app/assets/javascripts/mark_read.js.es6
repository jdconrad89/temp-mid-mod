$( document ).ready(function(){
  $(".links").on("click", ".mark-read", changeLinkStatus)
})

function changeLinkStatus(){
  var linkId = parseInt(this.parentElement.parentElement.id);
  var currentStatus = $('#read-status-' + linkId)[0].innerText
  if(currentStatus === "Mark as Read"){
    $('#read-status-' + linkId)[0].innerText = "Mark as Un-Read";
    $(this).parent().parent().removeClass('link-is-unread')
    $(this).parent().parent().addClass('link-is-read')
    markLinkAsRead(this)
  } else {
    $('#read-status-' + linkId)[0].innerText = "Mark as Read";
    $(this).parent().parent().removeClass('link-is-read')
    $(this).parent().parent().addClass('link-is-unread')
    markLinkAsUnRead(this)
  }
}

function markLinkAsRead(event) {
  var urlToSend = event.parentElement.children[3].innerText
  var linkId = parseInt(event.parentElement.parentElement.id);

  $.ajax({
    url: "/links/" + linkId,
    method: 'PATCH',
    data: { read: true },
  }).then(sendLinkToHotReads(urlToSend))
};

function markLinkAsUnRead(event) {
  var urlToSend = event.parentElement.children[3].innerText
  var linkId = parseInt(event.parentElement.parentElement.id);

  $.ajax({
    url: "/links/" + linkId,
    method: 'PATCH',
    data: { read: false }
  }
)};

function sendLinkToHotReads(urlToSend) {
  $.ajax({
    url: "https://morning-cliffs-48745.herokuapp.com//api/v1/links",
    method: "POST",
    data: { url: urlToSend }
  })
}
