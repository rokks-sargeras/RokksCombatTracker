local addonName, addon = ...

function addon.registerEvents()
    if addon.eventFrame == nil then
        addon.eventFrame = CreateFrame("Frame", nil, UIParent)
    end
    
    addon.eventFrame:RegisterEvent("PLAYER_LOGIN")
    addon.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    addon.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    addon.eventFrame:SetScript("OnEvent", addon.routeEvent)
end

function addon.routeEvent(self, event, ...)
    if addon.settings ~= nil and addon.settings.enabled == false then return end

    if event == "PLAYER_LOGIN" then
        addon.initialize()
    end

    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        addon.onCombatLogEvent({CombatLogGetCurrentEventInfo()})
    end
    
    if event == "PLAYER_TARGET_CHANGED" then
        addon.onPlayerTargetChanged(...)
    end
end

function addon.onCombatLogEvent(eventInfo)
    local subEvent = eventInfo[2]

    if subEvent == "SPELL_AURA_APPLIED" or
        subEvent == "SPELL_AURA_REMOVED" or
        subEvent == "SPELL_AURA_REFRESH" or
        subEvent == "SPELL_AURA_APPLIED_DOSE" or
        subEvent == "SPELL_AURA_REMOVED_DOSE" or
        subEvent == "SPELL_AURA_BROKEN" or
        subEvent == "SPELL_AURA_BROKEN_SPELL"
        then
       
        addon.auraEvent(eventInfo)
    end

    if subEvent == "SPELL_CAST_START" or
        subEvent == "SPELL_CAST_FAILED" then        
        addon.castStartEvent(eventInfo)
    end
    
    if subEvent == "SPELL_CAST_SUCCESS" then        
        addon.castSuccessEvent(eventInfo)
    end
end

function addon.onPlayerTargetChanged()
    -- get target auras
    -- create aura event and send to event handler
end
