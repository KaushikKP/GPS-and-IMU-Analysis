subplot(1,2,1);
plot(magx,magy);
xlabel('magx-hard(Gauss)');
ylabel('magy-hard(Gauss)');
hold on
new=(rand(1000,1));

for i=1:size(magx)
  new(i)=(sqrt((magx(i)*magx(i))+(magy(i)*magy(i))));
end

r=(max(new));%major-axis-length
q=min(new);%minor-axis-length
sig=q/r;%scaling-factor

for i=1:size(magx)
  new(i)=(sqrt((magx(i)*magx(i))+(magy(i)*magy(i))));
if(r==new(i))
    y1=magy(i);
    %disp(y1);
end
end

title('magnetometer with hard iron calibration')
grid on;

theta=asin((y1/r));

Rotation=[cos(theta) sin(theta);-sin(theta) cos(theta)];%rotating matrix

v=[magx magy];

v1=v*Rotation;

%figure
magx_soft=v1(:,1);%magx after rotation
magy_soft=v1(:,2);%magy after rotation
%plot(magx_cal_sf,magy_cal_sf);
magx_soft=magx_soft/sig;%scaling the x-axis

v=[magx_soft magy_soft];
theta=-theta;
Rotation_new=[cos(theta) sin(theta);-sin(theta) cos(theta)];

v1=v*Rotation_new;%rotating back again after scaling

magx_soft=v1(:,1);
magy_soft=v1(:,2);

subplot(1,2,2);
plot(magx_soft,magy_soft);
xlabel('magx-soft(Gauss)')
ylabel('magy-soft(Gauss)')
grid on;
title('magnetometer with soft iron calibration');
%legend('after hard','after soft');