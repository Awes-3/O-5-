repeat wait(0) until game.Players.LocalPlayer:FindFirstChild("PlayerGui") ~= nil
local pGUI = game.Players.LocalPlayer.PlayerGui:WaitForChild("_MAIN")
game.StarterGui:SetCoreGuiEnabled("All",false)
game.StarterGui:SetCore("TopbarEnabled",false)
local TweenService = game:GetService("TweenService")
local HB = game:GetService("RunService").Heartbeat
local plasma = require(script.EFFECTS.Plasma)
local shade = require(script.EFFECTS.ShadeBob)
local zGL = require(script.EFFECTS["3D"])
local raster = require(script.EFFECTS.RasterBar)
local pic = require(script.EFFECTS.PictureWave)
local twister = require(script.EFFECTS.Twister)
local swirl = require(script.EFFECTS.Swirl)
local wave = require(script.EFFECTS.Wave)
local sin,pi,cos,sqrt = math.sin,math.pi,math.cos,math.sqrt
local logo = require(script.EFFECTS.Logo)
local res = 15
local frameRes = 5
delay(5,function()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
end)

local function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end

local function waitFor(time)
	repeat HB:wait() until script.Music.TimePosition>=time
end

local BaseFrame = Instance.new("Frame")
BaseFrame.Position = UDim2.new(0,0,0,-36)
BaseFrame.Size = UDim2.new(1,0,1,36)
BaseFrame.BackgroundColor3=Color3.new(0,0,0)
BaseFrame.BorderSizePixel = 3
BaseFrame.BorderColor3 = Color3.new(1,1,1)
BaseFrame.Parent = pGUI

local ContentProvider = game:GetService("ContentProvider")

local loadTextures = {"rbxassetid://769277965","rbxassetid://897526082","rbxassetid://51107506","rbxassetid://44205319","rbxassetid://46579530","rbxgameasset://Images/TwitterIMG"}
for _, AssetId in pairs(loadTextures) do
	ContentProvider:Preload(AssetId)
end
while (ContentProvider.RequestQueueSize > 0) do
	wait(0)
end


--zGL.init()
--local scene = zGL.newScene(game.Workspace.Part.SurfaceGui)
--local verts = {Vector3.new(0.000000, -1.000000, 0.000000),
--Vector3.new(0.723600, -0.447215, 0.525720),
--Vector3.new(-0.276385, -0.447215, 0.850640),
--Vector3.new(-0.894425, -0.447215, 0.000000),
--Vector3.new(-0.276385, -0.447215, -0.850640),
--Vector3.new(0.723600, -0.447215, -0.525720),
--Vector3.new(0.276385, 0.447215, 0.850640),
--Vector3.new(-0.723600, 0.447215, 0.525720),
--Vector3.new(-0.723600, 0.447215, -0.525720),
--Vector3.new(0.276385, 0.447215, -0.850640),
--Vector3.new(0.894425, 0.447215, 0.000000),
--Vector3.new(0.000000, 1.000000, 0.000000)}
--
--local faces = {
--	{1,2,3},
--	{2,1,6},
--	{1,3,4},
--	{1,4,5},
--	{1,5,6},
--	{2,6,11},
--	{3,2,7},
--	{4,3,8},
--	{5,4,9},
--	{6,5,10},
--	{2,11,7},
--	{3,7,8},
--	{4,8,9},
--	{5,9,10},
--	{6,10,11},
--	{7,11,12},
--	{8,7,12},
--	{9,8,12},
--	{10,9,12},
--	{11,10,12}	
--	}
--local color
--local inActiveColor = Color3.new(1,1,1)
--local ActiveColor  = Color3.new(0,1,0.3)
--for i,face in pairs(faces) do
--	if i%2==0 then
--		color = ActiveColor
--	else
--		color = inActiveColor
--	end
--	local tri = zGL.newTriangle(verts[face[1]],verts[face[2]],verts[face[3]],color)
--	scene:insert(tri)
--end
--local dt = -10
--while HB:wait() do
--	dt = dt + 0.05
--	local cam = zGL.newCamera(CFrame.new(Vector3.new(2,4,4),Vector3.new(dt,-1,0)),70)
--	print(dt)
--	zGL.render(scene,cam)
--end

