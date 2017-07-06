$(document).ready(function() {
  clickVote();
});

function clickVote() {
  $('.vote-arrow').on('submit','.inline', function(event){
    event.preventDefault();

    var form = $(this).closest('.inline');
    var url = form.attr('action');
    var method = form.attr('method');

    var container = $(this).closest('.vote-box');

    $.ajax({
      url: url,
      method: method,
      error: function (xhr, ajaxOptions, thrownError) {
        if(xhr.status == 422) {
          alert("User cannot vote on own item")
        }
      }
    }).done( function(returnValue) {
      console.log(returnValue);
      container.find('.vote-number').html(returnValue);
    });
  });
};
