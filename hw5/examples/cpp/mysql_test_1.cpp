
#include <iostream>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/statement.h>
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

    // create statement
    sql::Statement* st = cn->createStatement();
    string q = "SELECT id, name FROM pet ORDER BY name";
    
    // execute query
    sql::ResultSet* rs = st->executeQuery(q);

    // print result
    while(rs->next())
      cout << rs->getInt("id") << ", " << rs->getString("name") << endl;

    // clean up
    delete rs;
    delete st;
    delete cn;

  } catch(sql::SQLException& e) {
    cout << e.what() << endl;
  }

}