local Text = Instance.new("TextLabel")
Text.Position = UDim2.new(.25,0,.25,0)
Text.Size = UDim2.new(.5,0,.5,0)
Text.Font = Enum.Font.SciFi
Text.TextScaled = true
Text.TextColor3 = Color3.new(1,1,1)
Text.Text = "Everything you are about to see is generated and rendered in real-time, all GUI."
Text.BackgroundTransparency = 1
Text.Parent = BaseFrame

wait(5)
local textInf = TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,0,false,0)
local textGoal = {TextTransparency = 1,TextStrokeTransparency = 1}
local Tween = TweenService:Create(Text,textInf,textGoal)
Tween:Play()
wait(1)
Text:Destroy()
wait(0.5)

local smallFrame = Instance.new("Frame")
smallFrame.Position = UDim2.new(0,0,0,0)
smallFrame.Size = UDim2.new(0.2,0,0.2,0)
smallFrame.BackgroundColor3=Color3.new(0,0,0)
smallFrame.Parent = BaseFrame
smallFrame.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame)

local smallFrame2 = Instance.new("Frame")
smallFrame2.Position = UDim2.new(0,0,0,0)
smallFrame2.Size = UDim2.new(0.2,0,0.2,0)
smallFrame2.BackgroundColor3=Color3.new(0,0,0)
smallFrame2.Parent = BaseFrame
smallFrame2.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame2)

local smallFrame3 = Instance.new("Frame")
smallFrame3.Position = UDim2.new(0,0,0,0)
smallFrame3.Size = UDim2.new(0.2,0,0.2,0)
smallFrame3.BackgroundColor3=Color3.new(0,0,0)
smallFrame3.Parent = BaseFrame
smallFrame3.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame3)

local TAB = {}
local inc = 1/frameRes
plasma.initPlasma(BaseFrame,res)
plasma.initPlasma(smallFrame,res)
plasma.initPlasma(smallFrame2,res)
plasma.initPlasma(smallFrame3,res)
plasma.playback()

local step = false

local dt = 0
local dt2 = 5
local amp = 0.005
local cor = coroutine.create(function()
while true do
	if step == true then
	dt = dt + 0.0025
	dt2 = dt2 + amp
	smallFrame.Position = UDim2.new(0.5+sin(dt*3.5)/2.5,0,0.5+sin(dt*4)/3.5)
	smallFrame.Rotation = sin(dt*3)*30
	smallFrame2.Position = UDim2.new(0.5+sin(dt2*1)/2.5,0,0.5+sin(dt2*6)/3.5)
	smallFrame2.Rotation = sin(dt*7)*30
	smallFrame3.Position = UDim2.new(0.5+sin(dt2*1)/2.5,0,0.5+sin(dt*6)/3.5)
	smallFrame3.Rotation = sin(dt*5)*30
	end
	HB:wait()
end
end)

local function doStep()
	step = true
	wait(0)
	step = false
end


coroutine.resume(cor)
doStep()



script.Music:Play()

local Text = Instance.new("TextLabel")
Text.Position = UDim2.new(.25,0,.25,0)
Text.Size = UDim2.new(.5,0,.5,0)
Text.Font = Enum.Font.SciFi
Text.TextScaled = true
Text.TextColor3 = Color3.new(1,1,1)
Text.TextStrokeTransparency = 0.5
Text.Text = "Welcome to a scripting showcase by awesomeawesxomeman3."
Text.BackgroundTransparency = 1
Text.ZIndex = 12
Text.Parent = BaseFrame
delay(5,function()
	local Tween = TweenService:Create(Text,textInf,textGoal)
	Tween:Play()
	wait(1)
	Text:Destroy()
end)

