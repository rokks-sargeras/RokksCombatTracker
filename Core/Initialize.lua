local addonName, addon = ...

function addon.initialize()
    addon.loadSettings()
    addon.setLocalization()

    addon.infoFrame = addon.frameFactory.infoFrame()
    
    addon.spellBars.initialize(addon.modules[addon.settings.module])
    addon.loadModules()
    addon.registerSlashCommands()
end

function addon.resetSettings()
    addon.spellBars.lockBars()
    b35904e6bb2943c5adcfc4058c8cf6b3 = nil
    b35904e6bb2943c5adcfc4058c8cf6b3 = defaultSettings
    addon.settings = b35904e6bb2943c5adcfc4058c8cf6b3
    ReloadUI()
end

function addon.loadSettings()
    -- ### Commenting to prevent saving to savedvariables. Uncomment to enable agian.
    -- if b35904e6bb2943c5adcfc4058c8cf6b3 == nil then
    --     b35904e6bb2943c5adcfc4058c8cf6b3 = addon.defaultSettings
    -- end

    b35904e6bb2943c5adcfc4058c8cf6b3 = addon.defaultSettings

    addon.settings = b35904e6bb2943c5adcfc4058c8cf6b3
end

function addon.loadModules()
    if eccf8d028d224e618ac7f15b81a1c211 == nil or type(eccf8d028d224e618ac7f15b81a1c211) ~= "table" then return end
    for moduleName, externalModule in pairs(eccf8d028d224e618ac7f15b81a1c211) do
        if addon.modules[moduleName] == nil then
            addon.modules[moduleName] = externalModule
        end
    end
end