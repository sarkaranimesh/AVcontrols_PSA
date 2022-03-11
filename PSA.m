function a_max = PSA(V_limit,dl,V_current,d_current)
if V_current < V_limit+0.2
    a_max = 2; % mpss
    
elseif V_current > V_limit+0.2
    a_max = -2; % mpss
else 
    a_max = 0;

end