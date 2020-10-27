local raster = {}

local pi = math.pi
local HB = game:GetService("RunService").Heartbeat
local sin = math.sin

local function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end

local function createRaster(Color,resolution)
	local Frame = Instance.new("Frame")
	Frame.Position = UDim2.new(0,0,0,0)
	Frame.Size = UDim2.new(0,0,1,0)
	Frame.BackgroundTransparency = 1
	local step = 1/resolution
	for x=0,1,step do
		local pColor = Instance.new("Frame")
		pColor.Position = UDim2.new(x,0,0,-36)
		pColor.Size = UDim2.new(step,0,1,36)
		local delimiter = map(x,0,1,0,pi)
		local t = delimiter
		delimiter = sin(t)
		pColor.BackgroundColor3 = Color3.new(Color.r+delimiter,Color.g+delimiter,Color.b+delimiter)
		pColor.BorderSizePixel = 0
		pColor.Parent = Frame
	end
	return Frame
end

local stop = false

raster.Play = function(GUI,resolution,Color)
	local step = 1/resolution
	local rasters = {}
	local rastersZ = {}
	local rasterBase = {}
	for x=-1,1,step do
		for z=0,math.floor(resolution/4) do
			local bar = createRaster(Color,resolution/2)
			bar.Position = UDim2.new(x,0,0,0)
			bar.ZIndex = map(z,0,math.floor(resolution/2),resolution,math.floor(resolution/5))
			table.insert(rasters,bar)
			table.insert(rastersZ,map(z,0,math.floor(resolution/2),step/2,step/5))
			table.insert(rasterBase,bar.Position)
			bar.Size = UDim2.new(rastersZ[#rastersZ],0,1,0)
			bar.Parent = GUI
		end
	end
	coroutine.resume(coroutine.create(function()
		local dt = 0
		while stop == false do
			dt = dt + 0.1
			local a = dt
			for i,raster in pairs(rasters) do
				local z = rastersZ[i]
				local sinVal = sin(a)*(z)
				raster.Position = (rasterBase[i]+UDim2.new(0.5+sinVal,0,0,0))+UDim2.new(sin(dt/4)/10)
				a = a + 0.1
			end
			HB:wait()
		end
		GUI:ClearAllChildren()
	end))
end

raster.Stop = function()
	stop = true
	delay(1,function()
		stop = false
	end)
end

return raster
