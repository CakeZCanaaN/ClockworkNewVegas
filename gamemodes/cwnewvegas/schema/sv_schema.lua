--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

Clockwork.kernel:AddFile("materials/models/weapons/temptexture/handsmesh1.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/temptexture/handsmesh1.vmt");
Clockwork.kernel:AddFile("models/weapons/v_sledgehammer/v_sledgehammer.mdl");
Clockwork.kernel:AddFile("materials/models/weapons/v_katana/katana.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/v_katana/katana.vmt");
Clockwork.kernel:AddFile("models/weapons/v_shovel/v_shovel.mdl");
Clockwork.kernel:AddFile("models/weapons/v_axe/v_axe.mdl");
Clockwork.kernel:AddFile("materials/models/weapons/sledge.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/sledge.vmt");
Clockwork.kernel:AddFile("materials/models/weapons/shovel.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/shovel.vmt");
Clockwork.kernel:AddFile("materials/models/weapons/axe.vtf");
Clockwork.kernel:AddFile("materials/models/weapons/axe.vmt");
Clockwork.kernel:AddFile("models/weapons/w_sledgehammer.mdl");
Clockwork.kernel:AddFile("models/quake4pm/quakencr.mdl");
Clockwork.kernel:AddFile("models/weapons/w_remingt.mdl");
Clockwork.kernel:AddFile("models/weapons/v_remingt.mdl");
Clockwork.kernel:AddFile("models/power_armor/slow.mdl");
Clockwork.kernel:AddFile("models/weapons/w_katana.mdl");
Clockwork.kernel:AddFile("models/weapons/v_katana.mdl");
Clockwork.kernel:AddFile("models/weapons/w_shovel.mdl");
Clockwork.kernel:AddFile("models/tactical_rebel.mdl");
Clockwork.kernel:AddFile("resource/fonts/spranq.ttf");
Clockwork.kernel:AddFile("models/weapons/w_axe.mdl");
Clockwork.kernel:AddFile("models/ghoul/slow.mdl");
Clockwork.kernel:AddFile("sound/way_back_home.mp3");

Clockwork.kernel:AddDirectory("materials/models/player/slow/fallout_3/power_armor/");
Clockwork.kernel:AddDirectory("materials/models/humans/female/group03/caesars_sheet.*");
Clockwork.kernel:AddDirectory("materials/models/humans/male/group03/caesars_sheet.*");
Clockwork.kernel:AddDirectory("materials/models/humans/female/group01/apoca*.*");
Clockwork.kernel:AddDirectory("materials/models/player/slow/fallout_3/ghoul/");
Clockwork.kernel:AddDirectory("materials/models/humans/male/group01/apoca*.*");
Clockwork.kernel:AddDirectory("materials/models/gasmask/tac_rbe/");
Clockwork.kernel:AddDirectory("materials/models/player/ncrs/");
Clockwork.kernel:AddDirectory("materials/newvegas/");
Clockwork.kernel:AddDirectory("materials/models/deadbodies/");
Clockwork.kernel:AddDirectory("materials/models/nukacola/");
Clockwork.kernel:AddDirectory("models/deadbodies/");
Clockwork.kernel:AddDirectory("models/nukacola/");

for k, v in pairs( {34, 37, 38, 40, 41, 42, 43, 51} ) do
	local groupName = "group"..v;
	
	Clockwork.kernel:AddDirectory("models/humans/"..groupName.."/*.*");
end;

Clockwork.config:Add("intro_text_small", "What happens in Vegas... stays in Vegas.", true);
Clockwork.config:Add("intro_text_big", "NEW VEGAS, 2280.", true);

Clockwork.config:Get("enable_gravgun_punt"):Set(false);
Clockwork.config:Get("default_inv_weight"):Set(2);
Clockwork.config:Get("enable_crosshair"):Set(false);
Clockwork.config:Get("scale_prop_cost"):Set(0);
Clockwork.config:Get("default_cash"):Set(20);
Clockwork.config:Get("door_cost"):Set(10);

Clockwork.hint:Add("Staff", "The staff are here to help you, please respect them.");
Clockwork.hint:Add("Grammar", "Try to speak correctly in-character, and don't use emoticons.");
Clockwork.hint:Add("Healing", "You can heal players by using the Give command in your inventory.");
Clockwork.hint:Add("Wasteland", "Bored and alone in the wasteland? Travel with a friend.");
Clockwork.hint:Add("Metagaming", "Metagaming is when you use out-of-character information in-character.");
Clockwork.hint:Add("Development", "Develop your character, give them a story to tell.");
Clockwork.hint:Add("Powergaming", "Powergaming is when you force your actions on others.");

