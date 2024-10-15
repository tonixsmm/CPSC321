"""HW5 Main File.

NAME: Tony Nguyen
DATE: Fall 2023
CLASS: CPSC 322

"""

import mysql.connector as mc
import config
from utils import *

try:
    # get connection info
    hst = config.host
    dat = config.database
    usr = config.user
    pwd = config.password
    
    # create connection
    cn = mc.connect(host=hst, database=dat, user=usr, password=pwd)
    
    # run the program
    run_program(cn)
        
except mc.Error as err:
    print(err)