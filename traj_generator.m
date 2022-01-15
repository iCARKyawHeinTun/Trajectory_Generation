% function [ desired_state ] = traj_generator(t, state, waypoints,constants)





% TRAJ_GENERATOR: Generate the trajectory passing through all
% positions listed in the waypoints list
%
% NOTE: This function would be called with variable number of input arguments.
% During initialization, it will be called with arguments
% trajectory_generator([], [], waypoints) and later, while testing, it will be
% called with only t and state as arguments, so your code should be able to
% handle that. This can be done by checking the number of arguments to the
% function using the "nargin" variable, check the MATLAB documentation for more
% information.
%
% t,state: time and current state (same variable as "state" in controller)
% that you may use for computing desired_state
%
% waypoints: The 3xP matrix listing all the points you much visited in order
% along the generated trajectory
%
% desired_state: Contains all the information that is passed to the
% controller for generating inputs for the quadrotor
%
% It is suggested to use "persistent" variables to store the waypoints during
% the initialization call of trajectory_generator.


%% Example code:
% Note that this is an example of naive trajectory generator that simply moves
% the quadrotor along a stright line between each pair of consecutive waypoints
% using a constant velocity of 0.5 m/s. Note that this is only a sample, and you
% should write your own trajectory generator for the submission.

% persistent waypoints0 traj_time d0
% if nargin > 2
%     d = waypoints(:,2:end) - waypoints(:,1:end-1);
%     d0 = 2 * sqrt(d(1,:).^2 + d(2,:).^2 + d(3,:).^2);
%     traj_time = [0, cumsum(d0)];
%     waypoints0 = waypoints;
% else
%     if(t > traj_time(end))
%         t = traj_time(end);
%     end
%     t_index = find(traj_time >= t,1);
%     
%     disp(t_index) ; 
%     
%    disp('first one')
%    fprintf('%i',t_index) ;
%    
% %     fprintf('% i\n',traj_time)
% 
%     if(t_index > 1)
%         t = t - traj_time(t_index-1);
%     end
%     fprintf(' %i \n',t) ; 
%     if(t == 0)
%         desired_state.pos = waypoints0(:,1);
%     else
%         scale = t/d0(t_index-1) ;
%         desired_state.pos = (1 - scale) * waypoints0(:,t_index-1) + scale * waypoints0(:,t_index) ;
%     end
%     desired_state.vel = zeros(3,1);
%     desired_state.acc = zeros(3,1);
%     desired_state.yaw = 0;
%     desired_state.yawdot = 0;
% end



% Fill in your code here




