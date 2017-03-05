x_diff = cumtrapz(accelx);
omega = size(gyroz_new);
for i=1:size(gyroz_new)
 omega(i) = x_diff(i)*gyroz_new(i);
end

subplot(2,2,1);
plot(accely);
title('acceleration-y');
xlabel('');
ylabel('');

subplot(2,2,2);
plot(omega);
title('omega');
xlabel('');
ylabel('');

subplot(2,2,3);
plot(accely);
hold on
plot(omega);
legend('accely','omega');
title('both');
xlabel('');
ylabel('');