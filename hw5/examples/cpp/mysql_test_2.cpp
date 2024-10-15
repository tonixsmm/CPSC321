
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

    // get a category from the user
    string user_input_1;
    string user_input_2;
    cout << "Please enter a pet type (dog, cat, etc): ";
    cin >> user_input_1;
    cout << "Please enter an appearance keyword: ";
    cin >> user_input_2;
    
    // create statement
    string q =
      "SELECT id, name, appearance "
      "FROM pet "
      "WHERE type = ? AND INSTR(appearance, ?)";
    sql::PreparedStatement* st = cn->prepareStatement(q);
    st->setString(1, user_input_1);
    st->setString(2, user_input_2);
    
    // execute query
    sql::ResultSet* rs = st->executeQuery();

    // print result
    while(rs->next()) {
      cout << rs->getInt("id") << ", "
           << rs->getString("name") << ", "
           << rs->getString("appearance") << endl;
    }

    // clean up
    delete rs;
    delete st;
    delete cn;

  } catch(sql::SQLException& e) {
    cout << e.what() << endl;
  }
  
}
