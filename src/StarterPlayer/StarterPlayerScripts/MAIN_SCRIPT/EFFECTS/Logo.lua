local logo = {}

local HB = game:GetService("RunService").Heartbeat

local Texture = ""

local points = {}
local basePos = {}
local baseSize = {}
local randomVal = {}

logo.Playback = function(GUI,resolution)
	local BaseFrame = Instance.new("ImageLabel")
	Instance.new("UIAspectRatioConstraint",BaseFrame)
	BaseFrame.Position = UDim2.new(0.35,0,0.25,0)
	BaseFrame.Image = "rbxassetid://769277965"
	BaseFrame.ImageTransparency = 1
	BaseFrame.Size = UDim2.new(0.5,12,0.5,12)
	BaseFrame.BackgroundTransparency=1
	BaseFrame.BackgroundColor3=Color3.new(0,0,0)
	BaseFrame.BorderSizePixel = 0
	BaseFrame.ZIndex = 3
	BaseFrame.BorderColor3 = Color3.new(1,1,1)
	BaseFrame.Parent = GUI
	local BaseText = Instance.new("TextLabel")
	BaseText.Position = UDim2.new(-0.05,0,1,0)
	BaseText.Size = UDim2.new(1.1,0,0.2,0)
	BaseText.Text = "Made for RBXDev"
	BaseText.TextColor3 = Color3.new(1,1,1)
	BaseText.TextTransparency = 1
	BaseText.TextScaled = true
	BaseText.TextXAlignment = Enum.TextXAlignment.Center
	BaseText.Font = Enum.Font.SciFi
	BaseText.BackgroundTransparency=1
	BaseText.ZIndex = 3
	BaseText.Parent = BaseFrame
	local inc = 1/resolution
	local t = tick()
	for x=0,1,inc do
		local unitSubTable = {}
		for y=0,1,inc do
			local newFrame = Instance.new("Frame")
			newFrame.Name = "PlasmaFrame"
			newFrame.BorderSizePixel = 1
			newFrame.BorderColor3=Color3.new(0,0,0)
			newFrame.Size = UDim2.new(inc,0,inc,0) --thanks for the 1 pixel offset roblox
			newFrame.Position = UDim2.new(x,0,y,0)
			newFrame.BackgroundColor3=Color3.new(0,0,0)
			newFrame.Parent = BaseFrame
			newFrame.ZIndex = 4
			table.insert(points,newFrame)
			table.insert(basePos,newFrame.Position)
			table.insert(randomVal,x+y)
			table.insert(baseSize,newFrame.Size)
		end
	end
	local c = 3
	local dt = 2
	local trans = 1
	local stop = false
	--coroutine.resume(coroutine.create(function()
		while c > 0 do
			for i,v in pairs(points) do
				local basePosition = basePos[i]
				local baseSize = basePos[i]
				local val = randomVal[i]
				v.BackgroundTransparency = trans
				v.Position = basePosition+(UDim2.new(math.noise(c,val)/dt,0,math.noise(c*3,val)/dt,0))
			end
			HB:wait()
			trans = trans - 0.05
			if c < 1 then
				dt = dt + 0.5
			end
			c=c-0.01
		end
	--end)) 
	for i,v in pairs(points) do
		local basePosition = basePos[i]
		local val = randomVal[i]
		v.Position = basePosition
	end
	HB:wait()
	for i,v in pairs(points) do
		coroutine.resume(coroutine.create(function()
			for c=0,1,0.05 do
				v.BackgroundTransparency = c
				HB:wait()
			end
			v:Destroy()
		end))
	end
	for c=1,0,-0.05 do
		BaseFrame.BackgroundTransparency = c
		BaseFrame.ImageTransparency = c
		BaseText.TextTransparency = c
		HB:wait()
	end
	wait(5)
	for c=0,1,0.05 do
		BaseFrame.BackgroundTransparency = c
		BaseFrame.ImageTransparency = c
		BaseText.TextTransparency = c
		HB:wait()
	end
	BaseFrame:Destroy()
end

return logo
