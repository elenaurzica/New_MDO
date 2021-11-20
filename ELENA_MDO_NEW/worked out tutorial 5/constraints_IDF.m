function [c,ceq] = constraints_IDF(x)
%function computing constraints of the sellar problem
global data;
res_loads = data.res_loads;

res_aero = data.res_aero; 
weight_fuel = data.weight_fuel;
weight_str_wing = data.weight_str_wing; 
fuel_tankvv= data.fuel_tankvv;


%consistency constraints = target-actual variables
cc_cl = res_loads(:,1)'./x(34:47) -  ones(size(x(34:47)));  %cc_cl = res_loads[1:14]/cl_target - 1
cc_cm = res_loads(:,2)'./x(48:61) - ones(size(x(48:61)));  

% SAU cc_c1(1:14) = constants.Cl / 

cc_CL = (res_aero(1)/x(32) - 1);
cc_CD = (res_aero(2)/x(33) -1);

cc_fuel = weight_fuel/(x(63)*2865) - 1;    %cc_fuel = Wfuel/Wfueltarget - 1 si Wfueltarget = x(63)*W_fuel_Ref
cc_wing = weight_str_wing/(x(62)*1015.5) - 1;  %cc_wing

fuel_vol = weight_fuel/(0.81715e+3);
fuelvol_ref = 2865/(0.81715e+3);
fueltank_ref = 5.3559;

%initialfuelvol = x(63)/(0.81715e+3);
%inequality constraints - fuel volume 
%c1 = (fuel_vol/4.7551) / (fuel_tankvv*0.93/4.7551) - 1  ;        %fuel_vol/fuelvol_ref-1;     %c1 = fuel_volume(x)/fuel_vol_Ref - 1
c1 = (fuel_vol/(fuel_tankvv)) / (fuelvol_ref/fueltank_ref) - 1;

MTOW = data.weight_AW + weight_fuel + weight_str_wing;

%WS CONSTAINT
wing_loading_ref = 19200/(2*25.06);   %376. the actual ref value is 375 so very good.
c2 = (MTOW/(wing_surface(x)*2))/wing_loading_ref - 1;   

c = [c1,c2];
ceq =  [cc_cl, cc_cm, cc_CL, cc_CD, cc_fuel, cc_wing];


end