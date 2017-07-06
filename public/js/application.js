$(document).ready(function() {
  renderAnswerForm();
  submitAnswer();
  renderCommentForm();
  submitComment();
  clickVote();
});


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
};

function renderCommentForm() {
  $('.new-comment-link').on('click', function(event){
    $(this).hide();
    event.preventDefault();
    var url = $(this).attr('href')

    var container = $(this).closest('.add-comment');

    $.ajax({
      url: url,
    }).done(function(response) {
      container.find('.new-comment-submission').append(response)
    }).fail(function(error) {
      console.log("Something went wrong!")
    })
  });
};

function submitComment() {
  $('.new-comment-submission').on('submit', '#new-comment-form', function(event) {
    event.preventDefault();

    var container = $(this).closest('.comments-box');

    var url = container.find('.new-comment-link').attr('href');
    var method = $(this).attr('method')
    var data = $(this).serialize();

    $.ajax({
      url: url,
      data: data,
      method: method
    }).done(function(response) {
      container.append(response)
    })
    $(this).remove();
    container.find('.new-comment-link').show();
  });
};

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