% persistent waypoints0 traj_time d0 constants0 
% persistent prv_t flag 
% 
% 
% if nargin > 2
%     d = waypoints(:,2:end) - waypoints(:,1:end-1);
%     d0 = 2 * sqrt(d(1,:).^2 + d(2,:).^2 + d(3,:).^2);
%     traj_time = [0, cumsum(d0)];
%     waypoints0 = waypoints;
%     constants0 = constants ;
% else
%     if(t > traj_time(end))
%         t = traj_time(end);
%     end
%     t_index = find(traj_time >= t,1);
%     
%     if(t_index > 1)
%         t = t - traj_time(t_index-1);
%     end
%     if (t == 0)
% %         disp('Just zero') 
%         desired_state.pos = waypoints0(:,1);
%         desired_state.vel = zeros(3,1) ;
%         desired_state.acc = zeros(3,1) ;
%     end
%     
% %     scale = 1 / 3.4 ; 
%     scale = 1 / 3.4 ; 
%     
%     if  ( t_index == 2 )
%             t = t / 3.464 ;
%         pos_1 = constants0(1,1) + constants0(2,1) * t + constants0(3,1) * t^2 + constants0(4,1) * t^3 + constants0(5,1) * t^4 + constants0(6,1) * t^5 + constants0(7,1) * t^6 + constants0(8,1) * t^7 ;
%         pos_2 = constants0(1,2) + constants0(2,2) * t + constants0(3,2) * t^2 + constants0(4,2) * t^3 + constants0(5,2) * t^4 + constants0(6,2) * t^5 + constants0(7,2) * t^6 + constants0(8,2) * t^7 ;
%         pos_3 = constants0(1,3) + constants0(2,3) * t + constants0(3,3) * t^2 + constants0(4,3) * t^3 + constants0(5,3) * t^4 + constants0(6,3) * t^5 + constants0(7,3) * t^6 + constants0(8,3) * t^7 ;
%         desired_state.pos = [ pos_1 ; pos_2 ; pos_3 ]  ;
%         fprintf('%f ', pos_1) ;
%         fprintf('%f ', pos_2) ;
%         fprintf('%f \n', pos_3 ) ;
%         
%         if ( pos_1 == 0.0 && pos_2 == 0.0 && pos_3 == 0.0 )
%             disp ('first point okie')
%         end
%         
%         vel_1 = constants0(2,1) + 2 * constants0(3,1) * t + 3 * constants0(4,1) * t^2 + 4 * constants0(5,1) * t^3 + 5 * constants0(6,1) * t^4 + 6 * constants0(7,1) * t^5 + 7 * constants0(8,1) * t^6 ;
%         vel_2 = constants0(2,2) + 2 * constants0(3,2) * t + 3 * constants0(4,2) * t^2 + 4 * constants0(5,2) * t^3 + 5 * constants0(6,2) * t^4 + 6 * constants0(7,2) * t^5 + 7 * constants0(8,2) * t^6 ;
%         vel_3 = constants0(2,3) + 2 * constants0(3,3) * t + 3 * constants0(4,3) * t^2 + 4 * constants0(5,3) * t^3 + 5 * constants0(6,3) * t^4 + 6 * constants0(7,3) * t^5 + 7 * constants0(8,3) * t^6 ;
%         desired_state.vel =  scale * [ vel_1 ; vel_2 ; vel_3 ] ;
% 
%         acc_1 = 2 * constants0(3,1) + 6 * constants0(4,1) * t + 12 * constants0(5,1) * t^2 + 20 * constants0(6,1) * t^3 + 30 * constants0(7,1) * t^4 + 42 * constants0(8,1) * t^5 ;
%         acc_2 = 2 * constants0(3,2) + 6 * constants0(4,2) * t + 12 * constants0(5,2) * t^2 + 20 * constants0(6,2) * t^3 + 30 * constants0(7,2) * t^4 + 42 * constants0(8,2) * t^5 ;
%         acc_3 = 2 * constants0(3,3) + 6 * constants0(4,3) * t + 12 * constants0(5,3) * t^2 + 20 * constants0(6,3) * t^3 + 30 * constants0(7,3) * t^4 + 42 * constants0(8,3) * t^5 ;
%         desired_state.acc = [ acc_1 ; acc_2 ; acc_3 ] ;
%     end
%     
%     if  ( t_index == 3 )
%         t = 1 + ( t / 3.464 ) ;
%         pos_1 = constants0(9,1) + constants0(10,1) * t + constants0(11,1) * t^2 + constants0(12,1) * t^3 + constants0(13,1) * t^4 + constants0(14,1) * t^5 + constants0(15,1) * t^6 + constants0(16,1) * t^7 ;
%         pos_2 = constants0(9,2) + constants0(10,2) * t + constants0(11,2) * t^2 + constants0(12,2) * t^3 + constants0(13,2) * t^4 + constants0(14,2) * t^5 + constants0(15,2) * t^6 + constants0(16,2) * t^7 ;
%         pos_3 = constants0(9,3) + constants0(10,3) * t + constants0(11,3) * t^2 + constants0(12,3) * t^3 + constants0(13,3) * t^4 + constants0(14,3) * t^5 + constants0(15,3) * t^6 + constants0(16,3) * t^7 ;
%         desired_state.pos = [ pos_1 ; pos_2 ; pos_3 ]  ;
%         
%         if ( pos_1 == 1 && pos_2 == 1 && pos_3 == 1 )
%             disp ('second point okie')
%         end        
%         
%         vel_1 = constants0(10,1) + 2 * constants0(11,1) * t + 3 * constants0(12,1) * t^2 + 4 * constants0(13,1) * t^3 + 5 * constants0(14,1) * t^4 + 6 * constants0(15,1) * t^5 + 7 * constants0(16,1) * t^6 ;
%         vel_2 = constants0(10,2) + 2 * constants0(11,2) * t + 3 * constants0(12,2) * t^2 + 4 * constants0(13,2) * t^3 + 5 * constants0(14,2) * t^4 + 6 * constants0(15,2) * t^5 + 7 * constants0(16,2) * t^6 ;
%         vel_3 = constants0(10,3) + 2 * constants0(11,3) * t + 3 * constants0(12,3) * t^2 + 4 * constants0(13,3) * t^3 + 5 * constants0(14,3) * t^4 + 6 * constants0(15,3) * t^5 + 7 * constants0(16,3) * t^6 ;
%         desired_state.vel = scale * [ vel_1 ; vel_2 ; vel_3 ] ;
% 
%         acc_1 = 2 * constants0(11,1) + 6 * constants0(12,1) * t + 12 * constants0(13,1) * t^2 + 20 * constants0(14,1) * t^3 + 30 * constants0(15,1) * t^4 + 42 * constants0(16,1) * t^5 ;
%         acc_2 = 2 * constants0(11,2) + 6 * constants0(12,2) * t + 12 * constants0(13,2) * t^2 + 20 * constants0(14,2) * t^3 + 30 * constants0(15,2) * t^4 + 42 * constants0(16,2) * t^5 ;
%         acc_3 = 2 * constants0(11,3) + 6 * constants0(12,3) * t + 12 * constants0(13,3) * t^2 + 20 * constants0(14,3) * t^3 + 30 * constants0(15,3) * t^4 + 42 * constants0(16,3) * t^5 ;
%         desired_state.acc = [ acc_1 , acc_2 , acc_3 ] ; 
%     end
%     
%     if ( t_index == 4 )
%         t = 2 + ( t / 3.464 ) ;
%         pos_1 = constants0(17,1) + constants0(18,1) * t + constants0(19,1) * t^2 + constants0(20,1) * t^3 + constants0(21,1) * t^4 + constants0(22,1) * t^5 + constants0(23,1) * t^6 + constants0(24,1) * t^7 ;
%         pos_2 = constants0(17,2) + constants0(18,2) * t + constants0(19,2) * t^2 + constants0(20,2) * t^3 + constants0(21,2) * t^4 + constants0(22,2) * t^5 + constants0(23,2) * t^6 + constants0(24,2) * t^7 ;
%         pos_3 = constants0(17,3) + constants0(18,3) * t + constants0(19,3) * t^2 + constants0(20,3) * t^3 + constants0(21,3) * t^4 + constants0(22,3) * t^5 + constants0(23,3) * t^6 + constants0(24,3) * t^7 ; 
%         desired_state.pos = [ pos_1 ; pos_2 ; pos_3 ]  ;
%         
%         if ( pos_1 == 2 && pos_2 == 0 && pos_3 == 2 )
%             disp ('third point okie')
%         end        
%         
%         vel_1 = constants0(18,1) + 2 * constants0(19,1) * t + 3 * constants0(20,1) * t^2 + 4 * constants0(21,1) * t^3 + 5 * constants0(22,1) * t^4 + 6 * constants0(23,1) * t^5 + 7 * constants0(24,1) * t^6 ;
%         vel_2 = constants0(18,2) + 2 * constants0(19,2) * t + 3 * constants0(20,2) * t^2 + 4 * constants0(21,2) * t^3 + 5 * constants0(22,2) * t^4 + 6 * constants0(23,2) * t^5 + 7 * constants0(24,2) * t^6 ;
%         vel_3 = constants0(18,3) + 2 * constants0(19,3) * t + 3 * constants0(20,3) * t^2 + 4 * constants0(21,3) * t^3 + 5 * constants0(22,3) * t^4 + 6 * constants0(23,3) * t^5 + 7 * constants0(24,3) * t^6 ;
%         desired_state.vel =  scale * [ vel_1 ; vel_2 ; vel_3 ] ;
% 
%         acc_1 = 2 * constants0(19,1) + 6 * constants0(20,1) * t + 12 * constants0(21,1) * t^2 + 20 * constants0(22,1) * t^3 + 30 * constants0(23,1) * t^4 + 42 * constants0(24,1) * t^5 ;
%         acc_2 = 2 * constants0(19,2) + 6 * constants0(20,2) * t + 12 * constants0(21,2) * t^2 + 20 * constants0(22,2) * t^3 + 30 * constants0(23,2) * t^4 + 42 * constants0(24,2) * t^5 ;
%         acc_3 = 2 * constants0(19,3) + 6 * constants0(20,3) * t + 12 * constants0(21,3) * t^2 + 20 * constants0(22,3) * t^3 + 30 * constants0(23,3) * t^4 + 42 * constants0(24,3) * t^5 ;
%         desired_state.acc = [ acc_1 , acc_2 , acc_3 ] ; 
%     end
%     
%     if  ( t_index == 5 )
%         t = 3 + ( t / 3.464 ) ;
%         pos_1 = constants0(25,1) + constants0(26,1) * t + constants0(27,1) * t^2 + constants0(28,1) * t^3 + constants0(29,1) * t^4 + constants0(30,1) * t^5 + constants0(31,1) * t^6 + constants0(32,1) * t^7 ;
%         pos_2 = constants0(25,2) + constants0(26,2) * t + constants0(27,2) * t^2 + constants0(28,2) * t^3 + constants0(29,2) * t^4 + constants0(30,2) * t^5 + constants0(31,2) * t^6 + constants0(32,2) * t^7 ;
%         pos_3 = constants0(25,3) + constants0(26,3) * t + constants0(27,3) * t^2 + constants0(28,3) * t^3 + constants0(29,3) * t^4 + constants0(30,3) * t^5 + constants0(31,3) * t^6 + constants0(32,3) * t^7 ;
%         desired_state.pos = [ pos_1 ; pos_2 ; pos_3 ]  ;
%         
%         if ( pos_1 == 3 && pos_2 == -1 && pos_3 == 1 )
%             disp ('fourth point okie')
%         end        
%         
%         vel_1 = constants0(26,1) + 2 * constants0(27,1) * t + 3 * constants0(28,1) * t^2 + 4 * constants0(29,1) * t^3 + 5 * constants0(30,1) * t^4 + 6 * constants0(31,1) * t^5 + 7 * constants0(32,1) * t^6 ;
%         vel_2 = constants0(26,2) + 2 * constants0(27,2) * t + 3 * constants0(28,2) * t^2 + 4 * constants0(29,2) * t^3 + 5 * constants0(30,2) * t^4 + 6 * constants0(31,2) * t^5 + 7 * constants0(32,2) * t^6 ;
%         vel_3 = constants0(26,3) + 2 * constants0(27,3) * t + 3 * constants0(28,3) * t^2 + 4 * constants0(29,3) * t^3 + 5 * constants0(30,3) * t^4 + 6 * constants0(31,3) * t^5 + 7 * constants0(32,3) * t^6 ;
%         desired_state.vel =  scale * [ vel_1 ; vel_2 ; vel_3 ] ;
% 
%         acc_1 = 2 * constants0(27,1) + 6 * constants0(28,1) * t + 12 * constants0(29,1) * t^2 + 20 * constants0(30,1) * t^3 + 30 * constants0(31,1) * t^4 + 42 * constants0(32,1) * t^5 ;
%         acc_2 = 2 * constants0(27,2) + 6 * constants0(28,2) * t + 12 * constants0(29,2) * t^2 + 20 * constants0(30,2) * t^3 + 30 * constants0(31,2) * t^4 + 42 * constants0(32,2) * t^5 ;
%         acc_3 = 2 * constants0(27,3) + 6 * constants0(28,3) * t + 12 * constants0(29,3) * t^2 + 20 * constants0(30,3) * t^3 + 30 * constants0(31,3) * t^4 + 42 * constants0(32,3) * t^5 ;
%         desired_state.acc = [ acc_1 , acc_2 , acc_3 ] ; 
%     end
%     
%     if ( desired_state.pos(1) == 4 && desired_state.pos(2) == 0 && desired_state.pos(3) == 0 && t_index == 5  )
%         desired_state.pos    =   waypoints0(:,5) ;
%         
%         
%         if ( pos_1 == 4 && pos_2 == 0 && pos_3 == 0 )
%             disp ('fifth point okie')
%         end        
%         
%         
%         desired_state.vel    =   zeros(3,1) ;
%         desired_state.acc    =   zeros(3,1) ;
%     end
% % 
% % desired_state.acc    =   zeros(3,1) ;
% desired_state.yaw = 0;
% desired_state.yawdot = 0;
%     
% end
% 
% 
% 
% end




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



