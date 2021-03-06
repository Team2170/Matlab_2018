%   init_Trajectories
%   Version 5
%
%    Adonis Canada, Priyanshu Agrawal, Baris Sengezen
%
%   2018-03-05  Martin Krucinski
%               Added additional starting point Right SR,
%               and additional move distance at end of the move, add_x
%
%   2018-03-07  Martin Krucinski
%               Speed-up of all trajectories & modifications based on
%               2018-03-05 experimental tests on the Team Paragon field
%
%   2018-03-07  Martin Krucinski
%               version 5 simplifies trajectory generation to use only
%               4 points for Switch from the front moves and
%               5 points for Switch from the side moves
%               This enables us to simplify the code a lot and handle
%               calibration adjustments to the end point
%               based on field calibration in a simpler way

%-------------------------------------------------------------------------
%   Straight
Straight.x = [Field.RSR.x, Field.RSR.x+10*ft];
Straight.y = [Field.RSR.y, Field.RSR.y];
%   Martin Krucinski 2018-03-07
%Straight.v = 1;
Straight.v = 1.6;
Straight.t_final = 4;
Straight.name   = 'Straight';

%-------------------------------------------------------------------------
%   Arc
%
%TurnTest.x = [Field.RSR.x];
%TurnTest.y = [Field.RSR.y+5*ft];
Arc = get_Curve(90*deg, -90*deg, 1, 18, 5*ft, 3*ft+Field.RSR.x+12, Field.RSR.y+5*ft);

%   Martin Krucinski 2018-03-07
% Arc.v = 1.0;
% Arc.t_final = 10.0;
Arc.v = 1.6;
Arc.t_final = 6.25;

Arc.x = [12 Arc.x 12];
Arc.y = [Arc.y(1) Arc.y Arc.y(length(Arc.y))];
Arc.name    = 'Arc';

%-------------------------------------------------------------------------

all_traj_color      = 'R';                          % trajectory alliance color
N_traj_color        = length(all_traj_color );
all_start_points    = 'LMR';                        % Left, Middle, Right
N_start_points      = length(all_start_points);
all_switch_loc      = 'LR';                         % Left & Right Switch
N_switch_loc        = length(all_switch_loc);
all_switch_pos      = 'FS';                         % Front and Side Switch position
N_switch_pos        = length(all_switch_pos);

%-------------------------------------------------------------------------
%   Individual end point adjustments based on calibration
%-------------------------------------------------------------------------
%   From SM

RSMLF.add_x   = 6.0*in;            %   additional x-move distance at the end of trajectory
RSMLF.add_y   = 0.0;            %   additional y-move distance

RSMRF.add_x   = 6.0*in;            %   additional x-move distance at the end of trajectory
RSMRF.add_y   = 0.0;            %   additional y-move distance at the end of trajectory

RSMLS.add_x   = 0.0;            %   additional x-move distance at the end of trajectory
RSMLS.add_y   = 0.0;            %   additional y-move distance

RSMRS.add_x   = 0.0;            %   additional x-move distance at the end of trajectory
RSMRS.add_y   = 0.0;            %   additional y-move distance

%-------------------------------------------------------------------------
%   From SL

RSLLF.add_x   = 6.0*in;      %   additional x-move distance at the end of trajectory
RSLLF.add_y   = 0.0;      %   additional y-move distance

RSLRF.add_x   = 6.0*in;      %   additional x-move distance at the end of trajectory
RSLRF.add_y   = 0.0;      %   additional y-move distance

RSLLS.add_x   = 0.0;      %   additional x-move distance at the end of trajectory
RSLLS.add_y   = 0.0;      %   additional y-move distance

RSLRS.add_x   = 0.0;      %   additional x-move distance at the end of trajectory
RSLRS.add_y   = 0.0;      %   additional y-move distance

%-------------------------------------------------------------------------
%   From SR

RSRLF.add_x   = 6.0*in;      %   additional x-move distance at the end of trajectory
RSRLF.add_y   = 0.0;      %   additional y-move distance

RSRRF.add_x   = 6.0*in;      %   additional x-move distance at the end of trajectory
RSRRF.add_y   = 0.0;      %   additional y-move distance, per 03/05/18 Team Paragon testing

RSRLS.add_x   = 0.0;      %   additional x-move distance at the end of trajectory
RSRLS.add_y   = 0.0;      %   additional y-move distance

RSRRS.add_x   = 0.0;      %   additional x-move distance at the end of trajectory
RSRRS.add_y   = 0.0;      %   additional y-move distance

