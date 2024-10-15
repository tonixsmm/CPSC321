
import mysql.connector as mc

import config

def main():
    try:
        # get connection info
        hst = config.host
        dat = config.database
        usr = config.user
        pwd = config.password
        
        # create connection
        cn = mc.connect(host=hst, database=dat, user=usr, password=pwd)
        
        # get a category from the user
        user_input_1 = input('Please enter a pet type (dog, cat, etc): ')
        user_input_2 = input('Please enter an appearance keyword: ') 

        # result set
        rs = cn.cursor()
        q = ('SELECT id, name, appearance '
             'FROM pet '
             'WHERE type = %s AND INSTR(appearance, %s)')

        # execute the query
        rs.execute(q, (user_input_1, user_input_2))
        
        # display results
        for row in rs:
            print(f'{row[0]}, {row[1]}, {row[2]}') 
            
    except mc.Error as err:
        print(err)

    finally:
        rs.close()
        cn.close()
            
        
if __name__ == '__main__':
    main()
