#!/usr/bin/python3

import ssl
import sys


cert = ssl.get_server_certificate((sys.argv[1], sys.argv[2]))
print(cert.strip())
