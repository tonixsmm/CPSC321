/*CIA World Factbook App - Updating Country Data

NAME: Tony Nguyen
DATE: Fall 2023
CLASS: CPSC 321

*/

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
app.get('/country_name', function(request, response) {
    var cn = mysql.createConnection(config);
    cn.connect();

    const q = 'SELECT DISTINCT country_code, country_name FROM Country ORDER BY country_name ASC';
    cn.query(q, function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
        var str = '<select name="CountryChoice">\n';
        for (const r of rows) { // iterate through result set            
            var optionValue = r['country_code'] + '|' + r['country_name'];
            str += '<option value="' + optionValue + '">' + r['country_name'] + '</option>';
        }
        str += '</select>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});

// serve the form
app.get('/', function(request, response) {
    response.sendFile(path.join(__dirname + '/update_country.html'));
});

// handle the request and forward the response
app.post('/update.html', function(request, response) {
    // Handle variables
    var value = request.body.CountryChoice;
    var country_code = value.split('|')[0];
    var country_name = value.split('|')[1];

    var infl = request.body.inflation;
    var gdp = request.body.gdp;

    // Update the database
    var cn = mysql.createConnection(config);
    cn.connect();
    const q = 'UPDATE Country SET gdp_per_capita = ?, inflation = ? WHERE country_code = ?';
    cn.query(q, [gdp, infl, country_code], function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
    });
    cn.end();

    // Fetch the data from the database
    var cn = mysql.createConnection(config);
    cn.connect();
    const q_new = 'SELECT * FROM Country';
    cn.query(q_new, function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
        var str = '<html>\n<body>\n';
        str += '<h2>All Countries</h2>\n';
        str += '<ol>\n';
        for (const r of rows) { // iterate through result set
            str += '<li>';
            str += r['country_code'] + ', ' + r['country_name'] + ', ' + r['gdp_per_capita'] + ', ' + r['inflation'];
            str += '</li>\n';
        }
        str += '</ol>\n';
        str += '</body>\n</html>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});
