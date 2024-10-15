"""Program utility functions.

NAME: Tony Nguyen
DATE: Fall 2023
CLASS: CPSC 321

"""

import sys


def show_menu():
    """Displays a menu of options for the user to choose from."""

    print()
    print('1. List Countries')
    print('2. Add Countries')
    print('3. Find Countries Based On GDP and Inflation')
    print("4. Update Country's GDP and Inflation")
    print('5. Exit')


def get_valid_choice():
    """Gets a valid choice from the user."""

    choice = -1

    while choice < 1 or choice > 5:
        try:
            choice = int(input('Enter your choice (1-5): '))
            print()
            return choice
        except ValueError:
            print('Invalid choice. Please try again.')
            print()


def flow_control(choice, connection):
    """This function takes in a choice and a connection object and performs the 
        corresponding action based on the choice.
    
    Parameters:
        choice (int): An integer representing the user's choice.
        connection: A connection object.
    
    Returns:
        None
    """
    match choice:
        case 1:
            list_countries(connection)
        case 2:
            add_countries(connection)
        case 3:
            find_countries_gdp_inflation(connection)
        case 4:
            update_gdp_inflation(connection)
        case 5:
            connection.close()
            sys.exit()


def run_program(connection):
    """Runs the program by displaying a menu of options to the user 
        and executing the selected option.
    
    Args:
        connection: a database connection object
    
    Returns: 
        None
    """
    choice = -1
    
    while choice != 5:
        show_menu()
        choice = get_valid_choice()
        flow_control(choice, connection)


def list_countries(connection):
    """Prints a list of countries in the database, along with their 
        country code, per capita GDP, and inflation rate.

    Args:
        connection: A database connection object.

    Returns:
        None
    """
    rs = connection.cursor()
    query = 'SELECT * FROM Country ORDER BY country_name'

    rs.execute(query)

    for row in rs:
        print(f'{row[1]} ({row[0]}), per capita GDP ${row[2]}, inflation: {row[3]}%')

    rs.close()


def add_countries(connection):
    """Adds a new country to the Country table in the database.

    Args:
        connection: A connection object to the database.

    Returns:
        None
    """
    ccode = input('Country code................: ')
    cname = input('Country name................: ')
    gdp = int(input('Country per capita GDP (USD): '))
    inflation = float(input('Country inflation (pct).....: '))
    print()

    # Check if the country code is already in the database
    check_query = 'SELECT Country_code FROM Country WHERE Country_code = %s'
    rs = connection.cursor()
    rs.execute(check_query, (ccode,))
    if rs.fetchone():
        print('Country already exists')
        rs.close()
        connection.close()
        return

    # Insert the new country into the database
    insert_query = 'INSERT INTO Country VALUES (%s, %s, %s, %s)'
    rs = connection.cursor()
    rs.execute(insert_query, (ccode, cname, gdp, inflation))
    connection.commit()

    print(f'Country {ccode} added')
    rs.close()


def find_countries_gdp_inflation(connection):
    """Finds countries that meet certain criteria for GDP per capita and inflation.

    Args:
        connection: A connection object.

    Returns:
        None.
    """
    min_gdp = int(input('Minimum per capita GDP (USD): '))
    max_gdp = int(input('Maximum per capita GDP (USD): '))
    min_inflation = float(input('Minimum inflation (pct).....: '))
    max_inflation = float(input('Maximum inflation (pct).....: '))
    print()

    query = ('SELECT * '
             'FROM Country '
             'WHERE (gdp_per_capita >= %s AND gdp_per_capita <= %s) '
                'AND (inflation >= %s AND inflation <= %s) '
             'ORDER BY gdp_per_capita DESC, inflation ASC')
    
    rs = connection.cursor()
    rs.execute(query, (min_gdp, max_gdp, min_inflation, max_inflation))

    for row in rs:
        print(f'{row[1]} ({row[0]}), per capita GDP ${row[2]}, inflation: {row[3]}%')

    rs.close()


def update_gdp_inflation(connection):
    """
    Updates the GDP and inflation data for a given country in the database.

    Args:
        connection: A connection object to the database.

    Returns:
        None
    """
    ccode = input('Country code................: ')
    gdp = int(input('Country per capita GDP (USD): '))
    inflation = float(input('Country inflation (pct).....: '))
    print()

    # Check if the country code is already in the database
    check_query = 'SELECT Country_code FROM Country WHERE Country_code = %s'
    rs = connection.cursor()
    rs.execute(check_query, (ccode,))
    if not rs.fetchone():
        print('Country not exists')
        rs.close()
        connection.close()
        return

    # Update the new country info into the database
    insert_query = 'UPDATE Country SET gdp_per_capita = %s, inflation = %s WHERE country_code = %s'
    rs = connection.cursor()
    rs.execute(insert_query, (gdp, inflation, ccode))
    connection.commit()

    print(f'Country {ccode} updated')
    rs.close()

