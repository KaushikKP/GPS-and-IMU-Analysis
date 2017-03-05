#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for GPS sensor

import sys
import lcm
import time
import serial
import utm
from exlcm import gps_message
#import seabed_lcm
dbmode = True; 

class GPSclass(object):
	def __init__(self, port_name):
		if not dbmode:
			self.port = serial.Serial(port_name, 4800, timeout=1.)  # 4800-N-8
			print 'Connected to:'+ self.port.portstr
			
		self.lcm = lcm.LCM("udpm://?ttl=12")
		self.packet = gps_message()
		print 'GPS: Initialization started'
		
		while True:
			if dbmode:
				line = '$GPGGA,183730,3907.356,N,7105.076,W,1,05,1.6,646.4,M,-24.1,M,,*75'
			else:
				line = self.port.readline()
			if line.startswith('$GPGGA'):
				print line
				print 'GPS: Initialization completed'
				break


	def readloop(self):
		while True:
			if dbmode:
				line = '$GPGGA,183730,4220.3071,N,7105.076,W,1,05,1.6,646.4,M,-24.1,M,,*75'
				time.sleep(1)

			else:
				line = self.port.readline()
			while not line.startswith('$GPGGA'):
				line = self.port.readline()
#           try:
			gtimest,latst, latdir, lonst, londir, _, _, _,altstring = line.strip().split(',')[1:10]
			gtime = int(float(gtimest))

			lat = (float(latst)%100)/60 + float(latst)//100
			if latdir == 'S':
				lat*=-1
				
			lon = (float(lonst)%100)/60 + float(lonst)//100
			if londir == 'W':
				lon*=-1

			alt = float(altstring)
			print 'lat = %.4f' %(lat)

			#UTM
			#The syntax is utm.from_latlon(LATITUDE, LONGITUDE).
			#The return has the form (EASTING, NORTHING, ZONE NUMBER, ZONE LETTER).

			eastingstr,northingstr,zonenum,zonelet = utm.from_latlon(lat,lon)
			easting= float(eastingstr)
			northing=float(northingstr)
			print line
			print 'Time: %06i  Lat: %.4f  Lon: %.4f Alt: %.4f Easting: %.4f  Northing: %.4f' %(gtime, lat, lon, alt,easting, northing)
		
			#self.packet.timestamp = time.time() * 1e6 # micro sec passed from 1970/1/1
			self.packet.gpstime = gtime
			self.packet.latitude = lat
			self.packet.longitude = lon
			self.packet.altitude = alt
			self.packet.easting = easting
			self.packet.northing = northing			
			self.lcm.publish("GPS_Channel", self.packet.encode())
#	    except:
#                 print 'GPS ERROR (' + line + ')'
        
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    mygpsobj = GPSclass(sys.argv[1])
    mygpsobj.readloop()
