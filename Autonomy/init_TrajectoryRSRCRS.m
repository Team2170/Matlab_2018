

RSRCRS.x = [Field.RSRC.x, (Field.RSwitch.RightP.tr_x + Field.RSwitch.RightP.tl_x)/2 + RSRCRS.add_x, (Field.RSwitch.RightP.tr_x + Field.RSwitch.RightP.tl_x)/2 + RSRCRS.add_x];
RSRCRS.y = [Field.RSRC.y, Field.RSRC.y, Field.RSwitch.RightP.br_y-Robot.L/2 + RSRCRS.add_y];
RSRCRS.v = 2.0;
%RSRCRS.t_final = traj_length(RSRCRS) / RSRCRS.v  * 1.3;
RSRCRS.t_final = traj_length(RSRCRS) / RSRCRS.v  * 1.3;
RSRCRS.name = 'RSRCLS';