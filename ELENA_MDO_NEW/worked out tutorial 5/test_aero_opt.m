%% Test optimization for the aerodynamic viscous analysis
clear all
clc 

x0=[1];

lb=[0.5];

ub=[3];


% Options for the optimization
options.Display         = 'iter';
options.Algorithm       = 'sqp';
options.FunValCheck     = 'off';
options.DiffMinChange   = 5e-2;         % Minimum change while gradient searching
options.DiffMaxChange   = 5e-1;         % Maximum change while gradient searching
% options.TolCon          = 1e-6;         % Maximum difference between two subsequent constraint vectors [c and ceq]
options.TolFun          = 1e-2;         % Maximum difference between two subsequent objective value
% options.TolX            = 1e-6;         % Maximum difference between two subsequent design vectors
options.PlotFcns = {@optimplotfval, @optimplotx, @optimplotfirstorderopt};


options.MaxIter         = 15;           % Maximum iterations
options.MaxFunctionEvaluations = 30;        

tic;
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@aero_fun,x0,[],[],[],[],lb,ub,[],options);
toc;







