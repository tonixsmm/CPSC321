
#include <iostream>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/prepared_statement.h>
#include <cppconn/resultset.h>
#include <cppconn/exception.h>

#include "config.h"

using namespace std;


int main()
{
  try {

    // connection info
    string hst = config::host;
    string usr = config::user;
    string pwd = config::password;
    string dab = config::database;

    // create connection
    sql::Driver* driver = get_driver_instance();
    sql::Connection* cn = driver->connect(hst, usr, pwd);
    cn->setSchema(dab);

    // get a pet id, make sure it is unique
    cout << "Please enter a pet id: ";
    int id;
    cin >> id;
    cin.ignore();
    string q = "SELECT * FROM pet WHERE id = ?";
    sql::PreparedStatement* st = cn->prepareStatement(q);
    st->setInt(1, id);
    sql::ResultSet* rs = st->executeQuery();
    if (rs->next()) {
      cout << "This pet id is already taken" << endl;
      delete rs;
      delete st;
      delete cn;
      return 1;
    }
    delete rs;
    delete st;
    
    // get pet name, breed, type, bday, and size
    cout << "Please enter the pet's name: ";
    string name;
    getline(cin, name);
    cout << "Please enter the pet's type (dog, cat, etc): ";
    string type;
    getline(cin, type);
    cout << "Please enter the pet's breed: ";
    string breed;
    getline(cin, breed);
    cout << "Please enter the pet's birthdate ('YYYY-MM-DD'): ";
    string date;
    getline(cin, date);
    cout << "Please enter the pet's size (S, M, L, XL): ";
    string size;
    getline(cin, size);
    cout << "Please enter the pet's appearance: ";
    string appearance;
    getline(cin, appearance);

    q = "INSERT INTO pet VALUES (?,?,?,?,?,?,?)";
    st = cn->prepareStatement(q);
    st->setInt(1, id);
    st->setString(2, name);
    st->setString(3, type);
    st->setString(4, breed);
    st->setString(5, date);
    st->setString(6, size);
    st->setString(7, appearance);
    st->executeUpdate();

    delete st;
    delete cn;
    
  } catch(sql::SQLException& e) {
    cout << e.what() << endl;
  }
  
}