function [ desired_state ] = traj_generator(t, state, waypoints)

persistent d d0 traj_time t_max waypoints0 w_x w_y w_z

persistent coffx coffy coffz

if nargin > 2

desired_state.vel = zeros(3,1);

desired_state.acc = zeros(3,1);

desired_state.yaw = 0;

desired_state.yawdot = 0;

d = waypoints(:,2:end) - waypoints(:,1:end-1); %Matrix 3x4, distances between points

d0 = 2 * sqrt(d(1,:).^2 + d(2,:).^2 + d(3,:).^2); %Matrix 1x4 segment times

traj_time = [0, cumsum(d0)]; %Matrix 1x5 final times at the points

waypoints0 = waypoints;

w_x = waypoints0(1,:); %Matrix 1x5 points in x direction

w_y = waypoints0(2,:); %Matrix 1x5 points in y direction

w_z = waypoints0(3,:); %Matrix 1x5 points in z direction

coffx = getCoff(w_x); %32x1

coffy = getCoff(w_y); %32x1

coffz = getCoff(w_z); %32x1

else

t_max = traj_time(end);

if(t >= t_max)

t = t_max - 0.0001;

end

t_index = find(traj_time >t,1)-1; %indeks of a segment

t_index = max(t_index,1);

scale = (t-traj_time(t_index)) / d0(t_index);

