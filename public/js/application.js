$(document).ready(function() {
  renderAnswerForm();
  submitAnswer();
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

function renderAnswerForm() {
  $('#new-answer-link').on('click', function(event){
    $(this).hide();
    event.preventDefault();
    var url = $(this).attr('href')

    $.ajax({
      url: url,
    }).done(function(response) {
      $('.new-answer-submission').append(response)
    }).fail(function(error) {
      console.log("Something went wrong!")
    })
  });
};

function submitAnswer() {
  $('.new-answer-submission').on('submit', '#new-answer-form', function(event) {
    event.preventDefault();

    var url = $(location).attr('href')+"/answers/new";
    var method = $(this).attr('method')
    var data = $(this).serialize();

    $.ajax({
      url: url,
      data: data,
      method: method
    }).done(function(response) {
      $('.answer-box').append(response)
    })
    $(this).remove();
    $('#new-answer-link').show();
  });
}
