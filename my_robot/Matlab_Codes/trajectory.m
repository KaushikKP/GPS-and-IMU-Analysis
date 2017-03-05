%--------------------------------------------------------------------
%%
%--------------------------------------------------------------------

accelx_new_value = accelx_new;

for i=1:size(pitch)
    accelx_new_value(i) = accelx_new_value(i)-(9.8*cosd(90-pitch(i)));
end

vx = cumtrapz(accelx_new_value/40);

for i=1:size(corrected_mag_yaw)
    vn(i) = -vx(i)*cosd(corrected_mag_yaw(i));
    ve(i) = -vx(i)*sind(corrected_mag_yaw(i));
end

xn = cumtrapz(vn);
xe = cumtrapz(ve);

%xn = -xn;
%xe = -xe;

z1 = min(utmx_new)
z2 = min(utm_ynew)

for i=1:size(utmx_new)
    utmx_new(i) = utmx_new(i) - z1;
    utm_ynew(i) = utm_ynew(i) - z2;
end

subplot(1,2,1);
plot(xe/144,xn/96,'r') %scaling xe,xn to match with utmx,utmy
xlabel('xe');
ylabel('xn');
title('xe vs xn');
subplot(1,2,2);
plot (utmx_new,utm_ynew);
xlabel('utm_x');
ylabel('utm_y');
title('raw utm-x vs utm-y');

%legend('xe vs xn','utmx vs utmy')
