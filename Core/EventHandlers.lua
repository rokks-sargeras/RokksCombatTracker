local addonName, addon = ...

function addon.auraEvent(eventInfo)
    local timestamp, subEvent, hideCaster, sourceGuid, sourceName, sourceFlags,
    raidFlags, destGuid, destName, destFlags, destRaidFlags, spellId,
    spellName, spellSchool, failedType, auraType, amount, extraSpellId,
    extraSpellName, extraSchool = destructureEventInfo(eventInfo)
    
    local auras = addon.modules[addon.settings.module].auras
    local spellAttributes = auras[spellId] ~= nil and auras[spellId] or nil

    if spellAttributes == nil then return end

    local spellKey = destGuid:gsub("-", "") .. spellId
    local sourceFriendly = bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0
    local inArena = IsActiveBattlefieldArena()

    -- Bar
    local bar = nil
    local barType = addon.getBarType(auraType, sourceFriendly)
    bar = spellAttributes.bar ~= nil and spellAttributes.bar .. "-" .. barType or barType
    if bar == nil then return end

    -- Enabled Units
    local enabledUnits = spellAttributes.enabledUnits ~= nil and spellAttributes.enabledUnits or "friendly,hostile"
    if not addon.isUnitEnabled(enabledUnits, sourceFriendly) then return end

    local text = spellAttributes.text ~= nil and spellAttributes.text or ""
    local showUnitName = spellAttributes.showUnitName ~= nil and spellAttributes.showUnitName == "true" and true or false
    local clone = spellAttributes.clone ~= nil and spellAttributes.clone or nil
    local style = spellAttributes.style ~= nil and spellAttributes.style or nil
    local playerSpec = spellAttributes.playerSpec ~= nil and spellAttributes.playerSpec or "all"
    local ttsPriority = spellAttributes.ttsPriority ~= nil and tonumber(spellAttributes.ttsPriority) or 0
    local soundEffect = spellAttributes.soundEffect ~= nil and spellAttributes.soundEffect == "true" and true or false
    local sound = spellAttributes.sound ~= nil and spellAttributes.sound or nil

    -- Duration
    local duration = spellAttributes.duration ~= nil and tonumber(spellAttributes.duration) or nil
    duration = duration or addon.getDuration(destGuid, auraType, inArena)
    if duration == nil then return end

    -- Display Spell
    local spellInfo = {
        key = spellKey,
        spellId = spellId,
        duration = duration
    }

    addon.spellBars.showSpell(bar, spellInfo)    
end

function addon.castStartEvent(eventInfo)    
    local timestamp, subEvent, hideCaster, sourceGuid, sourceName, flags,
    raidFlags, destGuid, destName, destFlags, destRaidFlags, spellId,
    spellName, spellSchool, failedType, auraType, amount,extraSpellId,
    extraSpellName, extraSchool, auraType = destructureEventInfo(eventInfo)

    local spellKey = sourceGuid:gsub("-", "") .. spellId

end

function addon.castSuccessEvent(eventInfo)
    -- if a spell from cast start exists with same index, it means this is closing a previously started cast
    -- otherwise it means it's an instant spell

    -- local spellKey = sourceGuid:gsub(const.guidSeparator, const.emptyString) .. spellId

    -- local spell1 = {key = "spell1", spellId = 47528, duration = 6, backdropColor = {.97, 0, .97, .3}, borderColor = {.97, 0, .97, .9}} -- purple
    -- addon.spellBars.showSpell("spells-friendly", spell1)
    local timestamp, subEvent, hideCaster, sourceGuid, sourceName, flags,
    raidFlags, destGuid, destName, destFlags, destRaidFlags, spellId,
    spellName, spellSchool, failedType, auraType, amount,extraSpellId,
    extraSpellName, extraSchool, auraType = destructureEventInfo(eventInfo)

    -- ####### Divide into Cast Complete and Instant
    local spellKey = sourceGuid:gsub("-", "") .. spellId

    -- local spell1 = {key = spellKey, spellId = spellId, duration = addon.settings.defaultDuration }
    -- addon.spellBars.showSpell(bar, spell1)
end

function addon.isUnitEnabled(enabledUnits, sourceFriendly)
    local enabledUnits = { strsplit(",", enabledUnits) }
    for key, unitType in pairs(enabledUnits) do
        if sourceFriendly and unitType == "friendly" or not sourceFriendly and unitType == "hostile" then
            return true
        end
    end
    return false
end

function addon.getBarType(auraType, sourceFriendly)
    return sourceFriendly and auraType == "DEBUFF" and "hostile" or
           sourceFriendly and auraType == "BUFF" and "friendly" or 
           not sourceFriendly and auraType == "DEBUFF" and "friendly" or
           not sourceFriendly and auraType == "BUFF" and "hostile" or nil
end

function addon.getDuration(destGuid, auraType, inArena)
    local destUnitId = addon.getUnitId(inArena, destGuid)
    local auraFilter = auraType == "BUFF" and "HELPFUL" or auraType == "DEBUFF" and "HARMFUL" or ""

    addon.debug(subEvent,"subEvent")
    addon.debug(destUnitId,"destUnitId")

    if destUnitId == nil then return end
    
    local name, icon, count, dispelType, totalDuration, expTime = addon.getUnitAura(destUnitId, spellId, auraFilter)
    
    duration = expTime ~= nil and expTime ~= 0 and expTime - GetTime() or nil

    return duration
end