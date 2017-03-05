#!/usr/bin/env python
# -*- coding: utf-8 -*-
# for IMU

import sys
import lcm
import time
import serial
from exlcm import imu_message
lc = lcm.LCM()
#fi = open("dump1.txt","w")

class imu(object):

    def __init__(self, port_name):
        self.port = serial.Serial(port_name, 115200, timeout=1.)  # 9600-N-8-1
        self.lcm = lcm.LCM("udpm://?ttl=12")
        self.packet = imu_message()
        #while True:
        print 'IMU: Initialization'

    def readloop(self):
        while True:
            line = self.port.readline()
            
            imuval = line.split(',')
            if imuval[0]=="$VNYMR":
                  self.packet.timestamp = time.time()*1e6
                  self.packet.yaw = float(imuval[1])
                  if len(imuval)>2 and imuval[2]!='':
                    self.packet.pitch = float(imuval[2])
                  if len(imuval)>3 and imuval[3]!='':
                    self.packet.roll = float(imuval[3])
                  if len(imuval)>4 and imuval[4]!='':
                    self.packet.magx = float(imuval[4])
                  if len(imuval)>5 and imuval[5]!='':
                    self.packet.magy = float(imuval[5])
                  if len(imuval)>6 and imuval[6]!='':
                    self.packet.magz = float(imuval[6])
                  if len(imuval)>7 and imuval[7]!='':
                    self.packet.accelx = float(imuval[7])
                  if len(imuval)>8 and imuval[8]!='':
                    self.packet.accely = float(imuval[8])
                  if len(imuval)>9 and imuval[9]!='':
                    self.packet.accelz = float(imuval[9])
                  if len(imuval)>10 and imuval[10]!='':
                    self.packet.gyrox = float(imuval[10])
                  if len(imuval)>11 and imuval[11]!='':
                    self.packet.gyroy = float(imuval[11])
                  if len(imuval)>12 and imuval[12]!='':
                    self.packet.gyroz = float(imuval[12].split('*')[0])

                  print imuval

                  lc.publish("IMU", self.packet.encode())

        
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print "Usage: %s <serial_port>\n" % sys.argv[0]
        sys.exit(0)
    myimu = imu(sys.argv[1])
    myimu.readloop()
