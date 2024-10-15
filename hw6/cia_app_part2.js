/*CIA World Factbook App - Searching for Cities by Country

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
    response.sendFile(path.join(__dirname + '/select_country.html'));
});

// handle the request and forward the response
app.post('/show_city.html', function(request, response) {
    var value = request.body.CountryChoice;
    var country_code = value.split('|')[0];
    var country_name = value.split('|')[1];
    var cn = mysql.createConnection(config);
    cn.connect();
    const q = 'SELECT * FROM City WHERE country = ? ORDER BY country ASC';
    cn.query(q, [country_code], function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
        var str = '<html>\n<body>\n';
        str += '<h2>Country Code: ' + country_code + ', Country Name: ' + country_name + '</h2>\n';
        str += '<ol>\n';
        for (const r of rows) { // iterate through result set
            str += '<li>';
            str += r['city_name'] + ', ' + r['province_name'] + ', ' + r['population'];
            str += '</li>\n';
        }
        str += '</ol>\n';
        str += '</body>\n</html>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});
