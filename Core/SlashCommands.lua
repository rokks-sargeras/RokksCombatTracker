local addonName, addon = ...

function addon.registerSlashCommands()
    SLASH_rct1 = "/rct"
    SlashCmdList["rct"] = function(...)
        local slashParams = select(1, ...)
        local params = {strsplit(" ", slashParams)}
        local command = params[1]
        table.remove(params, 1)

        if command == "" then
            addon.help()
        end

        if command == "lock" then
            addon.lock()
        end

        if command == "unlock" then
            addon.unlock()
        end

        if command == "reset" then
            addon.resetSettings()
        end

        if command == "test" then
            addon.testAdd()
        end

        if command == "testremove" then
            addon.testRemove()
        end

        if command == "enable" then
            addon.enable()
        end

        if command == "disable" then
            addon.disable()
        end

        if command == "modules" then
            for moduleName, module in pairs(addon.modules) do
                print("Module: " .. tostring(moduleName))
            end
        end
    end
end