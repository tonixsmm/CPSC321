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

// fetch the pet types from the database
app.get('/show_flight', async function(request, response) {
    try {
        var cn = await mysql.createConnection(config);

        const q = 'SELECT airline_name AS Airline, airline_code AS AirlineCode, uf.flight_number AS Flight, f.departure_airport_code AS Depart, f.departure_date AS DepartureDate, f.departure_time AS DepartureTime, f.arrival_airport_code AS Arrive, f.arrival_date AS ArrivalDate, f.arrival_time AS ArrivalTime, uf.seat_class AS SeatClass, uf.seat_number AS SeatNumber, miles AS Miles, Aircraft.registration AS AircraftRegistration'
                +  ' FROM User u JOIN UserFlight uf USING (user_id) JOIN Airline USING (airline_code) JOIN Flight f USING (airline_code, flight_number, departure_date) JOIN Aircraft ON (f.aircraft_registration = Aircraft.registration)'
                +  ' ORDER BY departure_date DESC'
        
        const [rows, fields] = await cn.query(q);
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
    catch (err) {
        response.status(500).send('Error fetching flights');
    }
    finally {
        if (cn) {
            await cn.end();
        }
    }
});

// serve the form
app.get('/', function(request, response) {
    response.sendFile(path.join(__dirname + '/modify_flight.html'));
});

// modify a flight
app.post('/modify_flight', async function(request, response) {
    try {
        var airline_code_old = request.body.airline_code_old;
        var flight_number_old = request.body.flight_number_old;
        var departure_date_old = request.body.departure_date_old;
        var airline_code = request.body.airline_code;
        var flight_number = request.body.flight_number;
        var departure_date = request.body.departure_date;
        var departure_time = request.body.departure_time;
        var arrival_date = request.body.arrival_date;
        var arrival_time = request.body.arrival_time;
        var departure_airport_code = request.body.departure_airport_code;
        var arrival_airport_code = request.body.arrival_airport_code;
        var miles = request.body.miles;
        var aircraft_registration = request.body.registration;

        var cn = await mysql.createConnection(config);
        await cn.beginTransaction();

        const check_flight = 'SELECT airline_code, flight_number, departure_date FROM Flight WHERE airline_code = ? AND flight_number = ? AND departure_date = ?';
        const [flightRows] = await cn.query(check_flight, [airline_code_old, flight_number_old, departure_date_old]);
        if (flightRows.length === 0) {
            response.send('Flight does not exist');
            cn.end();
            return;
        }

        const update_flight = 'UPDATE Flight SET airline_code = ?, flight_number = ?, departure_date = ?, departure_airport_code = ?, departure_time = ?, arrival_airport_code = ?, arrival_date = ?, arrival_time = ?, miles = ?, aircraft_registration = ? WHERE airline_code = ? AND flight_number = ? AND departure_date = ?';
        await cn.query(update_flight, [airline_code, flight_number, departure_date, departure_airport_code, departure_time, arrival_airport_code, arrival_date, arrival_time, miles, aircraft_registration, airline_code_old, flight_number_old, departure_date_old]);

        await cn.commit();
        response.send('Flight updated successfully');
    } 
    catch (err) {
        await cn.rollback();
        response.status(500).send('Error modifying flight');
    }
    finally {
        if (cn) {
            await cn.end();
        }
    }
});