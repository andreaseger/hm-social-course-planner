// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
    $.getJSON('/groups.json', null, function(data) {
        var ul = document.createElement('ul');

        for(var i = 0; i < data.length; i++) {
            $(ul).append('<li><a href="/groups/' + data[i].id + '/" onclick="renderSchedule(' + data[i].id + '); return false;">' + data[i].name + '</a></li>');
        }

        $('#left').append($(ul));
    });
    
    $("#user-schedule-link").click(function() {
        renderOwnSchedule();
        return false;
    });
    
    $('#classmate-schedule-link').click(function() {
        renderClassmateSchedule($(this).attr('href'));
        return false;
    });
    
    $('#notice').click(function() {
        $(this).hide();
    });
    
    $('#error').click(function() {
        $(this).hide();
    });
    
});