local shade = {}

math.randomseed(tick())

local sin,cos = math.sin,math.cos
local HB = game:GetService("RunService").Heartbeat

shade.newShade = function(GUI)
	local Frame = Instance.new("Frame")
	Frame.BackgroundColor3 = GUI.BackgroundColor3
	Frame.Size = UDim2.new(0.1,0,0.1,0)
	Frame.Position = UDim2.new(math.random(1,80)/100,0,math.random(1,80)/100,0)
	Frame.BackgroundTransparency = 0.95
	Frame.BorderColor3 = Color3.fromRGB(36,118,142)
	Frame.BorderSizePixel = 10
	Frame.ZIndex = 100
	Frame.Parent = GUI
	Instance.new("UIAspectRatioConstraint",Frame)
	local a = 0
	local b = 0
	coroutine.resume(coroutine.create(function()
		local dt = 0
		while GUI ~= nil do
			a = sin(dt)
			b = 4
			local x = (1.1+cos(a*dt))/2.5
			local y = (1.1+sin(b*dt))/2.5
			Frame.Position = UDim2.new(x,0,y,0)
			local c = Frame:Clone()
			c.Parent = GUI
			--[[delay(1,function()
				c:Destroy()
			end)]]--
			HB:wait()
			dt = dt + 0.01
		end
	end))
end

return shade
