function [f,vararg] = Optim_IDF(x)
      
    global data;
    
    %vararg = {res_loads, res_aero, weight_fuel, weight_str_wing};
    
    data.res_loads = loads(x);
    data.res_aero = aerodynamics(x);
    data.weight_fuel = performance(x);
    data.weight_str_wing = structures(x);
    data.fuel_tankvv = fuel_tank_volume(x);

    f = objective(data.weight_fuel,data.weight_str_wing);
    
end