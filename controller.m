function [F, M] = controller(t, state, des_state, params)
%CONTROLLER  Controller for the quadrotor
%
%   state: The current state of the robot with the following fields:
%   state.pos = [x; y; z], state.vel = [x_dot; y_dot; z_dot],
%   state.rot = [phi; theta; psi], state.omega = [p; q; r]
%
%   des_state: The desired states are:
%   des_state.pos = [x; y; z], des_state.vel = [x_dot; y_dot; z_dot],
%   des_state.acc = [x_ddot; y_ddot; z_ddot], des_state.yaw,
%   des_state.yawdot
%
%   params: robot parameters

%   Using these current and desired states, you have to compute the desired
%   controls


% =================== Your code goes here ===================

% Thrust

% kd_one      =   300;   kp_one      =   80;
% kd_two      =   300;   kp_two      =   150;
% kd_three    =   400;   kp_three    =   100;

kd_one      =   400;   kp_one      =   100;
kd_two      =   400;   kp_two      =   150;
kd_three    =   500;   kp_three    =   150;

r_ddot_one_des      =   des_state.acc(1) + kd_one * (des_state.vel(1) - state.vel(1)) + kp_one * (des_state.pos(1) - state.pos(1));
r_ddot_two_des      =   des_state.acc(2) + kd_two * (des_state.vel(2) - state.vel(2)) + kp_two * (des_state.pos(2) - state.pos(2));
r_ddot_three_des    =   des_state.acc(3) + kd_three * (des_state.vel(3) - state.vel(3)) + kp_three * (des_state.pos(3) - state.pos(3));

fai_des     =   ( r_ddot_one_des * sin (des_state.yaw) - r_ddot_two_des * cos (des_state.yaw) ) / params.gravity ; 
theta_des   =   ( r_ddot_one_des * cos (des_state.yaw) + r_ddot_two_des * sin (des_state.yaw) ) / params.gravity ; 
xi_des      =   des_state.yaw ;

F           =   params.mass * params.gravity + params.mass * r_ddot_three_des ;


% Moment

p_des = 0 ;
q_des = 0 ;
r_des = des_state.yawdot ;

% kp_fai      =   850;   kd_fai      =   800;
% kp_theta    =   850;   kd_theta    =   800;
% kp_xi       =   850;   kd_xi       =   800;

kp_fai      =   950;   kd_fai      =   800;
kp_theta    =   950;   kd_theta    =   800;
kp_xi       =   950;   kd_xi       =   800;

u_two       =   zeros(3,1) ;

u_two(1)    =   kp_fai * (fai_des - state.rot(1)) + kd_fai * (p_des - state.omega(1)) ;
u_two(2)    =   kp_theta * (theta_des - state.rot(2)) + kd_theta * (q_des - state.omega(2)) ;
u_two(3)    =   kp_xi * (xi_des - state.rot(3)) + kd_xi * (r_des - state.omega(3)) ;

M           =   zeros(3,1);
M           =   params.I * u_two ;



% fprintf('%f', M(1))
% fprintf(' %f',M(2))
% fprintf(' %f\n',M(3))



% =================== Your code ends here ===================

end
