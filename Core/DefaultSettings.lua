local addonName, addon = ...

addon.defaultSettings = {
    ["locked"] = false,
    ["enabled"] = true,
    ["module"] = "default",
    ["defaultDuration"] = 5,
    ["announceLevel"] = 1,
    ["soundEffects"] = true,
    ["soundChannel"] = "DIALOG",
    ["styles"] = {
        ["offensive"] = {backdropColor={.97,0,.97,.3},borderColor={.97,0,.97,.9}}, -- purple
        ["defensive"] = {backdropColor={.549,1,.102,.3},borderColor={.549,1,.102,.8}}, -- green
        ["immunity"] = {backdropColor={.98, 0, 0, .6},borderColor={.98,0,0,.8},soundEffect="Sfx\\blip-videogame.mp3"}, -- red
        ["reflect"] = {backdropColor={1,.102,.4,.3},borderColor={1,.102,.4,.8},soundEffect="Sfx\\blip-scifi.mp3"}, -- pink
        ["cc"] = {backdropColor={0,1,1,.3},borderColor={0,1,1,.8}}, -- light blue
        ["ccImmunity"] = {backdropColor={0,0,1,.3},borderColor={0,0,1,.9}}, -- dark blue
        ["utility"] = {backdropColor={0,0,0,.3},borderColor={0,0,0,.8}}, -- yellow
        ["cooldown"] =  {desaturate=true,backdropColor={0,0,0,.3},borderColor={0,0,0,.8}} -- gray
    }
}
