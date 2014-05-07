--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

COMMAND = Clockwork.command:New();
COMMAND.tip = "Add a trash spawn at your target position.";
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 32);
	
	Schema.trashSpawns[#Schema.trashSpawns + 1] = position;
	Schema:SaveTrashSpawns();
	
	Clockwork.player:Notify(player, "You have added a trash spawn.");
end;

Clockwork.command:Register(COMMAND, "TrashSpawnAdd");