%%%_____Routine to write the input file for the EMWET procedure________% %%
function write_init = write_init(x)
global data

x = x .* data.x0;
import wing_surface.*
% x = [4.5 1.04 20.04  4  -7  27  27 0.3156    0.2076    0.2577  0.1669    0.2176   0.1868   -0.1133 -0.0853   -0.2094   -0.0577 -0.1707     -0.1192 0.2712    0.2148 0.1857    0.1861  0.1684   0.1727   -0.0957   -0.0388 -0.2101   -0.0114   -0.1612  -0.0911...
%     0 0 1.7080  1.7316 1.7636  1.7908 1.7985 1.7534 1.6533   1.5145    1.3446  1.1485  0.9300 0.6935  0.4455  0.2005 ...
%     -0.1795 -0.1396 -0.1089  -0.0845  -0.0639  -0.0459 -0.0349 -0.0286 -0.0240 -0.0210 -0.0186 -0.0175 -0.0176 -0.0191 1015.3 2865];
%        
x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);


namefile    =    char('our_airfoil');
MTOW        =    (x(62) + x(63) + data.weight_AW);     %20820;         %[kg]
MZF         =     MTOW - x(63); %17100;                %momentan e ct. data.weight_A-W +x(62);  % a-w minus w_str_wing         %[kg]
nz_max      =    2.5;   
span        =    x(3);            %[m]
root_chord =    x(1);    %x()*x_Ref       %[m]
taper       =    x(2)/x(1) ;          
sweep_le    =    5;             %but doesnt matter because I'm not using it to calculate the area[deg]
spar_front  =    0.15;
spar_rear   =    0.6;
ftank_start =    0.1;
ftank_end   =    0.85;
eng_num     =    0;
eng_ypos    =    0;
eng_mass    =    0;         %kg
E_al        =    7e10;       %N/m2
rho_al      =    2800;         %kg/m3
Ft_al       =    2.95e8;        %N/m2
Fc_al       =    2.95e8;        %N/m2
pitch_rib   =    0.5;          %[m]
eff_factor  =    0.96;             %Depend on the stringer type
Airfoil_root     =  'airfoil_root';
Airfoil_tip     =   'airfoil_tip';
section_num =    3;
airfoil_num =    2;
wing_surf   =     wing_surface(x) * 2;  %0.5*x(1)*(1+(x(2)/x(1)))*x(3);

fid = fopen( 'our_airfoil.init','wt');
fprintf(fid, '%g %g \n',MTOW,MZF);
fprintf(fid, '%g \n',nz_max);

fprintf(fid, '%g %g %g %g \n',wing_surf,span,section_num,airfoil_num);

fprintf(fid, '0 %s \n',Airfoil_root);
fprintf(fid, '1 %s \n',Airfoil_tip);
fprintf(fid, '%g %g %g %g %g %g \n',x(1),   0,  0,  0,  spar_front, spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',    chord_kink,     x_LE_kink,  y_LE_kink,  z_LE_kink,  spar_front, spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',x(2),   x_LE_tip,   y_LE_tip,   z_LE_tip,   spar_front, spar_rear);  %done

fprintf(fid, '%g %g \n',ftank_start,ftank_end);

fprintf(fid, '%g \n', eng_num);
%fprintf(fid, '%g  %g \n', eng_ypos,eng_mass);

fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);

fprintf(fid,'%g %g \n',eff_factor,pitch_rib)
fprintf(fid,'0 \n')
fclose(fid)
end