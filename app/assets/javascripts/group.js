function renderSchedule(groupId) {
    $('#content').empty();
    
    $.getJSON('/groups/' + groupId + '.json', null, function(data) {
        createTimeslotDivs();
        createDayDivs();
        $('#day1').append('<h2>Montag</h2>');
        $('#day2').append('<h2>Dienstag</h2>');
        $('#day3').append('<h2>Mittwoch</h2>');
        $('#day4').append('<h2>Donnerstag</h2>');
        $('#day5').append('<h2>Freitag</h2>');   
        
        for(var b = 0; b < data.bookings.length; b++) {
            var booking = data.bookings[b];
            
            var div = $(document.createElement('div'));
            div.attr('id', 'booking-' + booking.id);
            div.addClass('start-' + booking.timeslot.start_time);
            div.addClass('length-' + calculateLength(booking.timeslot.start_time, booking.timeslot.end_time));
            div.append('<div class="booking-title"><strong>' + booking.course.label + '</strong></div>');
            div.append('<div class="booking-timeslot">' + booking.timeslot.start_label + ' - ' + booking.timeslot.end_label + '</div>')
            $('#day' + booking.timeslot.day.id).append(div);
            
            $('#booking-' + booking.id).click(function() {
                var id = parseInt($(this).attr('id').substr(8));
                
                var data;
                
                if ($(this).is('.selected')) {
                    data = {
                        add_bookings: [],
                        remove_bookings: [ id ]                        
                    };
                } else {
                    data = {
                        add_bookings: [ id ],
                        remove_bookings: []                        
                    };
                }
                $.ajax({
                    url: '/user/schedule.json',
                    data: data,
                    type: 'PUT'
                });

                $(this).toggleClass('selected');                
            })
        }
    });
}

function calculateLength(start, end) {
    var startMinute = start % 100;
    var startHour = Math.floor(start / 100);
    
    var endMinute = end % 100;
    var endHour = Math.floor(end / 100);

    var startMinutes = startHour * 60 + startMinute;
    var endMinutes = endHour * 60 + endMinute;
    
    return endMinutes - startMinutes;
}

function createDayDivs() {
    for(var i = 1; i <= 5; i++) {    
        var dayDiv = $(document.createElement('div'));
        dayDiv.attr('id', 'day' + i);
        $('#content').append(dayDiv);    
    }
}

function createTimeslotDivs() {
    var timeslots = [ '8:15 - 9:45', '10:00 - 11:30', '11:45 - 13:15', '13:30 - 15:00', '15:15 - 16:45', '17:00 - 18:30', '18:45 - 20:15'];
    
    var timeslotsDiv = $(document.createElement('div'));
    timeslotsDiv.attr('id', 'timeslots');
    
    for(var i = 0; i < timeslots.length; i++) {
        var timeslotDiv = $(document.createElement('div'));
        timeslotDiv.attr('id', 'timeslot' + i);
        timeslotDiv.append('<strong>' + timeslots[i] + '</strong>');
        timeslotsDiv.append(timeslotDiv);
    }
    
    $('#content').append(timeslotsDiv);        
}