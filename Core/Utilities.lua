local addonName, addon = ...

function b35904e6bb2943c5adcfc4058c8cf6b3_func()
    addon.help()
end

function table.pack(...)
    return { n = select("#", ...), ... }
end

function addon.debugVarArgs(...)
    local args = table.pack(...)

    print("... {")
    for i = 1,args.n do
        print("  arg" .. i .. ": " .. tostring(v))
    end

    print("}")
end

function addon.debug(var, name)
    if type(var) == "string" then
        local output = name ~= nil and name .. ": " .. var or var
        print(output)
        return
    end
    
    local name = name ~= nil and name or nil
    if type(var) == "table" then
        local tableName = string.gsub(tostring(var), "table: ", "")
        print(tostring(name) .. " (" .. tableName .. ") {")
        for k, v in pairs(var) do
            print("  " .. tostring(k) .. ": " .. tostring(v))
        end
        print("}")
    else
        local debugString = name == nil and tostring(var) or name .. ": " .. tostring(var)
        print(debugString)
    end
end

function addon.testAdd()
    local spell1 = {key = "spell1", spellId = 47528, duration = 6, backdropColor = {.97, 0, .97, .3}, borderColor = {.97, 0, .97, .9}} -- purple
    local spell2 = {key = "spell2", spellId = 183752, duration = 4, backdropColor = {.549, 1, .102, .3}, borderColor = {.549, 1, .102, .8}} -- green
    local spell3 = {key = "spell3", spellId = 96231, duration = 6, backdropColor = {.98, 0, 0, .6}, borderColor = {1, 0, 0, .9}} -- red
    local spell4 = {key = "spell4", spellId = 106839, duration = 21, backdropColor = {0, 0, 1, .3}, borderColor = {0, 0, 1, .9}} -- dark blue
    local spell5 = {key = "spell5", spellId = 6552, duration = 18, desaturate=true, backdropColor = {0, 0, 0, .3},borderColor = {0, 0, 0, .8}} -- gray
    local spell6 = {key = "spell6", spellId = 119910, duration = 38, backdropColor={1, .102, .4, .3},borderColor = {1, .102, .4, .8}} -- pink
    local spell7 = {key = "spell7", spellId = 57994, duration = 5, backdropColor={0, 1, 1, .2},borderColor = {0, 1, 1, .9}, text="Rokks-Sargeras"} -- light blue
    local spell8 = {key = "spell8", spellId = 2139, duration = 17, backdropColor = {1, 1, .102, .3},borderColor = {1, 1, .102, .8}} -- yellow
    local spell9 = {key = "spell9", spellId = 1766, duration = 13, desaturate=true, backdropColor = {0, 0, 0, .3},borderColor = {0, 0, 0, .8}}
    
    addon.spellBars.showSpell("spells-friendly", spell1)
    addon.spellBars.showSpell("spells-friendly", spell2)
    addon.spellBars.showSpell("spells-friendly", spell3)
    addon.spellBars.showSpell("spells-friendly", spell4)
    addon.spellBars.showSpell("spells-friendly", spell5)
    
    addon.spellBars.showSpell("spells-hostile", spell9)
    addon.spellBars.showSpell("spells-hostile", spell8)
    addon.spellBars.showSpell("spells-hostile", spell7)
    addon.spellBars.showSpell("spells-hostile", spell6)
    addon.spellBars.showSpell("spells-hostile", spell5)

    addon.spellBars.showSpell("cooldowns-friendly", spell1)
    addon.spellBars.showSpell("cooldowns-friendly", spell2)
    
    addon.spellBars.showSpell("cooldowns-hostile", spell5)
    addon.spellBars.showSpell("cooldowns-hostile", spell9)
end

function addon.testRemove()
    addon.spellBars.removeSpell("friendlySpells", "spell3")
    addon.spellBars.removeSpell("enemySpells", "spell7")
end

