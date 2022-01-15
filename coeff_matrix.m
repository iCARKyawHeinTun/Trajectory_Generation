function [constants] = coeff_matrix(waypoints)

constants = zeros(32,3) ;

% syms t_0 t_1 t_2 t_3 t_4
% syms p_0 p_1 p_2 p_3 p_4

n = size (waypoints,1) ;

for i = 1:n

t_0     =   0 ; t_1     =   1 ; t_2     =   2 ; t_3     =   3 ; t_4     =   4 ;

p_0     =   waypoints(i,1) ; 
p_1     =   waypoints(i,2) ;
p_2     =   waypoints(i,3) ; 
p_3     =   waypoints(i,4) ; 
p_4     =   waypoints(i,5) ;

% syms c_11 c_12 c_13 c_14 c_15 c_16 c_17 c_18
% syms c_21 c_22 c_23 c_24 c_25 c_26 c_27 c_28
% syms c_31 c_32 c_33 c_34 c_35 c_36 c_37 c_38
% syms c_41 c_42 c_43 c_44 c_45 c_46 c_47 c_48

A = [  
    
1 t_0 t_0^2 t_0^3 t_0^4 t_0^5 t_0^6 t_0^7         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;     %% I trajectory initial position
0 0 0 0 0 0 0 0         1 t_1 t_1^2 t_1^3 t_1^4 t_1^5 t_1^6 t_1^7         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;     %% II trajectory initial position
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         1 t_2 t_2^2 t_2^3 t_2^4 t_2^5 t_2^6 t_2^7         0 0 0 0 0 0 0 0 ;     %% III trajectory initial position
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         1 t_3 t_3^2 t_3^3 t_3^4 t_3^5 t_3^6 t_3^7 ;     %% IV trajectory initial position
1 t_1 t_1^2 t_1^3 t_1^4 t_1^5 t_1^6 t_1^7         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;     %% I trajectory final position
0 0 0 0 0 0 0 0         1 t_2 t_2^2 t_2^3 t_2^4 t_2^5 t_2^6 t_2^7         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;     %% II trajectory final position
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         1 t_3 t_3^2 t_3^3 t_3^4 t_3^5 t_3^6 t_3^7         0 0 0 0 0 0 0 0 ;     %% III trajectory final position
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         1 t_4 t_4^2 t_4^3 t_4^4 t_4^5 t_4^6 t_4^7 ;     %% IV trajectory final position

0 1 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;                               %% initial velocity
0 0 2 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;                               %% initial acceleration
0 0 0 6 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0 ;                               %% initial jerk
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 1 2*t_4 3*t_4^2 4*t_4^3 5*t_4^4 6*t_4^5 7*t_4^6   %% final velocity
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 2 6*t_4 12*t_4^2 20*t_4^3 30*t_4^4 42*t_4^5     %% final acceleration
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0         0 0 0 6 24*t_4 60*t_4^2 120*t_4^3 210*t_4^4         %% final jerk

0 1 2*t_1 3*t_1^2 4*t_1^3 5*t_1^4 6*t_1^5 7*t_1^6       0 -1 -2*t_1 -3*t_1^2 -4*t_1^3 -5*t_1^4 -6*t_1^5 -7*t_1^6         0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0     %% I trajectory final velocity = II trajectory initial velocity
0 0 0 0 0 0 0 0         0 1 2*t_2 3*t_2^2 4*t_2^3 5*t_2^4 6*t_2^5 7*t_2^6        0 -1 -2*t_2 -3*t_2^2 -4*t_2^3 -5*t_2^4 -6*t_2^5 -7*t_2^6       0 0 0 0 0 0 0 0      %% II trajectory final velocity = III trajectory initial velocity
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 1 2*t_3 3*t_3^2 4*t_3^3 5*t_3^4 6*t_3^5 7*t_3^6         0 -1 -2*t_3 -3*t_3^2 -4*t_3^3 -5*t_3^4 -6*t_3^5 -7*t_3^6      %% III trajectory final velocity = IV trajectory initial velocity

0 0 2 6*t_1 12*t_1^2 20*t_1^3 30*t_1^4 42*t_1^5         0 0 -2 -6*t_1 -12*t_1^2 -20*t_1^3 -30*t_1^4 -42*t_1^5        0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0       %% I trajectory final acceleration = II trajectory initial acceleration
0 0 0 0 0 0 0 0         0 0 2 6*t_2 12*t_2^2 20*t_2^3 30*t_2^4 42*t_2^5         0 0 -2 -6*t_2 -12*t_2^2 -20*t_2^3 -30*t_2^4 -42*t_2^5         0 0 0 0 0 0 0 0       %% II trajectory final acceleration = III trajectory initial acceleration
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 0 2 6*t_3 12*t_3^2 20*t_3^3 30*t_3^4 42*t_3^5         0 0 -2 -6*t_3 -12*t_3^2 -20*t_3^3 -30*t_3^4 -42*t_3^5       %% III trajectory final acceleration = IV trajectory initial acceleration

0 0 0 6 24*t_1 60*t_1^2 120*t_1^3 210*t_1^4         0 0 0 -6 -24*t_1 -60*t_1^2 -120*t_1^3 -210*t_1^4        0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0       %% I trajectory final jerk = II trajectory initial jerk
0 0 0 0 0 0 0 0         0 0 0 6 24*t_2 60*t_2^2 120*t_2^3 210*t_2^4         0 0 0 -6 -24*t_2 -60*t_2^2 -120*t_2^3 -210*t_2^4         0 0 0 0 0 0 0 0       %% II trajectory final jerk = III trajectory initial jerk
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 0 0 6 24*t_3 60*t_3^2 120*t_3^3 210*t_3^4         0 0 0 -6 -24*t_3 -60*t_3^2 -120*t_3^3 -210*t_3^4       %% III trajectory final jerk = IV trajectory initial jerk

0 0 0 0 24 120*t_1 360*t_1^2 840*t_1^3         0 0 0 0 -24 -120*t_1 -360*t_1^2 -840*t_1^3        0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0       %% I trajectory final snap = II trajectory initial snap
0 0 0 0 0 0 0 0         0 0 0 0 24 120*t_2 360*t_2^2 840*t_2^3         0 0 0 0 -24 -120*t_2 -360*t_2^2 -840*t_2^3         0 0 0 0 0 0 0 0       %% II trajectory final snap = III trajectory initial snap
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 0 0 0 24 120*t_3 360*t_3^2 840*t_3^3         0 0 0 0 -24 -120*t_3 -360*t_3^2 -840*t_3^3       %% III trajectory final snap = IV trajectory initial snap

0 0 0 0 0 120 720*t_1 2520*t_1^2         0 0 0 0 0 -120 -720*t_1 -2520*t_1^2        0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0       %% I trajectory final crackle = II trajectory initial crackle
0 0 0 0 0 0 0 0         0 0 0 0 0 120 720*t_2 2520*t_2^2         0 0 0 0 0 -120 -720*t_2 -2520*t_2^2         0 0 0 0 0 0 0 0       %% II trajectory final crackle = III trajectory initial crackle
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 0 0 0 0 120 720*t_3 2520*t_3^2         0 0 0 0 0 -120 -720*t_3 -2520*t_3^2       %% III trajectory final crackle = IV trajectory initial crackle

0 0 0 0 0 0 720 5040*t_1         0 0 0 0 0 0 -720 -5040*t_1        0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0       %% I trajectory final pop = II trajectory initial pop
0 0 0 0 0 0 0 0         0 0 0 0 0 0 720 5040*t_2         0 0 0 0 0 0 -720 -5040*t_2         0 0 0 0 0 0 0 0       %% II trajectory final pop = III trajectory initial pop
0 0 0 0 0 0 0 0         0 0 0 0 0 0 0 0        0 0 0 0 0 0 720 5040*t_3         0 0 0 0 0 0 -720 -5040*t_3       %% III trajectory final pop = IV trajectory initial pop

] ;

B = [
p_0 ; p_1 ; p_2 ; p_3 ; p_1 ; p_2 ; p_3 ; p_4 ;
0 ; 0 ; 0 ; 0 ; 0 ; 0 ;
0 ; 0 ; 0 ;
0 ; 0 ; 0 ; 
0 ; 0 ; 0 ;
0 ; 0 ; 0 ;
0 ; 0 ; 0 ;
0 ; 0 ; 0 ;
] ;

constants(:,i)       =   inv(A) * B  ; 

end
end