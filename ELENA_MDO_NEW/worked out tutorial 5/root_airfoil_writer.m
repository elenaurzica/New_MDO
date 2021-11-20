

function root_airfoil_writer(Xtu,Xtl)

airfoil_root = fopen('airfoil_root.dat','wt');

x_u_root = Xtu(:,1);
y_u_root = Xtu(:,2);
x_l_root = Xtl(:,1);
y_l_root = Xtl(:,2);

x_u_root = flip(x_u_root);
y_u_root = flip(y_u_root);


for point = 1:length(x_u_root)
    format_line = '%f %f \n';
    fprintf(airfoil_root, format_line, x_u_root(point), y_u_root(point));
end

for point = 1:length(x_l_root)
    format_line = '%f %f \n';
    fprintf(airfoil_root, format_line, x_l_root(point), y_l_root(point));
end

fclose('all')
end

    