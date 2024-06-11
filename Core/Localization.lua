local addonName, addon = ...

function addon.setLocalization()
	local L = {}
	L["RCT"] = "Rokks Combat Tracker"
	L["RCT_Desc"] = "Description"
	L["RCT_Command_Lock"] = "Locks the bars."
	L["RCT_Command_Unlock"] = "Unlocks the bars."
	L["RCT_Command_Reset"] = "Resets all settings to default."
	-- L[""] = ""

	local locale = GetLocale()
	if locale == "ruRU" then
		L["RCT"] = "Роккон Комбат Трэкер"
	end

	addon.L = L
end