waitFor(0.213)
doStep()
waitFor(0.324)
doStep()
waitFor(0.666)
doStep()
waitFor(1.160)
doStep()
waitFor(1.387)
doStep()
waitFor(1.600)
doStep()
waitFor(1.832)
doStep()
waitFor(2.177)
doStep()
waitFor(2.767)
doStep()
waitFor(3.227)
doStep()
waitFor(3.698)
doStep()
waitFor(3.903)
doStep()
waitFor(4.358)
doStep()
waitFor(5.269)
doStep()
waitFor(5.526)
doStep()
waitFor(5.756)
doStep()
waitFor(5.756)
doStep()
waitFor(6.432)
doStep()
waitFor(6.899)
doStep()
waitFor(7.365)
step = true
local Text = Instance.new("TextLabel")
Text.Position = UDim2.new(.25,0,.25,0)
Text.Size = UDim2.new(.5,0,.5,0)
Text.Font = Enum.Font.SciFi
Text.TextScaled = true
Text.TextColor3 = Color3.new(1,1,1)
Text.TextStrokeTransparency = 0.5
Text.Text = "While we're decrunching data and precomputing tables, enjoy the plasma."
Text.BackgroundTransparency = 1
Text.ZIndex = 12
Text.Parent = BaseFrame
delay(5,function()
	local Tween = TweenService:Create(Text,textInf,textGoal)
	Tween:Play()
	wait(1)
	Text:Destroy()
end)
waitFor(14.757)
waitFor(17.977)
step = false
plasma.stop()
smallFrame:TweenPosition(UDim2.new(1.5,0,smallFrame.Position.Y.Scale,0),"In","Sine",3)
smallFrame2:TweenPosition(UDim2.new(-0.5,0,smallFrame2.Position.Y.Scale,0),"In","Sine",3)
smallFrame3:TweenPosition(UDim2.new(1.5,0,smallFrame3.Position.Y.Scale,0),"In","Sine",3)
for _,v in pairs(BaseFrame:GetChildren()) do
	if v.Name == "PlasmaFrame" then
	coroutine.resume(coroutine.create(function()
	for i=0,1,0.05 do
		v.BackgroundTransparency = i
		HB:wait()
	end
	v:Destroy()
	end))
	end
end
delay(3,function()
	smallFrame:Destroy()
	smallFrame2:Destroy()
	smallFrame3:Destroy()
end)
waitFor(20.923)



local BG1 = Instance.new("Frame")
BG1.Position = UDim2.new(-1,0,0,-36)
BG1.Size = UDim2.new(1,0,0.5,36)
BG1.BackgroundColor3=Color3.fromRGB(17,81,93)
BG1.BorderSizePixel = 0
BG1.Parent = pGUI

local FR2 = Instance.new("Frame")
FR2.Rotation = 180
FR2.Position = UDim2.new(1,0,0.5,-36)
FR2.Size = UDim2.new(1,0,0.5,36)
FR2.BackgroundColor3=Color3.fromRGB(36,118,142)
FR2.BorderSizePixel = 0
FR2.Parent = pGUI

BG1:TweenPosition(UDim2.new(0,0,0,-36),"InOut","Linear",0.378)
waitFor(21.302)
FR2:TweenPosition(UDim2.new(0,0,0.5,-36),"InOut","Linear",0.378)
waitFor(22.152)
logo.Playback(BaseFrame,30)

waitFor(34.132)

local SphereFrame = Instance.new("Frame")
SphereFrame.Position = UDim2.new(0,0,0,-36)
SphereFrame.Size = UDim2.new(0,0,1,36)
SphereFrame.BackgroundTransparency = 1
SphereFrame.BackgroundColor3=Color3.new(0,0,0)
SphereFrame.BorderSizePixel = 3
SphereFrame.BorderColor3 = Color3.new(1,1,1)
SphereFrame.Parent = pGUI

local TweenInf = TweenInfo.new(1.757,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,0,false,0)
local goal = {Size = UDim2.new(0.5,0,1,36),Position = UDim2.new(.25,0,0,-36),BackgroundTransparency = 0}
local t = TweenService:Create(SphereFrame,TweenInf,goal)
t:Play()

waitFor(36.929)

twister.InitializeSolid(SphereFrame,80)

local FR = Instance.new("Frame")
FR.Position = UDim2.new(.25,0,0,-36)
FR.Size = UDim2.new(0.5,0,1,36)
FR.BackgroundColor3=Color3.new(0,0,0)
FR.BackgroundTransparency = 1
FR.BorderColor3 = Color3.new(1,1,1)
FR.Parent = pGUI

waitFor(38.769)

local circle1 = Instance.new("ImageLabel")
circle1.Position = UDim2.new(.25,0,0.3,-36)
circle1.Size = UDim2.new(0.05,0,0.25,36)
Instance.new("UIAspectRatioConstraint",circle1)
circle1.BackgroundTransparency=1
circle1.Image = "rbxassetid://279918838"
circle1.Parent = FR

swirl.addPart(circle1)

