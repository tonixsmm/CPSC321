from flask import Flask, request, jsonify, render_template
import os
import config
import mysql.connector as mc
# from opensky_api import OpenSkyApi
import requests

app = Flask(__name__)

# Initialize the database connection
app.config['MYSQL_HOST'] = config.Database['host'],
app.config['MYSQL_USER'] = config.Database['user'],
app.config['MYSQL_PASSWORD'] = config.Database['password'],
app.config['MYSQL_DB'] = config.Database['database']

# Connect to the database
db = mc.connect(
    host = config.Database['host'],
    user = config.Database['user'],
    passwd = config.Database['password'],
    database = config.Database['database']
)
rs = db.cursor()

@app.route('/')
def index():
    # Query the database for some data
    cursor = db.cursor()
    cursor.execute('SELECT * FROM Airport')
    data = cursor.fetchall()

    # Render a template using the data
    return render_template('index.html', data=data)

# @app.route('/search_flight', methods=['GET'])
# def search_flight():
#     flight_number = None
#     departure_airport = None
#     arrival_airport = None
#     departure_date = None
#     arrival_date = None
#     departure_time = None
#     arrival_time = None

#     # Get the query parameters
#     flight_number = request.args.get('flight_number')
#     departure_airport = request.args.get('departure_airport')
#     arrival_airport = request.args.get('arrival_airport')
#     departure_date = request.args.get('departure_date')
#     arrival_date = request.args.get('arrival_date')
#     departure_time = request.args.get('departure_time')
#     arrival_time = request.args.get('arrival_time')

#     # Connect to the database
#     db = mc.connect(
#         host = config.Database['host'],
#         user = config.Database['user'],
#         passwd = config.Database['password'],
#         database = config.Database['database']
#     )
#     rs = db.cursor()

#     # Form the query
#     # TODO: Parameterize the query
#     query = "SELECT * FROM flight WHERE "
#     if flight_number:
#         query += "flight_number = '" + flight_number + "' AND "
#     if departure_airport:
#         query += "departure_airport = '" + departure_airport + "' AND "
#     if arrival_airport:
#         query += "arrival_airport = '" + arrival_airport + "' AND "
#     if departure_date:
#         query += "departure_date = '" + departure_date + "' AND "
#     if arrival_date:
#         query += "arrival_date = '" + arrival_date + "' AND "
#     if departure_time:
#         query += "departure_time = '" + departure_time + "' AND "
#     if arrival_time:
#         query += "arrival_time = '" + arrival_time + "' AND "
#     query = query[:-5] + ";"

#     # Execute the query
#     rs.execute(query)
#     result = rs.fetchall()

#     # Close the database connection
#     db.close()

#     # Return the result
#     return jsonify(result)
    
if __name__ == '__main__':
    # url = "https://flightera-flight-data.p.rapidapi.com/flight/search"

    # querystring = {"flnr":"UA1"}

    # headers = {
    #     "X-RapidAPI-Key": config.RapidAPI_Flightera['key'],
    #     "X-RapidAPI-Host": config.RapidAPI_Flightera['host']
    # }

    # response = requests.get(url, headers=headers, params=querystring)

    # print(response.json())

    app.run(debug=True)