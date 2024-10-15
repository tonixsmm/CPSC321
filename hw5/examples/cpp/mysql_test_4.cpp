
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

    // get a pet id, make sure it is valid
    cout << "Please enter a pet id: ";
    int id;
    cin >> id;
    cin.ignore();
    string q = "SELECT * FROM pet WHERE id = ?";
    sql::PreparedStatement* st = cn->prepareStatement(q);
    st->setInt(1, id);
    sql::ResultSet* rs = st->executeQuery();
    if (!rs->next()) {
      cout << "This pet id is invalid" << endl;
      delete rs;
      delete st;
      delete cn;
      return 1;
    }
    delete rs;
    delete st;

    q = "DELETE FROM pet WHERE id = ?";
    st = cn->prepareStatement(q);
    st->setInt(1, id);
    st->executeUpdate();

    cout << "Pet id " << id << " has been removed from the database" << endl;

    delete st;
    delete cn;
    
  } catch(sql::SQLException& e) {
    cout << e.what() << endl;
  }
  
}
