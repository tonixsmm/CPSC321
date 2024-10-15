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

// Serve index.html at the root URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'add_flight.html'));
});

// add a flight
app.post('/add_flight', async function(request, response) {
    try{
        var airline_code = request.body.airline_code;
        var airline_name = request.body.airline_name;
        var flight_number = request.body.flight_number;
        var departure_date = request.body.departure_date;
        var departure_time = request.body.departure_time;
        var arrival_date = request.body.arrival_date;
        var arrival_time = request.body.arrival_time;
        var departure_airport_code = request.body.departure_airport_code;
        var arrival_airport_code = request.body.arrival_airport_code;
        var miles = request.body.miles;
        var aircraft_registration = request.body.registration;
        var aircraft_manufacturer = request.body.aircraft_manufacturer;
        var aircraft_type = request.body.aircraft_type;
        var air_range = request.body.air_range;
        var year = request.body.year_of_manufacture;
        var seat_class = request.body.seat_class;
        var seat_number = request.body.seat_number;

        var cn = await mysql.createConnection(config);
        await cn.beginTransaction();

        const checkAirline = 'SELECT airline_code FROM Airline WHERE airline_code = ?';
        const [airlineRows] = await cn.query(checkAirline, [airline_code]);
        if (airlineRows.length === 0) {
            const addAirline = 'INSERT INTO Airline (airline_code, airline_name) VALUES (?, ?)';
            await cn.query(addAirline, [airline_code, airline_name]);
        }

        const check_aircraft = 'SELECT registration FROM Aircraft WHERE registration = ?';
        const [aircraftRows] = await cn.query(check_aircraft, [aircraft_registration]);
        if (aircraftRows.length === 0) {
            const add_aircraft = 'INSERT INTO Aircraft (registration, aircraft_manufacturer, aircraft_type, air_range, year_of_manufacture) VALUES (?, ?, ?, ?, ?)';
            await cn.query(add_aircraft, [aircraft_registration, aircraft_manufacturer, aircraft_type, air_range, year]);
        }

        const check_flight = 'SELECT airline_code, flight_number, departure_date FROM Flight WHERE airline_code = ? AND flight_number = ? AND departure_date = ?';
        const [flightRows] = await cn.query(check_flight, [airline_code, flight_number, departure_date]);
        if (flightRows.length === 0) {
            const add_flight = 'INSERT INTO Flight (airline_code, flight_number, departure_airport_code, departure_date, departure_time, arrival_airport_code, arrival_date, arrival_time, miles, aircraft_registration) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
            await cn.query(add_flight, [airline_code, flight_number, departure_airport_code, departure_date, departure_time, arrival_airport_code, arrival_date, arrival_time, miles, aircraft_registration]);
            
            const add_user_flight = 'INSERT INTO UserFlight (user_id, airline_code, flight_number, departure_date, seat_class, seat_number) VALUES (?, ?, ?, ?, ?, ?)';
            await cn.query(add_user_flight, ['U001', airline_code, flight_number, departure_date, seat_class, seat_number]);
        }

        await cn.commit();
        if (response.status(200)){
            response.send('Flight added successfully');
        }
    } 
    catch (err) {
        await cn.rollback();
        res.status(500).send('Error adding flight');
    } 
    finally {
       await cn.end();
    }
});