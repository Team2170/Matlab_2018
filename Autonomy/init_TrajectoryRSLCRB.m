
RSLCRB.x = [Field.RSLC.x, Field.RSwitch.RightP.br_x + 1.5, Field.RSwitch.RightP.br_x + 1.5, (Field.RSwitch.LeftP.tl_x + Field.RSwitch.LeftP.tr_x)/2 + RSLCRB.add_x, (Field.RSwitch.LeftP.tl_x + Field.RSwitch.LeftP.tr_x)/2 + RSLCRB.add_x ];
RSLCRB.y = [Field.RSLC.y, Field.RSLC.y, Field.RSRC.y,  Field.RSRC.y,  Field.RSwitch.RightP.br_y + RSRCLB.add_y - Robot.L/2];
RSLCRB.v = 2.0;
%RSLCRB.t_final = traj_length(RSLCRB) / RSLCRB.v  * 1.3;
RSLCRB.t_final = 9.5;
RSLCRB.name = 'RSLCRB';