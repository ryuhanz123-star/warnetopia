
--[[
    WARNETOPIA COMPACT V2
    Compact GUI | Neon Blue
]]

if _G.Warnetopia then
    pcall(function() _G.Warnetopia:Destroy() end)
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local P = Players.LocalPlayer
local G = Instance.new("ScreenGui")
G.Name = "WarnetopiaCompact"
G.ResetOnSpawn = false
G.Parent = CoreGui

_G.Warnetopia = G

local BLUE = Color3.fromRGB(0,220,255)
local DARK = Color3.fromRGB(18,20,30)
local BUTTON = Color3.fromRGB(38,45,62)

local F = Instance.new("Frame",G)
F.Size = UDim2.fromOffset(280,410)
F.Position = UDim2.new(.5,-140,.5,-205)
F.BackgroundColor3 = DARK
F.Active = true
F.Draggable = true

Instance.new("UICorner",F).CornerRadius =
    UDim.new(0,12)

local Stroke = Instance.new("UIStroke",F)
Stroke.Color = BLUE
Stroke.Thickness = 1.5

-- HEADER
local Header = Instance.new("Frame",F)
Header.Size = UDim2.new(1,0,0,42)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel",Header)
Title.Size = UDim2.new(1,-105,1,0)
Title.Position = UDim2.fromOffset(10,0)
Title.BackgroundTransparency = 1
Title.Text = "WARNETOPIA V2"
Title.TextColor3 = BLUE
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

local function makeButton(parent,text,size,pos,color)
    local b = Instance.new("TextButton",parent)
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = color or BUTTON
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = true

    Instance.new("UICorner",b).CornerRadius =
        UDim.new(0,7)

    return b
end

local Min = makeButton(
    Header,"MIN",
    UDim2.fromOffset(42,25),
    UDim2.new(1,-92,0,8),
    BUTTON
)

local Close = makeButton(
    Header,"X",
    UDim2.fromOffset(32,25),
    UDim2.new(1,-42,0,8),
    Color3.fromRGB(180,40,55)
)

-- CONTENT
local S = Instance.new("ScrollingFrame",F)
S.Position = UDim2.fromOffset(10,48)
S.Size = UDim2.new(1,-20,1,-58)
S.BackgroundTransparency = 1
S.BorderSizePixel = 0
S.ScrollBarThickness = 3
S.ScrollBarImageColor3 = BLUE
S.AutomaticCanvasSize = Enum.AutomaticSize.Y
S.CanvasSize = UDim2.new()

local Layout = Instance.new("UIListLayout",S)
Layout.Padding = UDim.new(0,7)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

local Padding = Instance.new("UIPadding",S)
Padding.PaddingBottom = UDim.new(0,8)

local function Hum()
    local c = P.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function Root()
    local c = P.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function Button(name,callback)
    local b = makeButton(
        S,name,
        UDim2.new(1,0,0,34),
        UDim2.new(),
        BUTTON
    )

    b.TextSize = 12
    b.MouseButton1Click:Connect(callback)
    return b
end

local function Toggle(name,callback)
    local enabled = false

    local b = Button(name.." : OFF",function()
        enabled = not enabled

        b.Text = name..
            (enabled and " : ON" or " : OFF")

        b.BackgroundColor3 = enabled
            and Color3.fromRGB(0,120,105)
            or BUTTON

        callback(enabled)
    end)

    return b
end

-- MOVEMENT
local infiniteJump = false
local noclip = false

Toggle("Infinite Jump",function(v)
    infiniteJump = v
end)

UIS.JumpRequest:Connect(function()
    if infiniteJump then
        local h = Hum()
        if h then
            h:ChangeState(
                Enum.HumanoidStateType.Jumping
            )
        end
    end
end)

Toggle("Noclip",function(v)
    noclip = v
end)

local oldCollision = {}

RS.Stepped:Connect(function()
    local c = P.Character
    if not c then return end

    for _,part in ipairs(c:GetDescendants()) do
        if part:IsA("BasePart") then
            if noclip then
                if oldCollision[part] == nil then
                    oldCollision[part] = part.CanCollide
                end
                part.CanCollide = false
            elseif oldCollision[part] ~= nil then
                part.CanCollide = oldCollision[part]
                oldCollision[part] = nil
            end
        end
    end
end)

Button("WalkSpeed +32",function()
    local h = Hum()
    if h then h.WalkSpeed = 32 end
end)

Button("WalkSpeed Normal",function()
    local h = Hum()
    if h then h.WalkSpeed = 16 end
end)

Button("JumpPower +80",function()
    local h = Hum()
    if h then
        h.UseJumpPower = true
        h.JumpPower = 80
    end
end)

Button("JumpPower Normal",function()
    local h = Hum()
    if h then
        h.UseJumpPower = true
        h.JumpPower = 50
    end
end)

-- TELEPORT
Button("Teleport Spawn",function()
    local root = Root()
    local spawn = workspace:FindFirstChildWhichIsA(
        "SpawnLocation",true
    )

    if root and spawn then
        root.CFrame = spawn.CFrame * CFrame.new(0,4,0)
    end
end)

Button("Reset Character",function()
    local h = Hum()
    if h then h.Health = 0 end
end)

-- AUTO FEATURES
for _,name in ipairs({
    "Auto Open",
    "Auto Mission",
    "Auto Customer",
    "Auto Serve",
    "Auto Farm",
    "Auto Money"
}) do
    Toggle(name,function(v)
        warn(name,
            v and "ON - menunggu integrasi game"
            or "OFF"
        )
    end)
end

-- MINIMIZE / RESTORE
local minimized = false

Min.MouseButton1Click:Connect(function()
    minimized = not minimized

    S.Visible = not minimized
    F.Size = minimized
        and UDim2.fromOffset(280,42)
        or UDim2.fromOffset(280,410)

    Min.Text = minimized and "OPEN" or "MIN"
end)

-- CLOSE
Close.MouseButton1Click:Connect(function()
    noclip = false

    for part,old in pairs(oldCollision) do
        if part and part.Parent then
            part.CanCollide = old
        end
    end

    oldCollision = {}
    G:Destroy()
    _G.Warnetopia = nil
end)

print("WARNETOPIA COMPACT V2 LOADED")
