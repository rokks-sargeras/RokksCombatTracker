local addonName, addon = ...
addon.modules = addon.modules ~= nil and addon.modules or {}

-- General Options
--
-- bar:           string        - Default primary bar. Name of the bar to display on. Defaults to main friendly/hostile bars
-- name:          string        - Name of the spell
-- enabledUnits: "friendly"     - Default "friendly|hostile". show the spell for all, friendly only, or hostile only
--               "hostile"
--
-- text:          string        - Display custom text
-- showUnitName:  true          - Default false. Displays the name of the unit that the aura is affecting (if exists)
--                false
--
-- clone:         spellID       - Clones all of the settings from the specified spell Id
-- style:        "offensive"    - Defines the style of spell. Will use the associated user-defined border colors and sounds.
--               "defensive"
--               "immunity"
--               "reflect"
--               "cc"
--               "utility"
--
-- playerSpec:   "all"          - Default "all". Only show for the specified spec(s)
--               "magicSpecs"
--               "physicalSpecs"
--                specName
------------------------------------------------------------------------------------------------------------------------------
-- Sound Options
--
-- announce:                    - Announce this spell with text-to-speech. The value the priority of the announcement.
--           0                    0. Default. Do not play this spell
--           1                    1. Essential spell
--           2                    2. Important spell
--           3                    3. Situational Spell
--
-- soundEffect:  true           - Default false. Play the user-defined sound effect for this type of spell. Type must be
--               false          - specified.
--
-- sound:        string         - Play a custom sound effect. Must be the name of a sound file located in
--                              - Media\Sounds\SoundEffects\
------------------------------------------------------------------------------------------------------------------------------
-- Tracking      CDs
--
-- duration:     number         - Defaults to default user setting. A static duration to display the item.
-- charges:      number         - Default 0. Number of charges to track
-- reductions:   object         - Array of reduction KVPs
-- reductionKVP: object         - Key/Value Pair. The key is a spellId, the value is an object containing the name and
--                                reduction amount.
-- reduction:    number         - Number of seconds to reduce the parent spell when this id is seen
--
--                              - The following example sets a 90 second timer on Bestial Wrath(19574), but reduces it by 12
--                              - seconds every time Barbed Shot(217200) is cast.
--                                [19574] = {name="Bestial Wrath",duration=90",reductions={[217200]={name="Barbed Shot",reduction=12}}}

addon.modules.default = {
    ["auras"] = {
        [164815] = {name="Sunfire", bar="test"},
        [269747] = {name="Wildfire Bomb", bar="test"},
        [202748] = {name="Survival Tactics"},
    },
    ["castStart"] = {
        [194153] = {name="Starfire"},
    },
    ["castComplete"] = {
        [194153] = {name="Starfire"},
    },
    ["instant"] = {
        [8921] = {name="Moonfire"},
        [259387] = {name="Mongoose Bite"},
    },
    ["bars"] = {
        ["friendly"] = {
            ["displayName"] = "Friendly Spells",
            ["refreshRate"] = .1,                
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = -209,
                ["yOfs"] = -141,
            },
            ["icons"] = {
                ["align"] = "RIGHT",
                ["size"] = 36,
                ["borderSize"] = 2,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 5,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = false,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 6,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 30,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
        ["hostile"] = {
            ["displayName"] = "Enemy Spells",
            ["refreshRate"] = .1,
            ["animationTime"] = 1,
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = 209,
                ["yOfs"] = -141,
            },
            ["icons"] = {
                ["align"] = "LEFT",
                ["size"] = 36,
                ["borderSize"] = 2,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 5,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = true,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 6,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 30,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
        ["test-friendly"] = {
            ["displayName"] = "Friendly Test",
            ["refreshRate"] = .1,                
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = -259,
                ["yOfs"] = 141,
            },
            ["icons"] = {
                ["align"] = "RIGHT",
                ["size"] = 56,
                ["borderSize"] = 2,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 5,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = false,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 6,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 30,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
        ["test-hostile"] = {
            ["displayName"] = "Enemy Test",
            ["refreshRate"] = .1,
            ["animationTime"] = 1,
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = 259,
                ["yOfs"] = 141,
            },
            ["icons"] = {
                ["align"] = "LEFT",
                ["size"] = 56,
                ["borderSize"] = 2,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 5,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = true,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 6,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 30,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
        ["cooldowns-friendly"] = {
            ["displayName"] = "Friendly Cooldowns",
            ["refreshRate"] = .1,                
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = -147,
                ["yOfs"] = -96,
            },
            ["icons"] = {
                ["align"] = "RIGHT",
                ["size"] = 28,
                ["borderSize"] = 1,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 1,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = false,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 3,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 18,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
        ["cooldowns-hostile"] = {
            ["displayName"] = "Enemy Cooldowns",
            ["refreshRate"] = .1,
            ["animationTime"] = 1,
            ["maxSpellQueue"] = 100,
            ["clampedToScreen"] = true,
            ["strata"] = "LOW",
            ["position"] = {
                ["anchorPoint"] = "CENTER",
                ["relativeTo"] = "UIParent",
                ["relativePoint"] = "CENTER",
                ["xOfs"] = 147,
                ["yOfs"] = -96,
            },
            ["icons"] = {
                ["align"] = "LEFT",
                ["size"] = 28,
                ["borderSize"] = 1,
                ["borderColor"] = {0, 0, 0, .6},
                ["backdropSize"] = 1,
                ["backdropColor"] = {0, 0, 0, .4},
                ["innerBorder"] = true,
                ["innerBorderColor"] = {0, 0, 0, .9},
                ["font"] = "GameFontNormal",
                ["ellipsis"] = true,
                ["zoom"] = true,
                ["max"] = 6,
                ["padding"] = 3,
                ["showCooldown"] = true,
                ["cooldownCounter"] = true,
                ["cooldownFontSize"] = 18,
                ["cooldownFontColor"] = {1, 1, 0, 1},
                ["endAnimationTime"] = 1,
                ["swipeAlpha"] = .3,
                ["showTooltips"] = true,
            }
        },
    }
}
