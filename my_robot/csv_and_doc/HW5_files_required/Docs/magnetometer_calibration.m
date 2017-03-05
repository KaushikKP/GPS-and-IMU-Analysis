% NOTE==>Please,import the rawimudata.csv file and name the variables according to the
% structure.

%======hard-Iron-calibration======%
subplot(1,2,1);
plot(magx(2700:5000),magy(2700:5000));
xlabel('magx(gaussian)')
ylabel('magy(gaussian)')
title('magnetometer-before-calibration')
grid on;

alpha=(min(magx(2700:5000))+max(magx(2700:5000)))/2;
beta=(min(magy(2700:5000))+max(magy(2700:5000)))/2;

magx_cal=(magx(2700:5000))-alpha;%hard-iron calibrated x-values
magy_cal=(magy(2700:5000))-beta;%hard-iron calibrated y-values
subplot(1,2,2);
plot(magx_cal,magy_cal);
xlabel('magx_ cal(gaussian)')
ylabel('magy_ cal(gaussian)')
title('magnetometer-hard-iron-calibration')
grid on;
%======hard-Iron-calibration======%

%========Soft-Iron-calibration====%
figure;
subplot(1,2,1);
plot(magx(2700:5000),magy(2700:5000));
xlabel('magx(Gauss)');
ylabel('magy(Gauss)');
title('magnetometer-before-calibration')
grid on;
temp=(zeros(2301,1));
for i=1:size(magx_cal)
temp(i)=(sqrt((magx_cal(i)*magx_cal(i))+(magy_cal(i)*magy_cal(i))));
end
r=(max(temp));%major-axis-length
q=min(temp);%minor-axis-length
sigma=q/r;%scaling-factor
for i=1:size(magx_cal)
%temp(i)=(sqrt((magx_cal(i)*magx_cal(i))+(magy_cal(i)*magy_cal(i))));
if(r==temp(i))
    y1=magy_cal(i);
    disp(y1);
end
end

theta=asin((y1/r));

R=[cos(theta) sin(theta);-sin(theta) cos(theta)];%rotating matrix

v=[magx_cal magy_cal];

v1=v*R;

%figure
magx_cal_sf=v1(:,1);%magx after rotation
magy_cal_sf=v1(:,2);%magy after rotation
%plot(magx_cal_sf,magy_cal_sf);
magx_cal_sf1=magx_cal_sf/sigma;%scaling the x-axis

v=[magx_cal_sf1 magy_cal_sf];
theta1=-theta;
R1=[cos(theta1) sin(theta1);-sin(theta1) cos(theta1)];

v1=v*R1;%rotating back again after scaling

magx_cal_sf2=v1(:,1);
magy_cal_sf=v1(:,2);

subplot(1,2,2);
plot(magx_cal_sf2,magy_cal_sf);
xlabel('magx_ cal_ sf(gaussian)')
ylabel('magy_ cal_ sf(gaussian)')
grid on;
title('magnetometer after soft-iron-calibration');
%========Soft-Iron-calibration====%

%======YawAngle Calculation======%
yaw_corrected=yaw;
for i=1:size(magx_cal_sf2)
yaw_corrected(i+2699)=atan2((magx_cal_sf2(i)),(magy_cal_sf(i)));
end

figure;
plot(yaw_corrected);





