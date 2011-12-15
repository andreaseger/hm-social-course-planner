function renderScheduleData(data, interactive) {
    $('#content').empty();    
    
    createTimeslotDivs();
    createDayDivs();
    $('#day1').append('<h2>Montag</h2>');
    $('#day2').append('<h2>Dienstag</h2>');
    $('#day3').append('<h2>Mittwoch</h2>');
    $('#day4').append('<h2>Donnerstag</h2>');
    $('#day5').append('<h2>Freitag</h2>');   

    for(var b = 0; b < data.bookings.length; b++) {
        var booking = data.bookings[b];

        var timeslotId = "timeslot-" + booking.timeslot.day.id + "-" + booking.timeslot.start_time;

        var tmp = $("#" + timeslotId);
        var timeslotList;

        if (tmp.length) {
            timeslotList = $(tmp[0]);
        } else {
            timeslotList = $(document.createElement("ul"));
            timeslotList.addClass('timeslot');
            timeslotList.attr('id', timeslotId);
            timeslotList.addClass('start-' + booking.timeslot.start_time);
            timeslotList.addClass('length-' + calculateLength(booking.timeslot.start_time, booking.timeslot.end_time));
            $('#day' + booking.timeslot.day.id).append(timeslotList);                
        }

        var div = $(document.createElement('div'));
        div.attr('id', 'booking-' + booking.id);
        div.append('<div class="booking-title"><strong><a href="http://fi.cs.hm.edu/fi/rest/public/modul/title/' + booking.course.name + '/" target="_blank">' + booking.course.label + '</a></strong></div>');
        div.append('<div class="booking-timeslot">' + booking.timeslot.start_label + ' - ' + booking.timeslot.end_label + '</div>')
        div.append('<div class="booking-teacher"><a href="http://fi.cs.hm.edu/fi/rest/public/person/name/' + booking.teachers[0].name + '/" target="_blank">' + booking.teachers[0].label + '</a></div>');
        div.append('<div class="booking-room"><a href="http://fi.cs.hm.edu/fi/rest/public/timetable/room/' + booking.room.name + '/" target="_blank">' + booking.room.label + '</a></div>');
        div.addClass('booking');
        div.addClass('length-' + calculateLength(booking.timeslot.start_time, booking.timeslot.end_time));

        if (booking.selected) {
            div.addClass("booking-selected");
        }

        var li = $(document.createElement("li"));
        li.append(div);
        timeslotList.append(li);

        if (interactive) {
            $('#booking-' + booking.id).click(function() {
                var id = parseInt($(this).attr('id').substr(8));

                var jsonData;

                if ($(this).is('.booking-selected')) {
                    jsonData = {
                        add_bookings: [],
                        remove_bookings: [ id ]                        
                    };
                } else {
                    jsonData = {
                        add_bookings: [ id ],
                        remove_bookings: []                        
                    };
                }
                $('#wait').show();
                $.ajax({
                    url: '/user/schedule.json',
                    data: jsonData,
                    type: 'PUT',
                    complete: function() { 
                        $('#wait').hide();
                    }
                });                

                $(this).toggleClass('booking-selected');                
            });
        }
    }    
}

function renderClassmateSchedule(url) {
    $.getJSON(url + '.json', null, function(data) {
        renderScheduleData(data, true);
    });    
}

function renderSchedule(groupId) {
    $.getJSON('/groups/' + groupId + '.json', null, function(data) {
        renderScheduleData(data, true);
    });
}

function renderOwnSchedule() {
    $.getJSON('/user/schedule.json', null, function(data) {
        renderScheduleData(data, false);
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
