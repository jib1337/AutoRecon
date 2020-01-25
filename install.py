#!/usr/bin/env python3

import os

RECON_DIR  = os.path.dirname(os.path.realpath(__file__))
print("Installing Requirements ...")
os.system("pip3 install -r requirements.txt")
print("Copying Files ...")
os.system("cp -r %s /opt" %RECON_DIR)
print("Linking files ...")
os.system("chmod +x /opt/AutoRecon-OSCP/autorecon.py")
os.system("chmod +x /opt/AutoRecon-OSCP/cherrycon.py")
os.system("ln -s /opt/AutoRecon-OSCP/autorecon.py /usr/bin/autorecon")
os.system("ln -s /opt/AutoRecon-OSCP/cherrycon.py /usr/bin/cherrycon")

