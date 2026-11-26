
--[[
    WARNETOPIA V3
    Compact Admin-Style Panel
    GUI + Local Settings
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
local Old = PlayerGui:FindFirstChild("WarnetopiaV3")
if Old then
    Old:Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WarnetopiaV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(280, 360)
Main.Position = UDim2.new(0.5, -140, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 1.5
Stroke.Parent = Main

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "WARNETOPIA V3"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Minimize
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(30, 28)
Minimize.Position = UDim2.new(1, -68, 0, 7)
Minimize.Text = "-"
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.BackgroundColor3 = Color3.fromRGB(20, 35, 55)
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.Parent = Header

-- Close
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30, 28)
Close.Position = UDim2.new(1, -34, 0, 7)
Close.Text = "X"
Close.TextSize = 14
Close.Font = Enum.Font.GothamBold
Close.BackgroundColor3 = Color3.fromRGB(180, 35, 45)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Parent = Header

local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.fromOffset(10, 52)
Content.Size = UDim2.new(1, -20, 1, -62)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.CanvasSize = UDim2.fromOffset(0, 0)
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Content

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 8)
end)

local function MakeButton(label, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -5, 0, 36)
    Button.BackgroundColor3 = Color3.fromRGB(27, 37, 55)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Text = label
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = true
    Button.Parent = Content

    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, 7)
    C.Parent = Button

    Button.MouseButton1Click:Connect(callback)
    return Button
end

local function MakeLabel(label)
    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -5, 0, 25)
    Text.BackgroundTransparency = 1
    Text.Text = label
    Text.TextColor3 = Color3.fromRGB(0, 190, 255)
    Text.TextSize = 12
    Text.Font = Enum.Font.GothamBold
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Content
end

-- Character helpers
local function GetHumanoid()
    local Character = Player.Character
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

-- Movement settings
MakeLabel("MOVEMENT SETTINGS")

MakeButton("WalkSpeed: Default", function()
    local Humanoid = GetHumanoid()
    if Humanoid then
        Humanoid.WalkSpeed = 16
    end
end)

MakeButton("JumpPower: Default", function()
    local Humanoid = GetHumanoid()
    if Humanoid then
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
    end
end)

MakeButton("Reset Character", function()
    local Humanoid = GetHumanoid()
    if Humanoid then
        Humanoid.Health = 0
    end
end)

-- Interface
MakeLabel("INTERFACE")

MakeButton("Refresh Character", function()
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

MakeButton("Show Player Information", function()
    local Character = Player.Character
    local Humanoid = GetHumanoid()

    if Humanoid then
        print("Player:", Player.Name)
        print("Health:", Humanoid.Health)
        print("WalkSpeed:", Humanoid.WalkSpeed)
    end
end)

MakeButton("Rejoin Current Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

-- Minimize / Restore
local Minimized = false

Minimize.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    Content.Visible = not Minimized
    Main.Size = Minimized
        and UDim2.fromOffset(280, 42)
        or UDim2.fromOffset(280, 360)
    Minimize.Text = Minimized and "+" or "-"
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag window
local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then
        local Delta = Input.Position - DragStart
        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

print("WARNETOPIA V3 Loaded")
