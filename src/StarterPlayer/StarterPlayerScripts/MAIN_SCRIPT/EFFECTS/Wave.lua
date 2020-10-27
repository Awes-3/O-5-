local wave = {}

local sin = math.sin
local HB = game:GetService("RunService").Heartbeat
local stop = false
local points = {}
local gui

wave.Play = function(GUI,resolution)
	gui = GUI
	local step = 1/resolution
	for x=0,1,step do
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(step,1,2,0)
		Frame.Position = UDim2.new(x,0,0,0)
		Frame.BackgroundTransparency = 1
		Frame.BackgroundColor3 = GUI.backgroundColor3
		Frame.ZIndex = 5
		Frame.BorderSizePixel = 0
		Frame.Parent = GUI
		table.insert(points,Frame)
	end
	local dt = 0
	local amp = 5
	for _,v in pairs(points) do
		coroutine.resume(coroutine.create(function()
			for i=1,0,-0.05 do
				v.BackgroundTransparency = i
				HB:wait()
			end
			v.BackgroundTransparency = 0
		end))
	end
	coroutine.resume(coroutine.create(function()
		while stop == false do
			local a = dt
			for _,frame in pairs(points) do
				a = a + sin(dt)/10
				frame.Position = UDim2.new(frame.Position.X.Scale,0,-1+((1+sin(a+dt))/amp),0)
			end
			dt = dt + 0.01
			HB:wait()
		end
	end))
end

wave.Stop = function()
	stop = true
	for _,v in pairs(points) do
		coroutine.resume(coroutine.create(function()
			for i=0,1,0.05 do
				v.BackgroundTransparency = i
				HB:wait()
			end
			v:Destroy()
		end))
	end
end

return wave
