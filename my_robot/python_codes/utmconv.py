#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for GPSUTM

import sys
import lcm
import time
import serial
from exlcm import gps_message
import utm
lc = lcm.LCM()
#fi = open("dump-error.txt","w")
def dms2dd(degrees, minutes, direction):
    dd = float(degrees) + float(minutes)/60
    if direction == 'S' or direction =='W':
       dd*=-1
    return dd

class gps(object):
    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 4800, timeout=1.)  # 9600-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.packet = gps_message()
        #while True:
        print 'GPS: Initialization'


    def readloop(self):
        while True:
            line = self.port.readline()
            lati = ''
            longi = ''
            latitude = ''
            longitude = ''
            self.packet.timestamp = time.time()*1e6
            self.packet.timestamp = 0
            self.packet.latitude = 0.00
            self.packet.longitude = 0.00
            self.packet.altitude = 0.00
            self.packet.easting = 0.00
            self.packet.northing = 0.00
            easting = 0.00
            northing = 0.00

            gpsval = line.split(',')
            self.packet.timestamp = time.time()*1e6
            if gpsval[0]=="$GPGGA":
                  if len(gpsval)>1 and gpsval[1]!='':
                    self.packet.gpstime = int(gpsval[1])
                  if len(gpsval)>2 and gpsval[2]!='':
                    self.packet.latitude = float(gpsval[2])
                  if len(gpsval)>3 and gpsval[3]!='':
	            latitude=gpsval[3]
		#	  self.packet.latitude=dms2dd(lati[0:2],lati[2:],gpsval[3])
                  if len(gpsval)>4 and gpsval[4]!='':
                    self.packet.longitude = float(gpsval[4])
                  if len(gpsval)>5 and gpsval[5]!='':
	            longitude=gpsval[4]
			#  self.packet.longitude=dms2dd(longi[0:2],longi[2:],gpsval[5])
                  if len(gpsval)>9 and gpsval[9]!='':
                    self.packet.altitude = float(gpsval[9])

		  if gpsval[2] != '':
			lati=gpsval[2]
			easting=dms2dd(lati[0:2],lati[2:],latitude)
		  if gpsval[4] != '':
			longi=gpsval[4]
			northing=dms2dd(longi[0:3],longi[3:],longitude)                  

                  utm_x = 0.00
                  utm_y = 0.00


                  utm_xy = utm.from_latlon(easting,northing)
                  self.packet.easting = utm_xy[0]
                  self.packet.northing = utm_xy[1]
                  print gpsval
        	  print "(utm_x =",
                  print self.packet.easting,
                  print ","
                  print "utm_y =",
                  print self.packet.northing,
                  print ")"


                  lc.publish("GPS", self.packet.encode())
#	fi.close()

        
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    mygps = gps(sys.argv[1])
    mygps.readloop()
