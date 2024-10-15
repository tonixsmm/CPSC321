const mysql = require('mysql2');
const express = require('express');
const path = require('path');

// the credential info
const config = require('./config.json');

// create and config the express application on localhost:3000
var app = express();
app.use(express.urlencoded({extended : false}));
app.use(express.json());
app.listen(3000);

// fetch the pet types from the database
app.get('/show_flight', function(request, response) {
    var cn = mysql.createConnection(config);
    cn.connect();

    const q = 'SELECT airline_name AS Airline, uf.flight_number AS Flight, f.departure_airport_code AS Depart, f.departure_date AS DepartureDate, f.departure_time AS DepartureTime, f.arrival_airport_code AS Arrive, f.arrival_date AS ArrivalDate, f.arrival_time AS ArrivalTime, uf.seat_class AS SeatClass, uf.seat_number AS SeatNumber, miles AS Miles, Aircraft.aircraft_manufacturer AS AircraftManufacturer, Aircraft.aircraft_type AS AircraftType'
            +  ' FROM User u JOIN UserFlight uf USING (user_id) JOIN Airline USING (airline_code) JOIN Flight f USING (airline_code, flight_number, departure_date) JOIN Aircraft ON (f.aircraft_registration = Aircraft.registration)'
            +  ' ORDER BY departure_date DESC'
    cn.query(q, function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}

        var str = '<table>\n<tr>';

        // Create the header row with field names
        for (const field of fields) {
            str += '<th>' + field.name + '</th>';
        }
        str += '</tr>\n';

        // Create rows for each record
        for (const r of rows) {
            str += '<tr>';
            for (const field of fields) {
                str += '<td>' + r[field.name] + '</td>';
            }
            str += '</tr>\n';
        }

        str += '</table>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});

// serve the form
app.get('/', function(request, response) {
    response.sendFile(path.join(__dirname + '/show_flight.html'));
});