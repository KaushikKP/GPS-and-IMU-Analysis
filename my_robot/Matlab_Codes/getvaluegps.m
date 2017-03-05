% Let’s assume the logging file is lcm-l.02 in the dir below
% open log file for reading

log_file = lcm.logging.Log('/home/kpdare28/my_robot/my_robot/attempts2/run/lcmlog-2017-02-18.01', 'r'); 

% now read the file 
utm_x= single(rand(1000,1));
utm_y = single(rand(1000,1));
latit= single(rand(1000,1));
longit= single(rand(1000,1));
i=0;

while true
 try
   ev = log_file.readNext();
   
   % channel name is in ev.channel
   % there may be multiple channels but in this case you are only interested in RDI channel
   %disp(ev.channel);
   %disp(ev.channel);
   if strcmp(ev.channel, 'GPS_Channel')
      rdi = exlcm.gps_message(ev.data);
      i=i+1;
      utm_x(i) = rdi.easting;
      utm_y(i) = rdi.northing;
      latit(i) = rdi.latitude;
      longit(i) = rdi.longitude;
   end
 catch err   % exception will be thrown when you hit end of file
   break;
end
end
