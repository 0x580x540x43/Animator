--[[
  loadstring(game:HttpGet("https://raw.githubusercontent.com/0x580x540x43/Animator/main/Main.lua"))()
]]

local Global = (getgenv and getgenv()) or shared
Global.GelatekReanimateConfig = {
    -- [[ Rig Settings ]] --
    ["AnimationsDisabled"] = true,
    ["R15ToR6"] = true,
    ["DontBreakHairWelds"] = false,
    ["PermanentDeath"] = true,
    ["Headless"] = false,
    ["TeleportBackWhenVoided"] = true,

    -- [[ Reanimation Settings ]] --
    ["AlignReanimate"] = false,
    ["FullForceAlign"] = false,
    ["FasterHeartbeat"] = false,
    ["DynamicalVelocity"] = true,
    ["DisableTweaks"] = false,

    -- [[ Optimization ]] --
    ["OptimizeGame"] = false,

    -- [[ Miscellacious ]] --
    ["LoadLibrary"] = false,
    ["DetailedCredits"] = false,
    
    -- [[ Flinging Methods ]] --
    ["TorsoFling"] = true,
    ["BulletEnabled"] = false,
    ["BulletConfig"] = {
        ["RunAfterReanimate"] = true,
        ["LockBulletOnTorso"] = true
    }

    --[[
        R6 Bullet Hat (Optional And Recommended if BulletEnabled is true and PermamentDeath is false)
        https://www.roblox.com/catalog/48474313/Red-Roblox-Cap

        R15 Bullet Hat (Optional And Recommended if Bullet is true (PermamentDeath Doesn't matter)
        https://www.roblox.com/catalog/5973840187/Left-Sniper-Shoulder
    ]]
}

local Version = "1.0 (ALPHA)"

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Lexor Animator - " .. Version,
    HidePremium = true,
    SaveConfig = false,
    IntroEnabled = false,
    Icon = "Fucking Faggot"
})


------------------------------- Locals -------------------------------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local rad = math.rad;

local ogPos = {
    ["N"] = Character:WaitForChild("Torso"):FindFirstChild("Neck").C0,
    ["LS"] = Character:WaitForChild("Torso"):FindFirstChild("Left Shoulder").C0,
    ["RS"] = Character:WaitForChild("Torso"):FindFirstChild("Right Shoulder").C0,
    ["LH"] = Character:WaitForChild("Torso"):FindFirstChild("Left Hip").C0,
    ["RH"] = Character:WaitForChild("Torso"):FindFirstChild("Right Hip").C0
}

local CurrentPos = {
    [1] = {
        Time = 0,
        ["Neck"] = ogPos["N"],
        ["Left Shoulder"] = ogPos["LS"],
        ["Right Shoulder"] = ogPos["RS"],
        ["Left Hip"] = ogPos["LH"],
        ["Right Hip"] = ogPos["RH"]
    },
    [2] = {
        Time = 0,
        ["Neck"] = ogPos["N"],
        ["Left Shoulder"] = ogPos["LS"],
        ["Right Shoulder"] = ogPos["RS"],
        ["Left Hip"] = ogPos["LH"],
        ["Right Hip"] = ogPos["RH"]
    }
}

local function updateReanimateSettings(name, value)
    Global.GelatekReanimateConfig[name] = value
end

-- local function checkIfReanimated()
--     local returnval = false
--     if LocalPlayer.Character.Name == "GelatekReanimate" then
--         returnval =  true
--     end

--     return returnval
-- end


