%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Quasi-3D aerodynamic solver      
%
%       A. Elham, J. Mariens
%        
% 
%MODIFIED by: F. Oliviero for the execution of the exercise 6 (optimization) of the
%tutorial 5 (AY 2018-2019)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% OUTPUT DESCRIPTION:

% Res.Alpha   = Wing angle of attack
% Res.CLwing  = Total wing lift coefficient
% Res.CDwing  = Total wing drag coefficient
% Res.Wing.aero.Flight_cond = flight conditions including angle of attack
%                             (alpha), sideslip angle (beta), Mach number (M), airspeed (V) and air
%                              density (rho)
% Res.Wing   = Spanwise distribution of aerodynamic and geometrical
%              properties of wing 
%              For example plot(Res.Wing,Yst,Res.Wing.cl) plots spanwise
%              distribution of cl
% Res.Section   = aerodynamic coefficients of 2D sections 


%%

function [EFF]=aero_fun(x)

%% Aerodynamic solver setting

b=14*x(1);
% Ct=3.5*x(2);
% b=x;

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0     0     0     3.5         0;
                0.9   b   0     1.4         0];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
% 0.233676824214197 0.0798403025605576 0.267697528654844 0.0894726099510041 0.278239989615759 0.381449094638014 -0.225286477861666 -0.163960902286885 -0.0457664324933490 -0.478742327080084 0.0748219790615124 0.324844808924198
AC.Wing.Airfoils   = [0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797;
                     0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797];
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
AC.Aero.V     = 68;            % flight speed (m/s)
AC.Aero.rho   = 1.225;         % air density  (kg/m3)
AC.Aero.alt   = 1000;             % flight altitude (m)
AC.Aero.Re    = 1.64e7;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.20;           % flight Mach number 
% AC.Aero.CL    = 0.1;          % lift coefficient - comment this line to run the code for given alpha%
AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 

Res = Q3D_solver(AC);

% EFF=-(Res.CLwing/Res.CDwing)/41.80;

EFF=-(Res.CLwing/Res.CDwing);









