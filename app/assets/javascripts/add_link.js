$(document).ready(function(){
  var linkTitle = $("#link-title");
  var linkUrl  = $("#link-url");
  var userId = $("#new-link").data('user');
  $("#new-link").on('submit', createLink);
;
})

function createLink (event){
  event.preventDefault();

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .then( clearLink )

 }

function getLinkData() {
 return {
   title: $linkTitle.val(),
   url: $linkUrl.val(),
   user_id: $userId
 }
}

function renderLink(link){
  $("#links-list").prepend( linkHTML(link) )
}

function linkHTML(link) {
    return `<tr class='link', id='${link.id}'>
              <td>${ link.title }</td>
              <td>${ link.url } target="_blank"></td>
              <td><button class="btn mark-read" id="read-status-${link.id}">Mark as Read</button></td>
            </tr>
          `
        }

function clearLink() {
  $linkTitle.val("");
  $linkUrl.val("");
}
