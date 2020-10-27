local twister = {}

local sin = math.sin
local HB = game:GetService("RunService").Heartbeat
local stop = false

local Side1Color = Color3.new(1,0,0)
local Side2Color = Color3.new(1,0,0)
local Side3Color = Color3.new(1,0,0)
local Side4Color = Color3.new(1,0,0)


local function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end

twister.setSide1Color = function(color)
	Side1Color = color
end

twister.setSide2Color = function(color)
	Side2Color = color
end

twister.setSide3Color = function(color)
	Side3Color = color
end

twister.setSide4Color = function(color)
	Side4Color = color
end

twister.setAllColor = function(color)
	Side1Color = color
	Side2Color = color
	Side3Color = color
	Side4Color = color
end

twister.stop = function()
	stop = true
	delay(1,function()stop = false end)
end

local speed = 0.01
local twistInc = 0.01
local pause = false

twister.setPause = function(val)
	pause = val
end

twister.setTwist = function(val)
	twistInc = val
end

twister.setSpeed = function(val)
	speed = val
end

twister.InitializeCustomTexture = function(GUI,resolution,Side1Texture,Side2Texture,Side3Texture)
	twister.setAllColor(Color3.new(1,1,1))
	speed = 0.01
	twistInc = 0.01
	pause = false
	stop = false
	local c = workspace.CurrentCamera
	local floor = math.floor
	local function generateTwist(a)
		local twist = a*2
		local angle = a
		GUI:ClearAllChildren()
		local step = 1
		for y=0,1,1/resolution do
			local amp = 1
			local size = (4+(sin(angle)*2))/(resolution/50)
			local xOffset = sin(twist)*50
			local x1 = (1+sin((a/amp)+angle))/size
			local x2 = (1+sin((a/amp)+angle+90))/size
			local x3 = (1+sin((a/amp)+angle+90*2))/size
			local x4 = (1+sin((a/amp)+angle+90*3))/size
			if x1<x2 then
				local Frame = Instance.new("ImageLabel")
				--Frame.ScaleType = Enum.ScaleType.Tile
				Frame.Size = UDim2.new(math.abs(x1-x2)/4,1,1/resolution,1)
				Frame.ImageRectSize = Vector2.new(1280,20)
				Frame.ImageRectOffset = Vector2.new(0,Frame.ImageRectSize.Y*step)
				Frame.Position = UDim2.new((x1/4)+0.4,xOffset,y,0)
				Frame.Image = Side1Texture
				Frame.ZIndex = 4
				local delimiter = map(Frame.Size.X.Scale,0,0.1,1,0)
				local color = Color3.new(Side1Color.r-delimiter,Side1Color.g-delimiter,Side1Color.b-delimiter)
				Frame.ImageColor3 = color
				Frame.BorderSizePixel = 0
				Frame.Parent = GUI
			end
			if x2<x3 then
				local Frame = Instance.new("ImageLabel")
				Frame.Size = UDim2.new(math.abs(x2-x3)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x2/4)+0.4,xOffset,y,0)
				Frame.ImageRectSize = Vector2.new(1280,20)
				Frame.ImageRectOffset = Vector2.new(0,Frame.ImageRectSize.Y*step)
				Frame.Image = Side2Texture
				Frame.ZIndex = 4
				local delimiter = map(Frame.Size.X.Scale,0,0.1,1,0)
				local color = Color3.new(Side2Color.r-delimiter,Side2Color.g-delimiter,Side2Color.b-delimiter)
				Frame.ImageColor3 = color
				Frame.BorderSizePixel = 0
				Frame.Parent = GUI
			end
			if x3<x4 then
				local Frame = Instance.new("ImageLabel")
				Frame.Size = UDim2.new(math.abs(x3-x4)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x3/4)+0.4,xOffset,y,0)
				Frame.ImageRectSize = Vector2.new(1280,20)
				Frame.ImageRectOffset = Vector2.new(0,Frame.ImageRectSize.Y*step)
				Frame.Image = Side3Texture
				Frame.ZIndex = 4
				local delimiter = map(Frame.Size.X.Scale,0,0.1,1,0)
				local color = Color3.new(Side3Color.r-delimiter,Side3Color.g-delimiter,Side3Color.b-delimiter)
				Frame.ImageColor3 = color
				Frame.BorderSizePixel = 0				
				Frame.Parent = GUI
			end
			if x4<x1 then
				local Frame = Instance.new("ImageLabel")
				Frame.Size = UDim2.new(math.abs(x4-x1)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x4/4)+0.4,xOffset,y,0)
				Frame.ImageRectSize = Vector2.new(1280,20)
				Frame.ImageRectOffset = Vector2.new(0,Frame.ImageRectSize.Y*step)
				Frame.Image = Side3Texture
				Frame.ZIndex = 4
				local delimiter = map(Frame.Size.X.Scale,0,0.02,1,0)
				local color = Color3.new(Side4Color.r-delimiter,Side4Color.g-delimiter,Side4Color.b-delimiter)
				Frame.ImageColor3 = color
				Frame.BorderSizePixel = 0
				Frame.Parent = GUI
			end
			step = step + 1
			if step > 7 then step = 0 end
			a=a+0.001
			angle=angle+sin(a)/7
			twist = twist + twistInc
			if angle>360 then
				angle = 0
			end
		end
		
	end
	local dt = 0
	coroutine.resume(coroutine.create(function()
		while stop == false do
			if pause == false then
				generateTwist(dt)
				dt = dt + speed
			end
			HB:wait()
		end
		GUI:ClearAllChildren()
	end))
