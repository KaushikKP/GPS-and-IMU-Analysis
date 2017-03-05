xmax = max(magx);
ymax = max(magy);
xmin = min(magx);
ymin = min(magy);
a = (xmax+xmin)/2;
b = (ymax+ymin)/2;
magx = magx - a;
magy = magy - b;
%plot(magx,magy);
%figure
plot(magx,magy)
xlabel('magx-after');
ylabel('magy-after');