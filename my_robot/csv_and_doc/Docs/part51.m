%--------------------------------------------------------------------
%%Omega*(integral X)comparison with observed accel-y
%--------------------------------------------------------------------

x_int = cumtrapz(accelx);
omega = size(gyroz_new);
for i=1:size(gyroz_new)
 omega(i) = x_int(i)*gyroz_new(i);
end

subplot(2,2,1);
plot(accely);
title('acceleration-y');
xlabel('time');
ylabel('meters/second^2');

subplot(2,2,2);
plot(omega);
title('omega * integral(X)');
xlabel('time');
ylabel('meters/second^2');

subplot(2,2,3);
plot(accely);
hold on;
plot(omega);
legend('accely','omega');
title('both accely and omega*integral(X)');
xlabel('time');
ylabel('meters/second^2');
hold off;