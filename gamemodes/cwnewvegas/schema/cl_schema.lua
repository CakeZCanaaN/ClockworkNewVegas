--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

surface.CreateFont("veg_Large3D2D", {
	size = Clockwork.kernel:FontScreenScale(2048),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_IntroTextSmall", {
	size = Clockwork.kernel:FontScreenScale(12),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_IntroTextTiny", {
	size = Clockwork.kernel:FontScreenScale(8),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_CinematicText", {
	size = Clockwork.kernel:FontScreenScale(14),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_IntroTextBig", {
	size = Clockwork.kernel:FontScreenScale(14),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_TargetIDText", {
	size = Clockwork.kernel:FontScreenScale(10),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_MenuTextHuge", {
	size = Clockwork.kernel:FontScreenScale(18),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_MenuTextBig", {
	size = Clockwork.kernel:FontScreenScale(16),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_MainText", {
	size = Clockwork.kernel:FontScreenScale(8),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
});

surface.CreateFont("veg_PlayerInfoText", {
	size = Clockwork.kernel:FontScreenScale(10),
	weight = 100,
	antialias = true,
	font = "Spranq eco sans"
})

Clockwork.config:AddToSystem("intro_text_small", "The small text displayed for the introduction.");
Clockwork.config:AddToSystem("intro_text_big", "The big text displayed for the introduction.");

Clockwork.datastream:Hook("RebuildBusiness", function(data)
	if (Clockwork.menu:GetOpen() and Schema.businessPanel) then
		if (Clockwork.menu:GetActiveTab() == Schema.businessPanel) then
			Schema.businessPanel:Rebuild();
		end;
	end;
end);

Clockwork.datastream:Hook("Frequency", function(data)
	Derma_StringRequest("Frequency", "What would you like to set the frequency to?", data, function(text)
		Clockwork.kernel:RunCommand("SetFreq", text);
	end);	
end);

Clockwork.datastream:Hook("ObjectPhysDesc", function(data)
	local entity = data;
	
	if ( IsValid(entity) ) then
		Derma_StringRequest("Description", "What is the physical description of this object?", nil, function(text)
			Clockwork.datastream:Start( "ObjectPhysDesc", {text, entity});
		end);
	end;
end);

-- A function to get whether a text entry is being used.
function Schema:IsTextEntryBeingUsed()
	if ( IsValid(self.textEntryFocused) ) then
		if ( self.textEntryFocused:IsVisible() ) then
			return true;
		end;
	end;
end;