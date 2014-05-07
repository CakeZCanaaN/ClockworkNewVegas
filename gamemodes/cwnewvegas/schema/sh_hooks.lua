--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

-- Called when the Clockwork shared variables are added.
function Clockwork.kernel:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:String("customClass");
	playerVars:Number("clothes", true);
end;