%-------------------------------------------------------------------------
%   Generate all trajectories depending on
%   the color,
%   start point,
%   switch location and
%   switch position flags
%-------------------------------------------------------------------------


for c=1:N_traj_color,
    for s=1:N_start_points,
        for l=1:N_switch_loc,
            for p=1:N_switch_pos,
                
                trajString  = [ all_traj_color(c) 'S' all_start_points(s) ...
                    all_switch_loc(l) all_switch_pos(p) ];
                
                clear traj
                
                traj.name   = trajString;
                traj.add_x  = eval( [ trajString '.add_x'] );
                traj.add_y  = eval( [ trajString '.add_y'] );
                
                Start_string = [ 'Field.' all_traj_color(c) 'S' all_start_points(s)];
                traj.x(1)   = eval([ Start_string '.x']);
                traj.y(1)   = eval([ Start_string '.y']);
                
                traj.x(2)   = traj.x(1) + Robot.L/2;
                traj.y(2)   = traj.y(1);
                
                if all_switch_pos(p) == 'F',    % FRONT switch position
                    traj.x(3)   = traj.x(2) + 3*ft;
                    traj.x(4)   = Field.RSwitch.LVT_x - Robot.L/2 + traj.add_x;
                    if all_switch_loc(l) == 'L',    %   LEFT switch
                        
                        %traj.y(3)   = Field.RSwitch.LVT_y - traj.add_y;
                        
                        % MKrucinski 2018-03-08 Keep sign of add_y in the
                        % POSITIVE direction for ALL the FRONT moves,
                        %   i.e. positive add_y will increase y, i.e. shift
                        %   end position to the LEFT
                        %   this is DIFFERENT from SIDE position where
                        %   positive add_y drives the robot FURTHER into
                        %   the switch
                        traj.y(3)   = Field.RSwitch.LVT_y + traj.add_y;
                        traj.y(4)   = traj.y(3);
                    else % switch_loc == 'R'        %   RIGHT switch
                        traj.y(3)   = Field.RSwitch.RVT_y + traj.add_y;
                        traj.y(4)   = traj.y(3);
                    end
                    % RSMR.x = [Field.RSM.x, Field.RSM.x + Robot.L, Field.RSM.x + Robot.L + 3*ft, Field.RSwitch.LVT_x - Robot.L/2 + RSMR.add_x];
                    % RSMR.y = [Field.RSM.y, Field.RSM.y, Field.RSwitch.RVT_y + RSMR.add_y, Field.RSwitch.RVT_y + RSMR.add_y];
                    
                    traj.v      = 2.0;
                    traj.t_final= ( traj_length(traj) / traj.v ) * 1.3;
                    
                else %switch_pos(p) == 'S'  % SIDE  switch position
                    %                    traj.x(3)   = traj.x(2);
%                   traj.x(3)   = traj.x(2) + 1.0;
% MKrucinski 03/10/18 Make turn 90 deg in order to avoid other robots
                    traj.x(3)   = traj.x(2) + 0.0;
                    traj.x(4)   = (Field.RSwitch.LeftP.tl_x + Field.RSwitch.LeftP.br_x)/2 + traj.add_x;
                    traj.x(5)   = traj.x(4);
                    if all_switch_loc(l) == 'L',    %   LEFT switch
                        traj.y(3)   = Field.RSwitch.LVT_y + 2*Robot.L - traj.add_y;
                        traj.y(4)   = traj.y(3);
                        % RSMLS.y = [Field.RSM.y, Field.RSM.y, 4.04, 5.1723, 6.8, 7.2, 7.2, 6.8, Field.RSwitch.LeftP.tl_y+Robot.L/2 - add_y];
                        traj.y(5)   = Field.RSwitch.LeftP.tl_y + Robot.L/2 - traj.add_y;
                    else % switch_loc == 'R'        %   RIGHT switch
                        traj.y(3)   = Field.RSwitch.RVT_y - 2*Robot.L + traj.add_y;
                        traj.y(4)   = traj.y(3);
                        %traj.y(5)   = RSMRS.y =  1.8 + traj.add_y;
                        traj.y(5)   = Field.RSwitch.RightP.bl_y - Robot.L/2 + traj.add_y;
                    end
                    
                    %(Field.RSwitch.LeftP.tl_x + Field.RSwitch.LeftP.br_x)/2*[1.01 1]+add_x
                    
                    traj.v      = 2.0;
                    traj.t_final= ( traj_length(traj) / traj.v ) * 1.3;
                end
                
                disp([ trajString ' via points initialized...' ] )
                eval([ trajString ' = traj;' ])
                
            end
        end
    end
end

