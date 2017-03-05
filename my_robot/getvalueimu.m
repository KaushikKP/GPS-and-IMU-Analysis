% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading

log_file = lcm.logging.Log('/home/kpdare28/my_robot/HomeWork_5/my_robot/logfiles_gps_imu/run/lcmlog-2017-02-18.02','r'); 

% now read the file 
i=0;
time = single(rand(1000,1));
yaw = single(rand(1000,1));
pitch = single(rand(1000,1));
roll = single(rand(1000,1));
magx = single(rand(1000,1));
magy = single(rand(1000,1));
magz = single(rand(1000,1));
accelx = single(rand(1000,1));
accely = single(rand(1000,1));
accelz = single(rand(1000,1));
gyrox = single(rand(1000,1));
gyroy = single(rand(1000,1));
gyroz = single(rand(1000,1));

while true
 try
   ev = log_file.readNext();
   %i = 0;
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   %disp(ev.channel);
   %yaw = [1000];
  
   if strcmp(ev.channel, 'IMU')
 
     % build rdi object from data in this record
      rdi = exlcm.imu_message(ev.data);
      i = i+1;
      % now you can do things like depending upon the rdi_t struct that was defined
      time(i) = ev.utime;
      yaw(i) = rdi.yaw;
      pitch(i) = rdi.pitch;
      roll(i) = rdi.roll;
      magx(i) = rdi.magx;
      magy(i) = rdi.magy;
      magz(i) = rdi.magz;
      accelx(i) = rdi.accelx;
      accely(i) = rdi.accely;
      accelz(i) = rdi.accelz;
      gyrox(i) = rdi.gyrox;
      gyroy(i) = rdi.gyroy;
      gyroz(i) = rdi.gyroz;
      
   %disp(ev.channel);
 end
 catch err   % exception will be thrown when you hit end of file
   break;
end
end
