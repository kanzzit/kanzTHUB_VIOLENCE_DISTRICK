-- ========================================
-- 🔥 KANZTHUB 🔥
-- Loader v2.0
-- ========================================

local function CheckVersion()
    local version = "2.0"
    local latest = game:HttpGet("https://raw.githubusercontent.com/KanzTHub/KanzTHub/main/version.txt")
    if latest ~= version then
        return true
    end
    return false
end

local function LoadHub()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KanzTHub/KanzTHub/main/main.lua"))()
end

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "KanzTHub_Loading"
LoadingGui.Parent = game.CoreGui

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 400, 0, 250)
LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = LoadingGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "🔥 KanzTHub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.Parent = LoadingFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 25)
SubTitle.Position = UDim2.new(0, 0, 0, 80)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Loading..."
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 16
SubTitle.Parent = LoadingFrame

local Progress = Instance.new("Frame")
Progress.Size = UDim2.new(0, 300, 0, 6)
Progress.Position = UDim2.new(0.5, -150, 0, 140)
Progress.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Progress.BorderSizePixel = 0
Progress.Parent = LoadingFrame

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = Progress

local function UpdateProgress(percent)
    ProgressBar.Size = UDim2.new(percent, 0, 1, 0)
end

task.wait(0.3)
UpdateProgress(0.2)
SubTitle.Text = "Loading UI Library..."
task.wait(0.5)
UpdateProgress(0.4)
SubTitle.Text = "Loading Modules..."
task.wait(0.5)
UpdateProgress(0.6)
SubTitle.Text = "Loading Config..."
task.wait(0.5)
UpdateProgress(0.8)
SubTitle.Text = "Loading Features..."
task.wait(0.5)
UpdateProgress(1)
SubTitle.Text = "Ready!"
task.wait(0.3)

pcall(LoadHub)

LoadingGui:Destroy()
