local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local SCRIPT_URL = "https://api.jnkie.com/api/v1/luascripts/public/807fa54e30df8fdea31b78ae1f835751b415432daa9fee1a796e7b1355964909/download"

-- ========== GUI ==========
local gui = Instance.new("ScreenGui")
gui.Name = "KitiKey"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not gui.Parent then gui.Parent = playerGui end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 150)
frame.Position = UDim2.new(0.5, -180, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.12
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.4
stroke.Parent = frame

local shimmer = Instance.new("Frame")
shimmer.Size = UDim2.new(1, 0, 1, 0)
shimmer.BackgroundTransparency = 1
shimmer.BorderSizePixel = 0
shimmer.ZIndex = 5
shimmer.Parent = frame

local shimmerGradient = Instance.new("UIGradient")
shimmerGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
shimmerGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.35, 0.7),
	NumberSequenceKeypoint.new(0.65, 0.7),
	NumberSequenceKeypoint.new(1, 1),
})
shimmerGradient.Rotation = 90
shimmerGradient.Offset = Vector2.new(-1, 0)
shimmerGradient.Parent = shimmer

task.spawn(function()
	while true do
		stroke.Transparency = 0.3 + 0.25 * math.sin(tick() * 3)
		task.wait()
	end
end)

task.spawn(function()
	while true do
		local tween = TweenService:Create(shimmerGradient, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Offset = Vector2.new(2, 0),
		})
		tween:Play()
		tween.Completed:Wait()
		task.wait(1.2)
		shimmerGradient.Offset = Vector2.new(-1, 0)
	end
end)

-- ========== header ==========
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 18, 0, 18)
logo.Position = UDim2.new(0, 12, 0, 10)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://10723396107"
logo.ImageColor3 = Color3.fromRGB(224, 224, 224)
logo.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 60, 0, 20)
title.Position = UDim2.new(0, 35, 0, 9)
title.BackgroundTransparency = 1
title.Text = "KITI"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0.7
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- ========== key input ==========
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -24, 0, 32)
keyBox.Position = UDim2.new(0, 12, 0, 36)
keyBox.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
keyBox.BorderSizePixel = 1
keyBox.BorderColor3 = Color3.fromRGB(40, 40, 40)
keyBox.PlaceholderText = "Введи ключ..."
keyBox.PlaceholderColor3 = Color3.fromRGB(85, 85, 85)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 6)
keyBoxCorner.Parent = keyBox
keyBox.Parent = frame

-- ========== activate button ==========
local actBtn = Instance.new("TextButton")
actBtn.Size = UDim2.new(1, -24, 0, 32)
actBtn.Position = UDim2.new(0, 12, 0, 76)
actBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
actBtn.BorderSizePixel = 0
actBtn.Text = "Активировать"
actBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
actBtn.Font = Enum.Font.GothamBold
actBtn.TextSize = 14
actBtn.AutoButtonColor = false
local actCorner = Instance.new("UICorner")
actCorner.CornerRadius = UDim.new(0, 6)
actCorner.Parent = actBtn
local actStroke = Instance.new("UIStroke")
actStroke.Color = Color3.fromRGB(255, 255, 255)
actStroke.Thickness = 1
actStroke.Transparency = 0.5
actStroke.Parent = actBtn
actBtn.Parent = frame

-- ========== status ==========
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 20)
status.Position = UDim2.new(0, 12, 0, 118)
status.BackgroundTransparency = 1
status.Text = "Введи ключ и нажми «Активировать»"
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
status.TextStrokeTransparency = 0.4
status.TextXAlignment = Enum.TextXAlignment.Center
status.TextWrapped = true
status.Parent = frame

-- ========== logic ==========
actBtn.MouseButton1Click:Connect(function()
	local key = keyBox.Text
	if #key == 0 then status.Text = "Введи ключ"; return end
	actBtn.Text = "Загружаем..."
	task.spawn(function()
		getgenv().SCRIPT_KEY = key
		status.Text = "Инжектим скрипт..."
		local ok2, res = pcall(function() return game:HttpGet(SCRIPT_URL) end)
		if not ok2 then
			status.Text = "Ошибка загрузки: " .. tostring(res)
			actBtn.Text = "Активировать"
			return
		end
		local fn, cerr = loadstring(res)
		if not fn then
			status.Text = "Ошибка компиляции: " .. tostring(cerr)
			actBtn.Text = "Активировать"
			return
		end
		local ok3, rerr = pcall(fn)
		if not ok3 then
			status.Text = "Ошибка скрипта: " .. tostring(rerr)
			actBtn.Text = "Активировать"
			return
		end
		gui:Destroy()
	end)
end)
