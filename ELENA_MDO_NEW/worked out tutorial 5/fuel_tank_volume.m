function [V_tank] = fuel_tank_volume(x)

global data
x = x .* data.x0;

import D_airfoil2.*
% x = [4.5 1.04 20.04  4  -7  27  27 0.3156    0.2076    0.2577  0.1669    0.2176   0.1868   -0.1133 -0.0853   -0.2094   -0.0577 -0.1707     -0.1192 0.2712    0.2148 0.1857    0.1861  0.1684   0.1727   -0.0957   -0.0388 -0.2101   -0.0114   -0.1612  -0.0911...
%     0.482 0.0185 1.7080  1.7316 1.7636  1.7908 1.7985 1.7534 1.6533   1.5145    1.3446  1.1485  0.9300 0.6935  0.4455  0.2005 ...
%     -0.1795 -0.1396 -0.1089  -0.0845  -0.0639  -0.0459 -0.0349 -0.0286 -0.0240 -0.0210 -0.0186 -0.0175 -0.0176 -0.0191 1015.5 2865];

%Root Airfoil 
root_upper_CST = [x(8),  x(9),  x(10),  x(11),  x(12), x(13)];
root_lower_CST = [x(14), x(15), x(16), x(17), x(18), x(19)];

root_upper_CST = root_upper_CST';
root_lower_CST = root_lower_CST';

X = linspace(0,1,99)';

[Xtu_root, Xtl_root] = D_airfoil2(root_upper_CST,root_lower_CST,X);

x_u_root = Xtu_root(:,1);
y_u_root = Xtu_root(:,2);
x_l_root = Xtl_root(:,1);
y_l_root = Xtl_root(:,2);

%Tip Airfoil
tip_upper_CST = [x(20)   x(21)   x(22)   x(23)   x(24)   x(25)];
tip_lower_CST = [x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];

tip_upper_CST = tip_upper_CST';
tip_lower_CST = tip_lower_CST';

[Xtu_tip, Xtl_tip] = D_airfoil2(tip_upper_CST,tip_lower_CST,X);

x_u_tip = Xtu_tip(:,1);
y_u_tip = Xtu_tip(:,2);
x_l_tip = Xtl_tip(:,1);
y_l_tip = Xtl_tip(:,2);

thickness_avg_root = 0;
thickness_avg_tip = 0;

for i=1:length(X)   
    thickness_avg_root = thickness_avg_root + (y_u_root(i)-y_l_root(i));
    thickness_avg_tip = thickness_avg_tip + (y_u_tip(i)-y_l_tip(i));
end

thickness_avg_tip = thickness_avg_tip/length(X);
thickness_avg_root = thickness_avg_root/length(X);


V_tank =(0.5*x(3)*0.85)*(x(1)+x(2))*(data.rearspar - data.frontspar)*0.5*(thickness_avg_root*x(1) + thickness_avg_tip*x(2));

end

