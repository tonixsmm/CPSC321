const mysql = require('mysql2/promise');
const express = require('express');
const path = require('path');

// the credential info
const config = require('./config.json');

// create and config the express application on localhost:3000
var app = express();
app.use(express.urlencoded({extended : false}));
app.use(express.json());
app.listen(3000);

// serve the form
app.get('/', function(request, response) {
    response.sendFile(path.join(__dirname + '/search_flight.html'));
});

// modify a flight
app.post('/search_flight', async function(request, response) {
    try {
        for (var key in request.body) {
            if (request.body[key] === '') {
                request.body[key] = null;
            }
        }

        var cn = await mysql.createConnection(config);
        await cn.beginTransaction();

        q = 'SELECT airline_name AS Airline, airline_code AS AirlineCode, uf.flight_number AS Flight, f.departure_airport_code AS Depart, f.departure_date AS DepartureDate, f.departure_time AS DepartureTime, f.arrival_airport_code AS Arrive, f.arrival_date AS ArrivalDate, f.arrival_time AS ArrivalTime, uf.seat_class AS SeatClass, uf.seat_number AS SeatNumber, miles AS Miles, Aircraft.registration AS AircraftRegistration'
            +  ' FROM User u JOIN UserFlight uf USING (user_id) JOIN Airline USING (airline_code) JOIN Flight f USING (airline_code, flight_number, departure_date) JOIN Aircraft ON (f.aircraft_registration = Aircraft.registration)';
        
        where_clause = ' WHERE ';
        available_params = []
        for (var key in request.body) {
            if (request.body[key] !== null) {
                where_clause += key + ' = ? AND ';
                available_params.push(request.body[key]);
            }
        }
        where_clause = where_clause.slice(0, -5); // remove the last ' AND '
        q += where_clause;
        q += ' ORDER BY departure_date DESC'

        const [rows, fields] = await cn.query(q, available_params);

        if (rows.length === 0) {
            response.send('No flights found');
            return;
        }
        else {
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
        }
    } 
    catch (err) {
        await cn.rollback();
        console.log(err);
        response.status(500).send('Error searching flight');
    }
    finally {
        if (cn) {
            await cn.end();
        }
    }
});