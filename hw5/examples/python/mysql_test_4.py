
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
        
        # get a pet id, make sure it is unique
        pet_id = int(input('Please enter a pet id: '))
        q = "SELECT * FROM pet WHERE id = %s"
        rs = cn.cursor()
        rs.execute(q, (pet_id,))
        if not rs.fetchone(): 
            print('This pet id is invalid')
            rs.close()
            cn.close()
            return

        # to reuse the result set
        rs.reset()

        # execute the update
        q = "DELETE FROM pet WHERE id = %s"
        rs = cn.cursor()
        rs.execute(q, (pet_id,))
        cn.commit()

        # print the exit message
        print('Pet id', pet_id, 'has been removed from the database')

    except mc.Error as err:
        print(err)

    finally:
        rs.close()
        cn.close()
            
        
if __name__ == '__main__':
    main()
