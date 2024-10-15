const mysql = require('mysql2/promise');
const express = require('express');
const config = require('./config.json');
const path = require('path');

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.listen(3000);

const getAnalyticsData = async (query) => {
    const cn = await mysql.createConnection(config);
    try {
        const [rows] = await cn.query(query);
        return rows;
    } catch (err) {
        console.error('Error: ', err);
        throw err;
    } finally {
        await cn.end();
    }
};

app.get('/show_dashboard', async (req, res) => {
    try {
        const totalFlightsQuery = 'SELECT COUNT(*) AS totalFlights FROM Flight';
        const totalDistanceQuery = 'SELECT SUM(miles) AS totalDistance FROM Flight';
        const averageFlightTimeQuery = 'SELECT AVG(TIMESTAMPDIFF(HOUR, CONCAT(departure_date, " ", departure_time), CONCAT(arrival_date, " ", arrival_time))) AS averageFlightTime FROM Flight';
        const numberOfSeatClassesQuery = 'SELECT COUNT(DISTINCT seat_class) AS numberOfSeatClasses FROM UserFlight'; 
        const topCountriesQuery = 'SELECT Airport.country_code, COUNT(*) AS numberOfFlights FROM Flight JOIN Airport ON (Flight.departure_airport_code = Airport.country_code OR arrival_airport_code = Airport.country_code) GROUP BY Airport.country_code ORDER BY numberOfFlights DESC LIMIT 3';
        const topRoutesQuery = 'SELECT CONCAT(departure_airport_code, " - ", arrival_airport_code) AS route, COUNT(*) AS numberOfFlights FROM Flight GROUP BY route ORDER BY numberOfFlights DESC LIMIT 3';

        const totalFlights = await getAnalyticsData(totalFlightsQuery);
        const totalDistance = await getAnalyticsData(totalDistanceQuery);
        const averageFlightTime = await getAnalyticsData(averageFlightTimeQuery);
        const numberOfSeatClasses = await getAnalyticsData(numberOfSeatClassesQuery);
        const topCountries = await getAnalyticsData(topCountriesQuery);
        const topRoutes = await getAnalyticsData(topRoutesQuery);

        res.json({
            totalFlights,
            totalDistance,
            averageFlightTime,
            numberOfSeatClasses,
            topCountries,
            topRoutes
        });
    } catch (err) {
        res.status(500).send('Error fetching dashboard data');
    }
});

// Serve index.html at the root URL
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'show_dashboard.html'));
});
