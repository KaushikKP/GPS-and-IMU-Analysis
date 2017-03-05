corrected_mag_yaw=size(yaw);
for i=1:size(magx_soft)
corrected_mag_yaw(i)=atan2((magx_soft(i)),(magy_soft(i)));
end

figure;
subplot(1,2,1);
plot(yaw);
subplot(1,2,2);
plot(corrected_mag_yaw);