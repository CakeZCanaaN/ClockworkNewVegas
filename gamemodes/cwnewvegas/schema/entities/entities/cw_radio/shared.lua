--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

ENT.Type = "anim";
ENT.Base = "base_gmodentity";
ENT.Author = "kurozael";
ENT.PrintName = "Radio";
ENT.Spawnable = false;
ENT.AdminSpawnable = false;

-- Called when data for the entity is initialized.
function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Frequency");
	self:NetworkVar("Bool", 0, "Off");
end;