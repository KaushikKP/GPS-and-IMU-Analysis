figure;
subplot(1,2,1);
plot(magx,magy);
xlabel('magx(Gauss)');
ylabel('magy(Gauss)');
title('magnetometer-before-calibration')
grid on;
temp=(zeros(1000,1));
for i=1:size(magx)
temp(i)=(sqrt((magx(i)*magx(i))+(magy(i)*magy(i))));
end
r=(max(temp));%major-axis-length
q=min(temp);%minor-axis-length
sigma=q/r;%scaling-factor
for i=1:size(magx)
%temp(i)=(sqrt((magx(i)*magx(i))+(magy(i)*magy(i))));
if(r==temp(i))
    y1=magy(i);
    %disp(y1);
end
end

theta=asin((y1/r));

R=[cos(theta) sin(theta);-sin(theta) cos(theta)];%rotating matrix

v=[magx magy];

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