local function generateReanimate()
    local Reanimate = string.format([[
local Global = (getgenv and getgenv()) or shared
Global.GelatekReanimateConfig = {
    --  Rig Settings --
    ["AnimationsDisabled"] = %s,
    ["R15ToR6"] = %s,
    ["DontBreakHairWelds"] = %s,
    ["PermanentDeath"] = %s,
    ["Headless"] = %s,
    ["TeleportBackWhenVoided"] = %s,
    
    -- Reanimation Settings --
    ["AlignReanimate"] = %s,
    ["FullForceAlign"] = %s,
    ["FasterHeartbeat"] = %s,
    ["DynamicalVelocity"] = %s,
    ["DisableTweaks"] = %s,
    
    -- Optimization --
    ["OptimizeGame"] = %s,
    
    -- Flinging Methods --
    ["TorsoFling"] = %s,
    ["BulletEnabled"] = %s,
    ["BulletConfig"] = {
        ["RunAfterReanimate"] = %s,
        ["LockBulletOnTorso"] = %s,
    }

    -- R6 Bullet Hat (Optional And Recommended if BulletEnabled is true and PermamentDeath is false)
    -- https://www.roblox.com/catalog/48474313/Red-Roblox-Cap

    -- R15 Bullet Hat (Optional And Recommended if Bullet is true (PermamentDeath Doesn't matter)
    -- https://www.roblox.com/catalog/5973840187/Left-Sniper-Shoulder
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Gelatekussy/GelatekReanimate/main/Main.lua"))()
]], tostring(Global.GelatekReanimateConfig["AnimationsDisabled"]), tostring(Global.GelatekReanimateConfig["R15ToR6"]), tostring(Global.GelatekReanimateConfig["DontBreakHairWelds"]), tostring(Global.GelatekReanimateConfig["PermanentDeath"]), tostring(Global.GelatekReanimateConfig["Headless"]), tostring(Global.GelatekReanimateConfig["TeleportBackWhenVoided"]),tostring(Global.GelatekReanimateConfig["AlignReanimate"]), tostring(Global.GelatekReanimateConfig["FullForceAlign"]), tostring(Global.GelatekReanimateConfig["FasterHeartbeat"]), tostring(Global.GelatekReanimateConfig["DynamicalVelocity"]), tostring(Global.GelatekReanimateConfig["DisableTweaks"]), tostring(Global.GelatekReanimateConfig["OptimizeGame"]), tostring(Global.GelatekReanimateConfig["TorsoFling"]), tostring(Global.GelatekReanimateConfig["BulletEnabled"]), tostring(Global.GelatekReanimateConfig.BulletConfig["RunAfterReanimate"]), tostring(Global.GelatekReanimateConfig.BulletConfig["LockBulletOnTorso"]))

    return Reanimate
end

local function generateTween(type)
    local PsuedoCode = [[
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Neck = Character.Torso:FindFirstChild("Neck")
local LeftShoulder = Character.Torso:FindFirstChild("Left Shoulder")
local RightShoulder = Character.Torso:FindFirstChild("Right Shoulder")
local LeftHip = Character.Torso["Left Hip"]
local RightHip = Character.Torso:FindFirstChild("Right Hip")
local RootJoint = Character.HumanoidRootPart["RootJoint"]

local function tween(inst, tween_info, props)
    local tween = TweenService:Create(inst, tween_info, props)
    tween:Play()

    return tween
end

_G.AnimationLoop = coroutine.create(function()
    while true do
]]

    for i = 1, #CurrentPos do
        local Time =  CurrentPos[i].Time

        local N = CurrentPos[i]["Neck"]
        local NTween = string.format("tween(Neck, TweenInfo.new(%s, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {C0 = CFrame.new(%s)})", Time, tostring(N))

        local LS = CurrentPos[i]["Left Shoulder"]
        local LSTween = string.format("tween(LeftShoulder, TweenInfo.new(%s, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {C0 = CFrame.new(%s)})", Time, tostring(LS))

        local RS = CurrentPos[i]["Right Shoulder"]
        local RSTween = string.format("tween(RightShoulder, TweenInfo.new(%s, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {C0 = CFrame.new(%s)})", Time, tostring(RS))

        local LH = CurrentPos[i]["Left Hip"]
        local LHTween = string.format("tween(LeftHip, TweenInfo.new(%s, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {C0 = CFrame.new(%s)})", Time, tostring(LH))

        local RH = CurrentPos[i]["Right Hip"]
        local RHTween = string.format("tween(RightHip, TweenInfo.new(%s, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {C0 = CFrame.new(%s)})", Time, tostring(RH))

        PsuedoCode = PsuedoCode .. "\n        " .. NTween

        PsuedoCode = PsuedoCode .. "\n        " .. LSTween
        PsuedoCode = PsuedoCode .. "\n        " .. RSTween

        PsuedoCode = PsuedoCode .. "\n        " .. LHTween
        PsuedoCode = PsuedoCode .. "\n        " .. RHTween

        PsuedoCode = PsuedoCode .. "\n        " .. string.format("task.wait(%s)", Time)
    end

    PsuedoCode = PsuedoCode .. "\n    end\nend)\ncoroutine.resume(_G.AnimationLoop)"
    return PsuedoCode
end

------------------------------- Settings Tab -------------------------------
local settingsTab


local function makeSettingsTab()
    settingsTab = Window:MakeTab({
        Name = "Settings",
        Icon = "rbxassetid://4483345998"
    })

    settingsTab:AddSection({Name = "Misc"})

    settingsTab:AddButton({
        Name = "Copy Discord Link",
        Callback = function()
            setclipboard("https://discord.gg/Nxj2nh9YJD")
        end
    }) -- Discord Link

    settingsTab:AddButton({
        Name = "Destroy UI",
        Callback = function()
            OrionLib:Destroy()
        end
    }) -- Destroy UI
end

------------------------------- Reanimate Tab -------------------------------
local reanimateTab

local function makeReanimateTab()
    reanimateTab = Window:MakeTab({
        Name = "Reanimate",
        Icon = "rbxassetid://4483345998"
    })

    reanimateTab:AddSection({Name = "Reanimate with GelatekReanimate"})

    reanimateTab:AddButton({
        Name = "Reanimate",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Gelatekussy/GelatekReanimate/main/Main.lua"))()
        end
    }) -- Reanimate Button

    reanimateTab:AddSection({Name = "Fling Settings"})

    reanimateTab:AddToggle({
        Name = "Enable Torso Fling",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("TorsoFling", Value)
        end
    }) -- AnimationsDisabled

    reanimateTab:AddToggle({
        Name = "Enable Bullet Fling",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("BulletEnabled", Value)
        end
    }) -- BulletEnabled

    reanimateTab:AddSection({Name = "Rig Settings"})

    reanimateTab:AddToggle({
        Name = "Disable Animations",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("AnimationsDisabled", Value)
        end
    }) -- AnimationsDisabled

    reanimateTab:AddToggle({
        Name = "R15 to R6",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("R15ToR6", Value)
        end
    }) -- R15ToR6

    reanimateTab:AddToggle({
        Name = "Don't Break Hair Welds",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("DontBreakHairWelds", Value)
        end
    }) -- DontBreakHairWelds

    reanimateTab:AddToggle({
        Name = "Permanent Death",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("PermanentDeath", Value)
        end
    }) -- PermanentDeath

    reanimateTab:AddToggle({
        Name = "Headless (Requires Perma)",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("Headless", Value)
        end
    }) -- Headless

    reanimateTab:AddToggle({
        Name = "Teleport Back When Voided",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("TeleportBackWhenVoided", Value)
        end
    }) -- TeleportBackWhenVoided

    reanimateTab:AddSection({Name = "Reanimation Settings"})

    reanimateTab:AddToggle({
        Name = "Align Reanimate",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("AlignReanimate", Value)
        end
    }) -- AlignReanimate

    reanimateTab:AddToggle({
        Name = "Full Force Align",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("FullForceAlign", Value)
        end
    }) -- FullForceAlign

    reanimateTab:AddToggle({
        Name = "Dynamical Velocity",
        Default = true,
        Callback = function(Value)
            updateReanimateSettings("DynamicalVelocity", Value)
        end
    }) -- DynamicalVelocity

    reanimateTab:AddToggle({
        Name = "Disable Net Tweaks",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("DisableTweaks", Value)
        end
    }) -- DisableTweaks

    reanimateTab:AddSection({Name = "Optimization"})

    reanimateTab:AddToggle({
        Name = "Optimize Game",
        Default = false,
        Callback = function(Value)
            updateReanimateSettings("OptimizeGame", Value)
        end
    }) -- OptimizeGame
end

-------------------------------- Animation Tab ------------------------------
local animationTab, keyframeDropdown, reanimationloop

local function makeAnimationTab()
    animationTab = Window:MakeTab({
        Name = "Animation",
        Icon = "rbxassetid://4483345998"
    })

    animationTab:AddSlider({
        Name = "Keyframe 1 Time",
        Min = 0,
        Max = 10,
        Default = 0,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.1,
        ValueName = "seconds",
        Callback = function(Value)
            CurrentPos[1].Time = Value
        end
    })

    animationTab:AddSlider({
        Name = "Keyframe 2 Time",
        Min = 0,
        Max = 10,
        Default = 0,
        Color = Color3.fromRGB(255,255,255),
        Increment = 0.1,
        ValueName = "seconds",
        Callback = function(Value)
            CurrentPos[2].Time = Value
        end
    })

    animationTab:AddButton({
        Name = "Play Animation",
        Callback = function()
            loadstring(generateTween())()
        end
    })

    animationTab:AddButton({
        Name = "Stop Animation",
        Callback = function()
            if _G.AnimationLoop then
                coroutine.close(_G.AnimationLoop)
            end
        end
    })

    animationTab:AddButton({
        Name = "Copy Animation",
        Callback = function()
            local Finished = generateReanimate() .. generateTween()
            setclipboard(Finished)
        end
    })
end


------------------------------- BodyParts Tab -------------------------------
local done = { -- This b/c the ui library is ass
    [1] = {
        x = 0,
        z = 0,
        y = 0,
        rx = 0,
        ry = 0,
        rz = 0
    },
    [2] = {
        x = 0,
        z = 0,
        y = 0,
        rx = 0,
        ry = 0,
        rz = 0
    }
}

local function updateJoint(Part, toupdate, keyframe, Value) -- Unoptomized as fuck
    local Joint
    if Part.Name == "Head" then
        Joint = LocalPlayer.Character:FindFirstChild("Torso").Neck
    elseif Part.Name == "Left Arm" then
        Joint = LocalPlayer.Character.Torso:FindFirstChild("Left Shoulder")
    elseif Part.Name == "Right Arm" then
        Joint = LocalPlayer.Character.Torso:FindFirstChild("Right Shoulder")
    elseif Part.Name == "Left Leg" then
        Joint = LocalPlayer.Character.Torso:FindFirstChild("Left Hip")
    elseif Part.Name == "Right Leg" then
        Joint = LocalPlayer.Character.Torso:FindFirstChild("Right Hip")
    elseif Part.Name == "HumanoidRootPart" then
        Joint = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("RootJoint")
    end

    local rx,ry,rz = Joint.C0.Rotation:ToEulerAnglesXYZ()
    local CurrentJoint = CurrentPos[keyframe][Joint.Name]

    if done[keyframe][toupdate] >= 6 then
        if toupdate == "x" then
            CurrentJoint = CFrame.new(Vector3.new(Value, Joint.C0.Y, Joint.C0.Z)) * CFrame.Angles(rx, ry, rz)
        elseif toupdate == "y" then
            CurrentJoint = CFrame.new(Vector3.new(Joint.C0.X, Value, Joint.C0.Z)) * CFrame.Angles(rx, ry, rz)
        elseif toupdate == "z" then
            CurrentJoint = CFrame.new(Vector3.new(Joint.C0.X, Joint.C0.Y, Value)) * CFrame.Angles(rx, ry, rz)
        elseif toupdate == "rx" then
            CurrentJoint = CFrame.new(Joint.C0.Position) * CFrame.Angles(rad(Value), ry, rz)
        elseif toupdate == "ry" then
            CurrentJoint = CFrame.new(Joint.C0.Position) * CFrame.Angles(rx, rad(Value), rz)
        elseif toupdate == "rz" then
            CurrentJoint = CFrame.new(Joint.C0.Position) * CFrame.Angles(rx, ry, rad(Value))
        end
        CurrentPos[keyframe][Joint.Name] = CurrentJoint
        Joint.C0 = CurrentJoint
    else
        done[keyframe][toupdate] = done[keyframe][toupdate] + 1
    end
end

local function makeBodyPartTabs() -- Unoptomized as fuck
    for _,Part in pairs(Character:GetChildren()) do -- Coffeine literally has no idea that this exists :sob:
        if Part:IsA("Part") and Part.Name ~= "Torso" then
            local bodyPartTab = Window:MakeTab({
                Name = Part.Name,
                Icon = "rbxassetid://4483345998"
            })

            bodyPartTab:AddSection({Name = "Keyframe 1"})

            bodyPartTab:AddSlider({
                Name = "X1 [X Position 1]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "x", 1, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "Y1 [Y Position 1]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "y", 1, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "Z1 [Z Position 1]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "z", 1, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RX1 [X Rotation 1]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "rx", 1, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RY1 [Y Rotation 1]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "ry", 1, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RZ1 [Z Rotation 1]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "rz", 1, Value)
                end
            })


            bodyPartTab:AddSection({Name = "Keyframe 2"})

            bodyPartTab:AddSlider({
                Name = "X2 [X Position 2]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "x", 2, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "Y2 [Y Position 2]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "y", 2, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "Z2 [Z Position 2]",
                Min = -20,
                Max = 20,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "studs",
                Callback = function(Value)
                    updateJoint(Part, "z", 2, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RX2 [X Rotation 2]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "rx", 2, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RY2 [Y Rotation 2]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "ry", 2, Value)
                end
            })

            bodyPartTab:AddSlider({
                Name = "RZ2 [Z Rotation 2]",
                Min = -180,
                Max = 180,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                ValueName = "",
                Callback = function(Value)
                    updateJoint(Part, "rz", 2, Value)
                end
            })
        end
    end
end

------------------------------- Credits Tab -------------------------------
local creditsTab

local function makeCreditsTab()
    creditsTab = Window:MakeTab({
        Name = "Credits",
        Icon = "rbxassetid://4483345998"
    })

    creditsTab:AddSection({Name = "Lexor"})

    creditsTab:AddParagraph("Creator","Moon#9601")

    creditsTab:AddParagraph("Developers","Moon#9601\nHopefully more!")

    creditsTab:AddSection({Name = "Other"})

    creditsTab:AddParagraph("Orion UI Library","https://github.com/shlexware/Orion")

    creditsTab:AddParagraph("Gelatek Reanimate","https://github.com/Lisso-lab/Roblox-Dynamic-Reanimation")
end

------------------------------- Init -------------------------------
makeSettingsTab()
makeReanimateTab()
makeAnimationTab()

makeBodyPartTabs()
makeCreditsTab()

OrionLib:Init()
