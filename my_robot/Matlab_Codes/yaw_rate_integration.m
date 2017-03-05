%t = linspace(-180,180);
fc=9;
fs=40;
Wn = fc/(fs/2);
%[b,a] = butter(1,Wn,'low');
%{
[z, p, k] = butter(1, Wn,'high');
[sos_var,g] = zp2sos(z, p, k);
Hd = dfilt.df2sos(sos_var, g);
%}
%gy = filter(Hd,input_data);
gyrom = gyroz_new(5000:end) * 57.5958/40;
gyrocum = cumtrapz(gyrom);
%gz = filtfilt(b,a,gyrom);
%gy = filter(Hd,gyrom);
plot(yaw_new(5000:end));
hold on
%plot(gy);
%hold on
plot(gyrocum);
legend('raw yaw value','integrated yaw rate value');
xlabel('time');
ylabel('degree');