waitFor(39.100)


local circle2 = Instance.new("ImageLabel")
circle2.Position = UDim2.new(.25,0,0.5,-36)
circle2.Size = UDim2.new(0.05,0,0.25,36)
Instance.new("UIAspectRatioConstraint",circle1)
circle2.BackgroundTransparency=1
circle2.Image = "rbxassetid://279918838"
circle2.Parent = FR

swirl.addPart(circle2)

waitFor(39.470)


local circle3 = Instance.new("ImageLabel")
circle3.Position = UDim2.new(.25,0,0.7,-36)
circle3.Size = UDim2.new(0.05,0,0.25,36)
Instance.new("UIAspectRatioConstraint",circle1)
circle3.BackgroundTransparency=1
circle3.Image = "rbxassetid://279918838"
circle3.Parent = FR

swirl.addPart(circle3)
waitFor(40.613)
swirl.Play()

waitFor(44.291)
circle1.ImageColor3 = Color3.new(1,0,0)
circle2.ImageColor3 = Color3.new(0,1,0)
circle3.ImageColor3 = Color3.new(0,0,1)

local stop = false
coroutine.resume(coroutine.create(function()
	local dt = 1
	while stop == false do
		local Color = Color3.new((1.5+sin(dt))/2,(1.5+sin(dt*2))/2,(1.5+sin(dt*3))/2)
		twister.setSide2Color(Color)
		twister.setSide3Color(Color)
		dt = dt + 0.01
		HB:wait()
	end
end))
waitFor(58.161)
stop = true
local TweenInf = TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,0,false,0)
local goal = {Size = UDim2.new(0,0,1,36),Position = UDim2.new(0,0,0,-36),BackgroundTransparency = 1}
local t = TweenService:Create(SphereFrame,TweenInf,goal)
circle1:Destroy()
circle2:Destroy()
circle3:Destroy()
twister.stop()
t:Play()
wait(0.5)
SphereFrame:Destroy()

waitFor(59.084)

local BaseFrame2 = Instance.new("Frame")
BaseFrame2.Position = UDim2.new(0,0,2,-36)
BaseFrame2.Size = UDim2.new(1,0,1,36)
BaseFrame2.BackgroundTransparency = 1
BaseFrame2.BackgroundColor3=Color3.new(0,0,0)
BaseFrame2.BorderSizePixel = 3
BaseFrame2.BorderColor3 = Color3.new(1,1,1)
BaseFrame2.Parent = pGUI

raster.Play(BaseFrame2,20,Color3.new(0.5,0.2,0.3))
BaseFrame2:TweenPosition(UDim2.new(0,0,0,-36),"Out","Sine",3)

waitFor(70.637)
BaseFrame2:TweenPosition(UDim2.new(0,0,-2,-36),"In","Sine",3)
delay(3,function()
	raster.Stop()
	BaseFrame2:Destroy()
end)
waitFor(73.853)
wave.Play(FR2,100)
waitFor(87.700)
wave.Stop()
waitFor(88.622)
local smallFrame = Instance.new("Frame")
smallFrame.Position = UDim2.new(0.3,0,1,0)
smallFrame.Size = UDim2.new(0.75,0,0.75,0)
smallFrame.BackgroundTransparency = 1
smallFrame.BackgroundColor3=Color3.new(0,0,0)
smallFrame.Parent = BaseFrame
smallFrame.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame)
plasma.initPlasmaSphere(smallFrame,7)
plasma.playback()
wait(0)
smallFrame:TweenPosition(UDim2.new(0.3,0,0.1,0),"Out","Sine",1)
waitFor(102.465)
smallFrame:TweenPosition(UDim2.new(0.3,0,1,0),"In","Sine",1)
plasma.stop()
delay(1,function()
	smallFrame:Destroy()
end)

local Text = Instance.new("TextLabel")
Text.Position = UDim2.new(.25,0,.25,0)
Text.Size = UDim2.new(.5,0,.5,0)
Text.Font = Enum.Font.SciFi
Text.TextScaled = true
Text.TextColor3 = Color3.new(1,1,1)
Text.TextStrokeTransparency = 0.5
Text.Text = "2 superimposed 3D objects using one equation"
Text.BackgroundTransparency = 1
Text.ZIndex = 12
Text.Parent = BaseFrame
delay(5,function()
	local Tween = TweenService:Create(Text,textInf,textGoal)
	Tween:Play()
	wait(1)
	Text:Destroy()
end)

