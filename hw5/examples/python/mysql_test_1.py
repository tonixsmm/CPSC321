
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
        
        # result set
        rs = cn.cursor()
        q = 'SELECT id, name FROM pet ORDER BY name'
        
        # execute the query
        rs.execute(q)
        
        # display results
        for row in rs:
            print(f'{row[0]}, {row[1]}')    # id first, name second attribute
            
        #clean up
        rs.close()
        cn.close()
            
    except mc.Error as err:
        print(err)

        
if __name__ == '__main__':
    main()
