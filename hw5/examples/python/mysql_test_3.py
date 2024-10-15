
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
        if rs.fetchone(): 
            print('This pet id is already taken')
            rs.close()
            cn.close()
            return

        # get new pet info
        name = input("Please enter the pet's name: ")
        pet_type = input("Please enter the pet's type (dog, cat, etc): ")
        breed = input("Please enter the pet's breed: ")
        bday = input("Please enter the pet's birthdate ('YYYY-MM-DD'): ")
        size = input("Please enter the pet's size (S, M, L, XL): ")
        appearance = input("Please enter the pet's appearance: ")

        # run update
        q = "INSERT INTO pet VALUES (%s,%s,%s,%s,%s,%s,%s)"
        rs = cn.cursor()
        rs.execute(q, (pet_id, name, pet_type, breed, bday, size, appearance))
        cn.commit()

    except mc.Error as err:
        print(err)

    finally:
        rs.close()
        cn.close()
            
        
if __name__ == '__main__':
    main()
