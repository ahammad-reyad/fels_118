// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree.

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parents(".answer_fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().prev().append(content.replace(regexp, new_id));
}

function nextWord(currentWord) {
  var nextWord = currentWord.next(".word-item");

  if(nextWord.length > 0) {
    nextWord.removeClass("hide");
    currentWord.addClass("hide");
  }
}

function prevWord(currentWord) {
  var prevWord = currentWord.prev(".word-item");

  if (prevWord.length > 0) {
    prevWord.removeClass("hide");
    currentWord.addClass("hide");
  }
}

$(document).ready(function(){
  $("#previous").click(function(){
    var $currentWord = $(".edit_lesson").find(".word-item:visible");
    prevWord($currentWord);
  })

  $("#next").click(function(){
    var $currentWord = $(".edit_lesson").find(".word-item:visible");
    nextWord($currentWord);
  })
})
