$(document).ready(function() {
  renderAnswerForm();
  submitAnswer();
  renderCommentForm();
  submitComment();
  renderEditForm();
  submitEdit();
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
    var method = $(this).attr('method');
    var data = $(this).serialize();

    $.ajax({
      url: url,
      data: data,
      method: method
    }).done(function(response) {
      container.insert(response)
    })
    $(this).remove();
    container.find('.new-comment-link').show();
  });
};

function renderEditForm() {
  $('.edit-box').on('submit', '.get-edit-form', function(event){
    event.preventDefault();

    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var container = $(this).closest('.detail-box');

    $.ajax({
      url: url,
      method: method
    }).done(function(response) {
      container.find('.body-text:first').hide();
      container.find('.vote-box:first').hide();
      container.find('.edit-box:first').after(response);
    }).fail(function(error) {
      console.log("Something went wrong!")
    })
  });
};

function submitEdit() {
  $('.edit-master-box').on('submit', '#edit-form', function(event){
    event.preventDefault();

    var url = $(this).attr('action');
    var data = $(this).serialize();
    var container = $(this).closest('.detail-box');

    console.log(url);
    console.log(data);

    $.ajax({
      url: url,
      data: data,
      method: 'put'
    }).done(function(response) {
      container.find('.body-text:first').show();
      container.find('.vote-box:first').show();
      container.find('.detail-text:first').html(response.body);
      if (response.title) {
        $('#question-title').html(response.title);
      }
    }).fail(function(error) {
      console.log("Something went wrong!")
    });
    $(this).remove();
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
