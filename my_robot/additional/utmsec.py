#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for NBOSI-CT sensor (seabed 125)

import sys
import lcm
import time
import serial
from exlcm import example_t
import utm
lc = lcm.LCM()
fi = open("dump-error.txt","w")
def dms2dd(degrees, minutes, direction):
    dd = float(degrees) + float(minutes)/60
    if direction == 'S' or direction =='W':
       dd*=-1
    return dd

class gps(object):
    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 4800, timeout=1.)  # 9600-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.packet = example_t()
        #while True:
        print 'GPS: Initialization'


    def readloop(self):
        while True:
            line = self.port.readline()

            gpsval = line.split(',')
            if gpsval[0]=="$GPGGA":
                  #print gpsval
                  self.packet.time = gpsval[1]
                  if len(gpsval)>2 and gpsval[2]!='':
                    self.packet.latitude = gpsval[2]
                    #print gpsval[2]
                  if len(gpsval)>3 and gpsval[3]!='':
                    self.packet.lat_direction = gpsval[3]
                  if len(gpsval)>4 and gpsval[4]!='':
                    self.packet.longitude = gpsval[4]
                    #print gpsval[4]
                  if len(gpsval)>5 and gpsval[5]!='':
                    self.packet.long_direction = gpsval[5]
                  if len(gpsval)>9 and gpsval[9]!='':
                    self.packet.altitude = gpsval[9]


                  utm_x = 0.00
                  utm_y = 0.00
                  lati = ''
                  longi = ''

		  if self.packet.latitude != '':
			lati=self.packet.latitude
			utm_x=dms2dd(lati[0:2],lati[2:],self.packet.lat_direction)
		  if self.packet.longitude != '':
			longi=self.packet.longitude
			utm_y=dms2dd(longi[0:3],longi[3:],self.packet.long_direction)

		  utm_xy = utm.from_latlon(utm_x,utm_y)
        	  print "(utm_x =",
                  print gpsval[0],
                  print ","
                  print "utm_y =",
                  print gpsval[1],
                  print ")"
                  fi.write("("+str(gpsval[0])+","+str(gpsval[1])+")"+"\n")
                  #fi.flush()

                  lc.publish("GPS", self.packet.encode())
	fi.close()

 #float(gpsval[2].partition('')[-1].rpartition(']')[0]
        
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    mygps = gps(sys.argv[1])
    mygps.readloop()
