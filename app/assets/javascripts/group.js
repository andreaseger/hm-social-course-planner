function renderSchedule(groupId) {
    $.getJSON('/groups/' + groupId + '.json', null, function(data) {
        createDayDivs();
        $('#day1').append('<h2>Montag</h2>');
        $('#day2').append('<h2>Dienstag</h2>');
        $('#day3').append('<h2>Mittwoch</h2>');
        $('#day4').append('<h2>Donnerstag</h2>');
        $('#day5').append('<h2>Freitag</h2>');   
        
        for(var b = 0; b < data.bookings.length; b++) {
            var booking = data.bookings[b];
            
            var div = $(document.createElement('div'));
            div.append('<p><strong>' + booking.course.label + '</strong></p>');
            div.append('<p>' + booking.timeslot.start_label + ' - ' + booking.timeslot.end_label);
            
            $('#day' + booking.timeslot.day.id).append(div);
        }
    });
}

function createDayDivs() {
    for(var i = 1; i <= 5; i++) {    
        var dayDiv = $(document.createElement('div'));
        dayDiv.attr('id', 'day' + i);
        $('#schedule').append(dayDiv);    
    }
}