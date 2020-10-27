local wave = {}

local picture = "rbxgameasset://Images/TwitterIMG"
local HB = game:GetService("RunService").Heartbeat
local sin = math.sin

wave.Play = function(GUI,resolution)
	local BaseText = Instance.new("TextLabel")
	BaseText.Position = UDim2.new(-0.05,0,1,0)
	BaseText.Size = UDim2.new(1.1,0,0.2,0)
	BaseText.Text = "@awesxome3 for more of my ROBLOX stuff"
	BaseText.TextColor3 = Color3.new(1,1,1)
	BaseText.TextTransparency = 1
	BaseText.TextScaled = true
	BaseText.TextXAlignment = Enum.TextXAlignment.Center
	BaseText.Font = Enum.Font.SciFi
	BaseText.BackgroundTransparency=1
	BaseText.ZIndex = 3
	BaseText.Parent = GUI
	local step = 1/resolution
	local points = {}
	local basePos = {}
	for x=0,1,step do
		local subPoint = {}
		local basePosSub = {}
		for y=0,1,step do
			local Fr = Instance.new("ImageLabel")
			Fr.Size = UDim2.new(step,1,step,1)
			Fr.Position = UDim2.new(x,0,y,0)
			Fr.Image = picture
			Fr.ImageTransparency = 1
			Fr.BackgroundTransparency = 1
			Fr.ImageRectSize = Vector2.new(1280*(step/3.2),1280*(step/3.2))
			Fr.ImageRectOffset = Vector2.new(Fr.ImageRectSize.X*(x*resolution),Fr.ImageRectSize.Y*(y*resolution))
			Fr.Parent = GUI
			table.insert(subPoint,Fr)
			table.insert(basePosSub,Fr.Position)
		end
		table.insert(points,subPoint)
		table.insert(basePos,basePosSub)
	end
	local inc = 0.1
	for x=1,#points do
		for y=1, #points[1] do
			coroutine.resume(coroutine.create(function()
				for i=1,0,-0.05 do
					local frame = points[x][y]
					frame.ImageTransparency = i
					BaseText.TextTransparency = i
					HB:wait()
				end
			end))
		end
	end
	coroutine.resume(coroutine.create(function()
		local dt = 0
		while true do
			local a = dt
			for x=1,#points do
				for y=1, #points[1] do
					local frame = points[x][y]
					local myPos = basePos[x][y]
					local sinVal = sin((x+y)+a)
					frame.Position = myPos + UDim2.new(sinVal/200,0,sinVal/200,0)
					a = a + inc
				end
			end
			dt = dt + inc
			HB:wait()
		end
	end))
end

return wave