end

twister.InitializeCustom = function(GUI,resolution)
	local c = workspace.CurrentCamera
	local floor = math.floor
	local function generateTwist(a)
		local twist = a*2
		local angle = a
		GUI:ClearAllChildren()
		for y=0,1,1/resolution do
			local amp = 1
			local size = (4+(sin(angle)*2))/(resolution/50)
			local xOffset = sin(twist)*50
			local x1 = (1+sin((a/amp)+angle))/size
			local x2 = (1+sin((a/amp)+angle+90))/size
			local x3 = (1+sin((a/amp)+angle+90*2))/size
			local x4 = (1+sin((a/amp)+angle+90*3))/size
			if x1<x2 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x1-x2)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x1/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side1Color.r-delimiter,Side1Color.g-delimiter,Side1Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			if x2<x3 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x2-x3)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x2/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side2Color.r-delimiter,Side2Color.g-delimiter,Side2Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			if x3<x4 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x3-x4)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x3/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side3Color.r-delimiter,Side3Color.g-delimiter,Side3Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color				
				Frame.Parent = GUI
			end
			if x4<x1 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x4-x1)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x4/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.03,1,0)
				local color = Color3.new(Side4Color.r-delimiter,Side4Color.g-delimiter,Side4Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			a=a+0.001
			angle=angle+sin(a)/7
			twist = twist + twistInc
			if angle>360 then
				angle = 0
			end
		end
		
	end
	local dt = 0
	coroutine.resume(coroutine.create(function()
		while stop == false do
			if pause == false then
				generateTwist(dt)
				dt = dt + speed
			end
			HB:wait()
		end
		GUI:ClearAllChildren()
	end))
end

twister.InitializeSolid = function(GUI,resolution)
	local c = workspace.CurrentCamera
	local floor = math.floor
	local function generateTwist(a)
		local twist = a*2
		local angle = a
		GUI:ClearAllChildren()
		for y=0,1,1/resolution do
			local amp = 1
			local size = (4+(sin(angle)*2))/(resolution/50)
			local xOffset = sin(twist)*50
			local x1 = (1+sin((a/amp)+angle))/size
			local x2 = (1+sin((a/amp)+angle+90))/size
			local x3 = (1+sin((a/amp)+angle+90*2))/size
			local x4 = (1+sin((a/amp)+angle+90*3))/size
			if x1<x2 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x1-x2)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x1/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side1Color.r-delimiter,Side1Color.g-delimiter,Side1Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			if x2<x3 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x2-x3)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x2/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side2Color.r-delimiter,Side2Color.g-delimiter,Side2Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			if x3<x4 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x3-x4)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x3/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.2,1,0)
				local color = Color3.new(Side3Color.r-delimiter,Side3Color.g-delimiter,Side3Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color				
				Frame.Parent = GUI
			end
			if x4<x1 then
				local Frame = Instance.new("Frame")
				Frame.Size = UDim2.new(math.abs(x4-x1)/4,0,1/resolution,0)
				Frame.Position = UDim2.new((x4/4)+0.4,xOffset,y,0)
				Frame.ZIndex = 2
				local delimiter = map(Frame.Size.X.Scale,0,0.03,1,0)
				local color = Color3.new(Side4Color.r-delimiter,Side4Color.g-delimiter,Side4Color.b-delimiter)
				Frame.BackgroundColor3 = color
				Frame.BorderColor3 = color
				Frame.Parent = GUI
			end
			a=a+0.001
			angle=angle+sin(a)/7
			twist = twist + 0.1
			if angle>360 then
				angle = 0
			end
		end
		
	end
	local dt = 0
	coroutine.resume(coroutine.create(function()
		while stop == false do
			generateTwist(dt)
			dt = dt + 1/resolution
			HB:wait()
		end
		GUI:ClearAllChildren()
	end))
end

return twister
