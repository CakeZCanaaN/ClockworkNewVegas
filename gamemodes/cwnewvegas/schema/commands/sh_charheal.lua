--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

COMMAND = Clockwork.command:New();
COMMAND.tip = "Heal a character if you own a medical item.";
COMMAND.text = "<string Item>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local itemTable = Clockwork.item:Get( arguments[1] );
	local entity = player:GetEyeTraceNoCursor().Entity;
	local healed;
	
	local target = Clockwork.entity:GetPlayer(entity);
	
	if (target) then
		if (entity:GetPos():Distance( player:GetShootPos() ) <= 192) then
			if (itemTable and arguments[1] == "stimpack") then
				if ( player:HasItem("stimpack") ) then
					target:SetHealth( math.Clamp( target:Health() + Schema:GetHealAmount(player, 3), 0, target:GetMaxHealth() ) );
					target:EmitSound("items/medshot4.wav");
					
					player:TakeItem(itemTable, true);
					
					healed = true;
				else
					Clockwork.player:Notify(player, "You do not own a health vial!");
				end;
			elseif (itemTable and arguments[1] == "antibiotics") then
				if ( player:HasItem("antibiotics") ) then
					target:SetHealth( math.Clamp( target:Health() + Schema:GetHealAmount(player, 1.5), 0, target:GetMaxHealth() ) );
					target:EmitSound("items/medshot4.wav");
					
					player:TakeItem(itemTable, true);
					
					healed = true;
				else
					Clockwork.player:Notify(player, "You do not own a health vial!");
				end;
			elseif (itemTable and arguments[1] == "bandage") then
				if ( player:HasItem("bandage") ) then
					target:SetHealth( math.Clamp( target:Health() + Schema:GetHealAmount(player), 0, target:GetMaxHealth() ) );
					target:EmitSound("items/medshot4.wav");
					
					player:TakeItem(itemTable, true);
					
					healed = true;
				else
					Clockwork.player:Notify(player, "You do not own a bandage!");
				end;
			else
				Clockwork.player:Notify(player, "This is not a valid item!");
			end;
			
			if (healed) then
				Clockwork.plugin:Call("PlayerHealed", target, player, itemTable);
				
				if (Clockwork.player:GetAction(target) == "die") then
					Clockwork.player:SetRagdollState(target, RAGDOLL_NONE);
				end;
				
				player:FakePickup(target);
			end;
		else
			Clockwork.player:Notify(player, "This character is too far away!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a character!");
	end;
end;

Clockwork.command:Register(COMMAND, "CharHeal");