Clockwork.datastream:Hook("ObjectPhysDesc", function(player, data)
	if (type(data) == "table" and type( data[1] ) == "string") then
		if ( player.objectPhysDesc == data[2] ) then
			local physDesc = data[1];
			
			if (string.len(physDesc) > 80) then
				physDesc = string.sub(physDesc, 1, 80).."...";
			end;
			
			data[2]:SetNetworkedString("physDesc", physDesc);
		end;
	end;
end);

-- A function to load the radios.
function Schema:LoadRadios()
	local radios = Clockwork.kernel:RestoreSchemaData( "plugins/radios/"..game.GetMap() );
	
	for k, v in pairs(radios) do
		local entity;
		
		if (v.frequency) then
			entity = ents.Create("cw_radio");
		end;
		
		Clockwork.player:GivePropertyOffline(v.key, v.uniqueID, entity);
		
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		
		if ( IsValid(entity) ) then
			entity:SetOff(v.off);
			
			if (v.frequency) then
				entity:SetFrequency(v.frequency);
			end;
		end;
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if ( IsValid(physicsObject) ) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

-- A function to load the trash spawns.
function Schema:LoadTrashSpawns()
	self.trashSpawns = Clockwork.kernel:RestoreSchemaData( "plugins/trash/"..game.GetMap() );
	
	if (!self.trashSpawns) then
		self.trashSpawns = {};
	end;
end;

-- A function to get a random trash spawn.
function Schema:GetRandomTrashSpawn()
	local position = self.trashSpawns[ math.random(1, #self.trashSpawns) ];
	local players = _player.GetAll();
	
	return position;
end;

-- A function to get a random trash item.
function Schema:GetRandomTrashItem()
	local trashItem = self.trashItems[ math.random(1, #self.trashItems) ];
	
	if ( trashItem and math.random() <= ( 1 / (trashItem.worth * 2) ) ) then
		return trashItem;
	else
		return self:GetRandomTrashItem();
	end;
end;

-- A function to save the trash spawns.
function Schema:SaveTrashSpawns()
	Clockwork.kernel:SaveSchemaData("plugins/trash/"..game.GetMap(), self.trashSpawns);
end;

-- A function to save the radios.
function Schema:SaveRadios()
	local radios = {};
	
	for k, v in pairs( ents.FindByClass("cw_radio") ) do
		local physicsObject = v:GetPhysicsObject();
		local moveable;
		
		if ( IsValid(physicsObject) ) then
			moveable = physicsObject:IsMoveable();
		end;
		
		radios[#radios + 1] = {
			off = v:GetOff(),
			key = Clockwork.entity:QueryProperty(v, "key"),
			angles = v:GetAngles(),
			moveable = moveable,
			uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID"),
			position = v:GetPos(),
			frequency = v:GetFrequency()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/radios/"..game.GetMap(), radios);
end;

-- A function to make an explosion.
function Schema:MakeExplosion(position, scale)
	local explosionEffect = EffectData();
	local smokeEffect = EffectData();
	
	explosionEffect:SetOrigin(position);
	explosionEffect:SetScale(scale);
	smokeEffect:SetOrigin(position);
	smokeEffect:SetScale(scale);
	
	util.Effect("explosion", explosionEffect, true, true);
	util.Effect("cw_effect_smoke", smokeEffect, true, true);
end;

-- A function to get a player's heal amount.
function Schema:GetHealAmount(player, scale)
	return 15 * (scale or 1);
end;

-- A function to get a player's dexterity time.
function Schema:GetDexterityTime(player)
	return 7;
end;

-- A function to make a player wear clothes.
function Schema:PlayerWearClothes(player, itemTable)
	local clothes = player:GetCharacterData("clothes");
	local team = player:Team();
	
	if (itemTable) then
		itemTable:OnChangeClothes(player, true);
		
		player:SetCharacterData("clothes", itemTable.index);
		player:SetSharedVar("clothes", itemTable.index);
	else
		itemTable = Clockwork.item:Get(clothes);
		
		if (itemTable) then
			itemTable:OnChangeClothes(player, false);
			
			player:SetCharacterData("clothes", nil);
			player:SetSharedVar("clothes", 0);
		end;
	end;
	
	if (itemTable) then
		local instance = Clockwork.item:CreateInstance(itemTable.uniqueID);
		
		player:AddItem(instance);
	end;
end;