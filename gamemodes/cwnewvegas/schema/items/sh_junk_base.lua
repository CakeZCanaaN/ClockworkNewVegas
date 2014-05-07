--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Junk Base";
	ITEM.worth = 1;
	ITEM.model = "models/props_junk/garbage_plasticbottle001a.mdl";
	ITEM.color = Color(225, 255, 25, 255);
	ITEM.weight = 0.1;
	ITEM.useText = "Caps";
	ITEM.useSound = {"buttons/button5.wav", "buttons/button4.wav"};
	ITEM.category = "Junk";
	ITEM.isBaseItem = true;
	ITEM.description = "A bottle with a white liquid inside.";

	-- Check if a statement is true.
	if (CLIENT) then
		ITEM.outlineMaterial = Material("white_outline");
	end;

	-- Called when the item's model is drawn.
	function ITEM:OnDrawModel(itemEntity)
		local curTime = CurTime();
		local sineWave = math.max(math.abs(math.sin(curTime) * 32), 16);
		local itemColor = itemEntity:GetColor();
		
		cam.Start3D( EyePos(), EyeAngles() );
			render.SuppressEngineLighting(true);
				render.SetColorModulation(self.color.r / 255, self.color.b / 255, self.color.g / 255);
					render.SetAmbientLight(1, 1, 1);
						itemEntity:SetModelScale(1.025 + (sineWave / 320), 0);
							render.MaterialOverride(self.outlineMaterial);
						itemEntity:DrawModel();
						
						itemEntity:SetModelScale(1, 0);
					render.MaterialOverride(nil);
				render.SetColorModulation(itemColor.r / 255, itemColor.g / 255, itemColor.b / 255);
			render.SuppressEngineLighting(false);
		cam.End3D();
	end;

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		Clockwork.player:GiveCash(player, self.worth, "scrapped some junk");
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
Clockwork.item:Register(ITEM);