if(t == 0)

desired_state.pos = waypoints0(:,1);

desired_state.vel = zeros(3,1);

desired_state.acc = zeros(3,1);

desired_state.yaw = 0;

desired_state.yawdot = 0;

else

t0 = polyT(8,0,scale)';

t1 = polyT(8,1,scale)';

t2 = polyT(8,2,scale)';

index = (t_index-1)*8+1:t_index*8;

desired_state.pos = [coffx(index)'*t0 ;coffy(index)'*t0 ;coffz(index)'*t0];

desired_state.vel = [coffx(index)'*t1*(1/d0(t_index)) ;coffy(index)'*t1*(1/d0(t_index)) ;coffz(index)'*t1*(1/d0(t_index))];

desired_state.acc = [coffx(index)'*t2*(1/d0(t_index)^2) ;coffy(index)'*t2*(1/d0(t_index)^2) ;coffz(index)'*t2*(1/d0(t_index)^2)];

desired_state.yaw = 0;

desired_state.yawdot = 0;

end

end

function [coff, A, b] = getCoff(points)

n = 4;%size(points,1)-1; % number of segments P1..n

A = zeros(8*n, 8*n);

b = zeros(1,8*n);

row = 1;

%row 1 P1(0) = W1

A(row,1:8) = polyT(8,0,0);

b(1,row) = points(1,1);

row = row+1;

%row 2 P2(0) = W2

A(row,9:16) = polyT(8,0,0);

b(1,row) = points(1,2);

row = row+1;

%row 3 P3(0) = W3

A(row,17:24) = polyT(8,0,0);

b(1,row) = points(1,3);

row = row+1;

%row 4 P4(0) = W4

A(row,25:32) = polyT(8,0,0);

b(1,row) = points(1,4);

row = row+1;

%row 5 P1(T) = W2

A(row,1:8) = polyT(8,0,1);

b(1,row) = points(1,2);

row = row+1;

%row 6 P2(T) = W3

A(row,9:16) = polyT(8,0,1);

b(1,row) = points(1,3);

row = row+1;

%row 7 P3(T) = W4

A(row,17:24) = polyT(8,0,1);

b(1,row) = points(1,4);

row = row+1;

%row8 P4(T) = W5

A(row,25:32) = polyT(8,0,1);

b(1,row) = points(1,5);

row = row+1;

%row 9 P1_dot(0) = 0

A(row, 1:8) = polyT(8,1,0);

row = row+1;

%row 10 P1_ddot(0) = 0

A(row,1:8) = polyT(8,2,0);

row = row+1;

%row 11 P1_dddot(0) = 0

A(row,1:8) = polyT(8,3,0);

row = row+1;

%row 12 P4_dot(T) = 0

A(row,25:32) = polyT(8,1,1);

row = row+1;

%row 13 P4_ddot(T) = 0

A(row,25:32) = polyT(8,2,1);

row = row+1;

%row 14 P4_dddot(T) = 0

A(row,25:32) = polyT(8,3,1);

row = row+1;

%row 15 P1_dot(T) - P2_dot(0) = 0

A(row,1:16) = [polyT(8,1,1), -polyT(8,1,0)];

row = row+1;

%row 16 P2_dot(T) - P3_dot(0) = 0

A(row,9:24) = [polyT(8,1,1), - polyT(8,1,0)];

row = row +1;

%row 17 P3_dot(T) - P4_dot(0) = 0

A(row,17:32) = [polyT(8,1,1), - polyT(8,1,0)];

row = row+1;

%row 18 P1_ddot(T) - P2_ddot(0) = 0

A(row,1:16) = [polyT(8,2,1), - polyT(8,2,0)];

row = row+1;

%row 19 P2_ddot(T) - P3_ddot(0) = 0

A(row,9:24) = [polyT(8,2,1), - polyT(8,2,0)];

row = row +1;

%row 20 P3_ddot(T) - P4_ddot(0) = 0

A(row,17:32) = [polyT(8,2,1), - polyT(8,2,0)];

row = row+1;

%row 21 P1_dot3(T) - P2_dot3(0) = 0

A(row,1:16) = [polyT(8,3,1), - polyT(8,3,0)];

row = row+1;

%row 22 P2_dot3(T) - P3_dot3(0) = 0

A(row,9:24) = [polyT(8,3,1), - polyT(8,3,0)];

row = row +1;

%row 23 P3_dot3(T) - P4_dot3(0) = 0

A(row,17:32) = [polyT(8,3,1), - polyT(8,3,0)];

row = row+1;

%row 24 P1_dot4(T) - P2_dot4(0) = 0

A(row,1:16) = [polyT(8,4,1), - polyT(8,4,0)];

row = row+1;

%row 25 P2_dot4(T) - P3_dot4(0) = 0

A(row,9:24) = [polyT(8,4,1), - polyT(8,4,0)];

row = row +1;

%row 26 P3_dot4(T) - P4_dot3(0) = 0

A(row,17:32) = [polyT(8,4,1), - polyT(8,4,0)];

row = row+1;

%row 27 P1_dot5(T) - P2_dot5(0) = 0

A(row,1:16) = [polyT(8,5,1), - polyT(8,5,0)];

row = row+1;

%row 28 P2_dot5(T) - P3_dot5(0) = 0

A(row,9:24) = [polyT(8,5,1), - polyT(8,5,0)];

row = row +1;

%row 29 P3_dot5(T) - P4_dot5(0) = 0

A(row,17:32) = [polyT(8,5,1), - polyT(8,5,0)];

row = row+1;

%row 30 P1_dot6(T) - P2_dot6(0) = 0

A(row,1:16) = [polyT(8,6,1), - polyT(8,6,0)];

row = row+1;

%row 31 P2_dot6(T) - P3_dot6(0) = 0

A(row,9:24) = [polyT(8,6,1), - polyT(8,6,0)];

row = row +1;

%row 32 P3_dot6(T) - P4_dot6(0) = 0

A(row,17:32) = [polyT(8,6,1), - polyT(8,6,0)];

%deter = det(A);

A_inv = A^(-1);

coff = A_inv*b';

end %getCoff function

end %end of gen_traj
