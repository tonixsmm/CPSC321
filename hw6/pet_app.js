/*Pet Type

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
app.get('/pet_types', function(request, response) {
    var cn = mysql.createConnection(config);
    cn.connect();

    const q = 'SELECT DISTINCT type FROM pet ORDER BY type ASC';
    cn.query(q, function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
        var str = '<select name="PetTypeChoice">\n';
        for (const r of rows) { // iterate through result set            
            str += '<option value="' + r['type'] + '">' + r['type'][0].toUpperCase() + r['type'].slice(1) + '</option>';
        }
        str += '</select>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});

// serve the form
app.get('/', function(request, response) {
    response.sendFile(path.join(__dirname + '/select_pet_type.html'));
});

// handle the request and forward the response
app.post('/show_pets_by_type.html', function(request, response) {
    var type = request.body.PetTypeChoice;
    var cn = mysql.createConnection(config);
    cn.connect();
    const q = 'SELECT id, name, type FROM pet WHERE type = ? ORDER BY type ASC';
    cn.query(q, [type], function(err, rows, fields) {
        if (err) {console.log('Error: ', err);}
        var str = '<html>\n<body>\n';
        str += '<p>Pet Type: ' + type[0].toUpperCase()  + type.slice(1) + '</p>\n';
        str += '<ol>\n';
        for (const r of rows) { // iterate through result set
            str += '<li>';
            str += r['id'] + ', ' + r['name'][0].toUpperCase() + r['name'].slice(1);
            str += '</li>\n';
        }
        str += '</ol>\n';
        str += '</body>\n</html>\n';
        response.send(str); // dynamically generate the new html page
    });
    cn.end();
});