function addon.help()
    print(" ")
    print("\124cffDB09FE------------------------------------")
    print("\124cffDB09FE" .. addon.L["RCT"])
    print("\124cffDB09FE------------------------------------")
    print("\124cffBAFF1A/rct lock \124cffFFFFFF- " .. addon.L["RCT_Command_Lock"])
    print("\124cffBAFF1A/rct unlock \124cffFFFFFF- " .. addon.L["RCT_Command_Unlock"])
    print("\124cffBAFF1A/rct reset \124cffFFFFFF- " .. addon.L["RCT_Command_Reset"])
    print("\124cffDB09FE------------------------------------")
    print("\124cffFF0000This text is red\124r")
end

function destructureEventInfo(eventInfo)
    local timestamp = eventInfo[1]
    local subEvent = eventInfo[2]
    local hideCaster = eventInfo[3]
    local sourceGuid = eventInfo[4]
    local sourceName = eventInfo[5]
    local sourceFlags = eventInfo[6]
    local raidFlags = eventInfo[7]
    local destGuid = eventInfo[8]
    local destName = eventInfo[9]
    local destFlags = eventInfo[10]
    local destRaidFlags = eventInfo[11]
    local spellId = eventInfo[12]
    local spellName = eventInfo[13]
    local spellSchool = eventInfo[14]
    
    local failedType = nil
    if subEvent == "SPELL_CAST_FAILED" then
        failedType = eventInfo[15]
    end

    local auraType = nil
    local amount = nil
    if subEvent == "SPELL_AURA_APPLIED" or
       subEvent == "SPELL_AURA_REMOVED" or
       subEvent == "SPELL_AURA_APPLIED_DOSE" or
       subEvent == "SPELL_AURA_REMOVED_DOSE" or
       subEvent == "SPELL_AURA_REFRESH" or
       subEvent == "SPELL_AURA_BROKEN" then
        auraType = eventInfo[15]
        amount = eventInfo[16]
    end

    local extraSpellId = nil
    local extraSpellName = nil
    local extraSchool = nil
    if subEvent == "SPELL_AURA_BROKEN_SPELL" then
        extraSpellId = eventInfo[15]
        extraSpellName = eventInfo[16]
        extraSchool = eventInfo[17]
        auraType = eventInfo[18]
    end

    return timestamp, subEvent, hideCaster, sourceGuid, sourceName, sourceFlags,
           raidFlags, destGuid, destName, destFlags, destRaidFlags, spellId,
           spellName, spellSchool, failedType, auraType, amount, extraSpellId,
           extraSpellName, extraSchool
end

function addon.getUnitId(inArena, destGuid)
    if inArena then
        unitId = UnitGUID("player") == destGuid and "player" or
                 UnitGUID("party1") == destGuid and "party1" or
                 UnitGUID("party2") == destGuid and "party2" or
                 UnitGUID("arena1") == destGuid and "arena1" or
                 UnitGUID("arena2") == destGuid and "arena2" or
                 UnitGUID("arena3") == destGuid and "arena3" or nil
    else
        unitId = UnitGUID("player") == destGuid and "player" or
                 UnitGUID("target") == destGuid and "target" or
                 UnitGUID("focus") == destGuid and "focus" or nil
    end

    return unitId
end

function addon.getUnitAura(unit, spell, filter)
    if filter and not filter:upper():find("FUL") then
        filter = filter.."|HELPFUL"
    end

    for i = 1, 255 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitAura(unit, i, filter)
        if not name then return end
        if spell == spellId or spell == name then
            return UnitAura(unit, i, filter)
        end
    end
end

function addon.lock()
    addon.spellBars.lockBars()
    addon.infoFrame:Hide()
end

function addon.unlock()
    addon.spellBars.unlockBars()
    addon.infoFrame:Show()
end

function addon.enable()
    addon.unlock()
    addon.settings.enabled = true
end

function addon.disable()
    addon.lock()
    addon.settings.enabled = false
end