waitFor(110.782)
twister.setAllColor(Color3.new(0,0.4,1))
local function stepPause()
	twister.setPause(false)
	wait(0)
	twister.setPause(true)
end

local myFrame = BaseFrame:Clone()
myFrame.Parent = BaseFrame
twister.InitializeCustom(myFrame,50)
twister.setPause(false)
twister.InitializeCustom(myFrame,50)

stepPause()
waitFor(111.228)
stepPause()
waitFor(111.698)
stepPause()
waitFor(112.131)
stepPause()
waitFor(112.599)
stepPause()
waitFor(113.056)
stepPause()
waitFor(113.524)
stepPause()
waitFor(114.004)
stepPause()
waitFor(114.448)
stepPause()
waitFor(114.898)
stepPause()
waitFor(115.380)
stepPause()
waitFor(115.828)
stepPause()
waitFor(116.283)
stepPause()
waitFor(116.283)
stepPause()
waitFor(116.742)
stepPause()
waitFor(117.209)

twister.setPause(false)
twister.setSpeed(0.05)
waitFor(117.682)
local TwistStop = false
twister.setSpeed(-0.05)
waitFor(118.136)
twister.setSpeed(0.01)
twister.setTwist(100000)
coroutine.resume(coroutine.create(function()
	local dt = 1
	while TwistStop == false do
		local Color = Color3.new((1.5+sin(dt))/2,(1.5+sin(dt*2))/2,(1.5+sin(dt*3))/2)
		twister.setAllColor(Color)
		dt = dt + 0.01
		HB:wait()
	end
end))
waitFor(125.550)
waitFor(132.442)
myFrame:Destroy()
TwistStop = true
waitFor(132.931)
local BaseFrame2 = Instance.new("Frame")
BaseFrame2.Position = UDim2.new(0,0,0,-36)
BaseFrame2.Size = UDim2.new(1,0,1,36)
BaseFrame2.BackgroundColor3 = Color3.fromRGB(17,81,93)
BaseFrame2.BackgroundTransparency =1
BaseFrame2.BorderSizePixel = 3
BaseFrame2.BorderColor3 = Color3.new(1,1,1)
BaseFrame2.Parent = pGUI

shade.newShade(BaseFrame2)
waitFor(145.384)
BaseFrame2:TweenSize(UDim2.new(1,0,0,0),"Out","Bounce",1)
delay(1,function()
	BaseFrame2:Destroy()
end)

waitFor(147.700)

local BaseFrame2 = Instance.new("Frame")
BaseFrame2.Position = UDim2.new(0,0,2,-36)
BaseFrame2.Size = UDim2.new(1,0,1,36)
BaseFrame2.BackgroundTransparency = 1
BaseFrame2.BackgroundColor3=Color3.new(0,0,0)
BaseFrame2.BorderSizePixel = 3
BaseFrame2.BorderColor3 = Color3.new(1,1,1)
BaseFrame2.Parent = pGUI

raster.Play(BaseFrame2,20,Color3.new(0.5,0.2,0.3))
BaseFrame2:TweenPosition(UDim2.new(0,0,0,-36),"Out","Sine",3)

waitFor(157.876)
BaseFrame2:TweenPosition(UDim2.new(0,0,-2,-36),"In","Sine",3)
delay(3,function()
	raster.Stop()
	BaseFrame2:Destroy()
end)
waitFor(159.303)
BG1:TweenPosition(UDim2.new(-1,0,0,-36),"InOut","Linear",2.5)
FR2:TweenPosition(UDim2.new(1,0,0.5,-36),"InOut","Linear",2.5)
waitFor(162.449)

local Text = Instance.new("TextLabel")
Text.Position = UDim2.new(.25,0,.25,0)
Text.Size = UDim2.new(.5,0,.5,0)
Text.Font = Enum.Font.SciFi
Text.TextScaled = true
Text.TextColor3 = Color3.new(1,1,1)
Text.TextStrokeTransparency = 0.5
Text.Text = "Are you ready?"
Text.BackgroundTransparency = 1
Text.ZIndex = 12
Text.Parent = BaseFrame
delay(0.7,function()
	local Tween = TweenService:Create(Text,textInf,textGoal)
	Tween:Play()
	wait(1)
	Text:Destroy()
end)

