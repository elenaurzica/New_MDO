function MAC = MAC(x)

global data

%x = x .*data.x0;
%x = [4.5  1.04  20.04  4  -7  27  27 0.3156    0.2076 ];

taper = x(2)/x(1);

MAC = (2/3)*x(1)*((1+taper+taper^2)/(1+taper));
end

