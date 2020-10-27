local pGUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("_MAIN")
game.StarterGui:SetCoreGuiEnabled("All",false)
game.StarterGui:SetCore("TopbarEnabled",false)
local TweenService = game:GetService("TweenService")
local HB = game:GetService("RunService").Heartbeat
local plasma = require(script.Parent.Plasma)
local zGL = require(script.Parent["3D"])
local twister = require(script.Parent.Twister)
local logo = require(script.Parent.Logo)
local raster = require(script.Parent.RasterBar)
local wave = require(script.Parent.Wave)
local pic = require(script.Parent.PictureWave)
local shade = require(script.Parent.ShadeBob)
local swirl = require(script.Parent.Swirl)
local sin,pi,cos,sqrt = math.sin,math.pi,math.cos,math.sqrt
local res = 15
local frameRes = 5

local BaseFrame = Instance.new("Frame")
BaseFrame.Position = UDim2.new(0,0,0,-36)
BaseFrame.Size = UDim2.new(1,0,1,36)
BaseFrame.BackgroundTransparency = 0
BaseFrame.BackgroundColor3=Color3.new(0,0,0)
BaseFrame.BorderSizePixel = 3
BaseFrame.BorderColor3 = Color3.new(1,1,1)
BaseFrame.Parent = pGUI

local smallFrame = Instance.new("Frame")
smallFrame.Position = UDim2.new(0.3,0,0.1,0)
smallFrame.Size = UDim2.new(0.75,0,0.75,0)
smallFrame.BackgroundTransparency = 1
smallFrame.BackgroundColor3=Color3.new(0,0,0)
smallFrame.Parent = BaseFrame
smallFrame.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame)


pic.Play(smallFrame,50)