-- ========================================
-- 🔥 KANZTHUB 🔥
-- Main Script v2.0
-- ========================================

if getgenv().KanzTHub_Loaded then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "KanzTHub",
        Text = "Already loaded!",
        Duration = 3
    })
    return
end
getgenv().KanzTHub_Loaded = true

local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

Library:Notify("🔥 KanzTHub v2.0 Loaded!", 5)

local Window = Library:CreateWindow({
    Title = 'KanzTHub',
    Footer = 'by KanzTHub 🚀',
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main', 'home'),
    Combat = Window:AddTab('Combat', 'sword'),
    Visual = Window:AddTab('Visual', 'eye'),
    Misc = Window:AddTab('Misc', 'settings'),
    Credits = Window:AddTab('Credits', 'star')
}

local autoFarmEnabled = false
local godModeEnabled = false
local espEnabled = false
local antiAfkEnabled = false

-- MAIN TAB
local MainTab = Tabs.Main
local PlayerGroup = MainTab:AddLeftGroupbox('Player Settings')

PlayerGroup:AddToggle('SpeedBoost', {
    Text = 'Speed Boost x10',
    Default = false,
    Callback = function(val)
        if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

PlayerGroup:AddToggle('JumpBoost', {
    Text = 'Jump Boost x5',
    Default = false,
    Callback = function(val)
        if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 250
        elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

PlayerGroup:AddButton('Infinite Yield', function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    Library:Notify('Infinite Yield Loaded!', 3)
end)

local InfoGroup = MainTab:AddRightGroupbox('Info')
InfoGroup:AddLabel('🚀 KanzTHub - Created by KanzTHub')
InfoGroup:AddLabel('📌 Version: 2.0')
InfoGroup:AddLabel('🎯 Support: Delta, Krnl, Fluxus')
InfoGroup:AddLabel('💀 Use at your own risk!')

-- COMBAT TAB
local CombatTab = Tabs.Combat
local FarmGroup = CombatTab:AddLeftGroupbox('Auto Farm')

FarmGroup:AddToggle('Auto Farm', {
    Text = 'Auto Farm (Nearest Enemy)',
    Default = false,
    Callback = function(val)
        autoFarmEnabled = val
        Library:Notify('Auto Farm: ' .. (val and 'ON' or 'OFF'), 2)
    end
})

local OPGroup = CombatTab:AddRightGroupbox('OP Features')

OPGroup:AddToggle('God Mode', {
    Text = 'God Mode (Immortal)',
    Default = false,
    Callback = function(val)
        godModeEnabled = val
        if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.MaxHealth = math.huge
            LocalPlayer.Character.Humanoid.Health = math.huge
            Library:Notify('🛡️ God Mode Activated!', 3)
        end
    end
})

-- VISUAL TAB
local VisualTab = Tabs.Visual
local ESPGroup = VisualTab:AddLeftGroupbox('ESP')

ESPGroup:AddToggle('ESP Players', {
    Text = 'ESP Players (Name & Distance)',
    Default = false,
    Callback = function(val)
        espEnabled = val
        Library:Notify('ESP: ' .. (val and 'ON' or 'OFF'), 2)
    end
})

local VisualFXGroup = VisualTab:AddRightGroupbox('Visual Effects')

VisualFXGroup:AddToggle('Full Bright', {
    Text = 'Full Bright',
    Default = false,
    Callback = function(val)
        if val then
            Lighting.Brightness = 10
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
        else
            Lighting.Brightness = 0.5
            Lighting.FogEnd = 500
        end
    end
})

-- MISC TAB
local MiscTab = Tabs.Misc
local UtilGroup = MiscTab:AddRightGroupbox('Utility')

UtilGroup:AddToggle('Anti AFK', {
    Text = 'Anti AFK',
    Default = false,
    Callback = function(val)
        antiAfkEnabled = val
        if val then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            Library:Notify('Anti AFK Activated!', 2)
        end
    end
})

UtilGroup:AddButton('Rejoin Game', function()
    TeleportService:Teleport(game.PlaceId)
end)

-- CREDITS TAB
local CreditsTab = Tabs.Credits
local CreditsGroup = CreditsTab:AddLeftGroupbox('About KanzTHub')
CreditsGroup:AddLabel('🌟 KanzTHub')
CreditsGroup:AddLabel('📝 Creator: KanzTHub')
CreditsGroup:AddLabel('🔧 Version: 2.0')
CreditsGroup:AddLabel('💀 Use at your own risk!')

-- SETTINGS TAB
local SettingsTab = Window:AddTab('Settings', 'settings')
local MenuGroup = SettingsTab:AddLeftGroupbox('Menu Settings')

MenuGroup:AddButton('Theme Manager', function()
    ThemeManager:OpenThemeManager()
end)

MenuGroup:AddButton('Save Config', function()
    SaveManager:Save()
    Library:Notify('Config Saved!', 3)
end)

MenuGroup:AddButton('Load Config', function()
    SaveManager:Load()
    Library:Notify('Config Loaded!', 3)
end)

SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)

RunService.Heartbeat:Connect(function()
    if autoFarmEnabled then
        local nearest = nil
        local shortestDist = math.huge
        local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
        
        if myPos then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - myPos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        nearest = player
                    end
                end
            end
        end
        
        if nearest and nearest.Character and nearest.Character:FindFirstChild("HumanoidRootPart") then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearest.Character.HumanoidRootPart.Position)
        end
    end
    
    if godModeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        LocalPlayer.Character.Humanoid.Health = math.huge
    end
    
    if antiAfkEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

print('[KanzTHub] Loaded Successfully!')
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KanzTHub",
    Text = "Loaded! Selamat bermain!",
    Duration = 5
})
