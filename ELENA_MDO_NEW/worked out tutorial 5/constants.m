global data;

data.y_kink = 3.66;
data.dihedral = 4;

data.root_kink = 0;
%data.weight_AW = 17955; old
data.weight_AW = 15319.5;
data.MZFW = 0;
data.C_T = 2.36*10^(-4);  %changed it to get Wfuel same
%data.DAW = 5553;
data.DAW = 4471.581769; %calculated: = CDA-W *0.5*0.348*210^2*(25.0643*2). and CDA-W by L/D 16 equalled to 0.482/(0.0185+CDA-W) gives 0.011625
data.R = 1390000;

data.rearspar = 0.6;
data.frontspar = 0.15;
data.MTOWinitial = 19200; %kg

%data.ctw = 5;