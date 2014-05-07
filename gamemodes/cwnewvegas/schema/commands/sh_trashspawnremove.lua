--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

COMMAND = Clockwork.command:New();
COMMAND.tip = "Remove trash spawns at your target position.";
COMMAND.access = "a";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local position = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 32);
	local trashSpawns = 0;
	
	for k, v in pairs(Schema.trashSpawns) do
		if (v:Distance(position) <= 256) then
			trashSpawns = trashSpawns + 1;
			
			Schema.trashSpawns[k] = nil;
		end;
	end
	
	if (trashSpawns > 0) then
		if (trashSpawns == 1) then
			Clockwork.player:Notify(player, "You have removed "..trashSpawns.." trash spawn.");
		else
			Clockwork.player:Notify(player, "You have removed "..trashSpawns.." trash spawns.");
		end;
	else
		Clockwork.player:Notify(player, "There were no trash spawns near this position.");
	end;
	
	Schema:SaveTrashSpawns();
end;

Clockwork.command:Register(COMMAND, "TrashSpawnRemove");