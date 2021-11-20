%%% Polar

clear all
CL=0:0.1:1;

for i=1:length(CL)
CD(i)=Start_polar(CL(i));
end

figure
plot(CL,CD,'bo')
grid on

save polardata

%find CDmin and index at which this occurs
[CDmin, index] = min(CD);
%find CL at CDmin
CLmin = CL(index);

%polynomial fit of (CL-CLmin)^2 to CD-CDmin
%note the . operator to apply the square to every element of the vector,
%instead of taking the square of the vector
[k] = polyfit((CL-CLmin).^2,CD-CDmin,1);

%compute according to fit
CDplot = (k(2)+CDmin) + k(1)*(CL-CLmin).^2;

%plot
hold on
plot (CL,CDplot,'-g');
hold off