local BaseFrame2 = Instance.new("Frame")
BaseFrame2.Position = UDim2.new(0,0,0,-36)
BaseFrame2.Size = UDim2.new(1,0,1,36)
BaseFrame2.BackgroundTransparency = 0
BaseFrame2.BackgroundColor3=Color3.new(0,0,0)
BaseFrame2.BorderSizePixel = 3
BaseFrame2.BorderColor3 = Color3.new(1,1,1)
BaseFrame2.Parent = pGUI

waitFor(164.319)
twister.InitializeCustomTexture(BaseFrame2,50,"rbxassetid://51107506","rbxassetid://44205319","rbxassetid://46579530")
waitFor(169.832)
twister.setTwist(100000)
waitFor(176.775)
BaseFrame2:Destroy()
waitFor(177.216)
local smallFrame = Instance.new("Frame")
smallFrame.Position = UDim2.new(0.3,0,0.1,0)
smallFrame.Size = UDim2.new(0.75,0,0.75,0)
smallFrame.BackgroundTransparency = 1
smallFrame.BackgroundColor3=Color3.new(0,0,0)
smallFrame.Parent = BaseFrame
smallFrame.BorderSizePixel = 2
Instance.new("UIAspectRatioConstraint",smallFrame)


pic.Play(smallFrame,50)

--[[

local smallFrame = Instance.new("Frame")
smallFrame.Position = UDim2.new(0,0,0,0)
smallFrame.Size = UDim2.new(0.2,0,0.2,0)
smallFrame.BackgroundColor3=Color3.new(0,0,0)
smallFrame.Parent = FR
smallFrame.BorderSizePixel = 0
Instance.new("UIAspectRatioConstraint",smallFrame)

local smallFrame2 = Instance.new("Frame")
smallFrame2.Position = UDim2.new(0,0,0,0)
smallFrame2.Size = UDim2.new(0.2,0,0.2,0)
smallFrame2.BackgroundColor3=Color3.new(0,0,0)
smallFrame2.Parent = FR
smallFrame2.BorderSizePixel = 0
Instance.new("UIAspectRatioConstraint",smallFrame2)

local smallFrame3 = Instance.new("Frame")
smallFrame3.Position = UDim2.new(0,0,0,0)
smallFrame3.Size = UDim2.new(0.2,0,0.2,0)
smallFrame3.BackgroundColor3=Color3.new(0,0,0)
smallFrame3.Parent = FR
smallFrame3.BorderSizePixel = 0
Instance.new("UIAspectRatioConstraint",smallFrame3)]]--

--[[local TAB = {}
local inc = 1/frameRes
--plasma.initPlasma(FR,res)
plasma.initPlasma(smallFrame,res)
plasma.initPlasma(smallFrame2,res)
plasma.initPlasma(smallFrame3,res)
plasma.playback()

local dt = 0
local dt2 = 5
while true do
	dt = dt + 0.0025
	dt2 = dt2 + 0.005
	smallFrame.Position = UDim2.new(0.5+sin(dt*3.5)/2.5,0,0.5+sin(dt*4)/3.5)
	smallFrame2.Position = UDim2.new(0.5+sin(dt2*1)/2.5,0,0.5+sin(dt2*6)/3.5)
	smallFrame3.Position = UDim2.new(0.5+sin(dt2*1)/2.5,0,0.5+sin(dt*6)/3.5)
	HB:wait()
end]]--



--[[for x=0,1,inc do
	local unitSubTable = {}
	--local subBuffer = {}
	for y=0,1,inc do
		local newFrame = Instance.new("Frame")
		newFrame.BorderSizePixel = 0
		newFrame.ZIndex = 10
		newFrame.Size = UDim2.new(inc,1,inc,1) --thanks for the 1 pixel offset roblox
		newFrame.Position = UDim2.new(x,0,y,0)
		newFrame.Visible = false
		newFrame.BackgroundTransparency = 1
		newFrame.Parent = FR
		plasma.initPlasma(newFrame,res)
		table.insert(TAB,newFrame)
		--table.insert(subBuffer,0)
	end
	--table.insert(buffer,subBuffer)
end

for _,frame in pairs(TAB) do
	frame.Visible = true
	wait(0.3)
end]]--


