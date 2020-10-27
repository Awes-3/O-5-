local plasma = {}

local HB = game:GetService("RunService").Heartbeat
local sin,pi,cos,sqrt = math.sin,math.pi,math.cos,math.sqrt
local resolution = 1
local function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end
local Z = 10
local twoPi = pi*2
local stop = false


plasma.initPlasma = function(guiObject,res)
	resolution = res
	local units = {}
	local buffer = {}
	local inc = 1/resolution
	for x=0,1,inc do
		local unitSubTable = {}
		--local subBuffer = {}
		for y=0,1,inc do
			local newFrame = Instance.new("Frame")
			newFrame.Name = "PlasmaFrame"
			newFrame.BorderSizePixel = 0
			newFrame.Size = UDim2.new(inc,1,inc,1) --thanks for the 1 pixel offset roblox
			newFrame.Position = UDim2.new(x,0,y,0)
			newFrame.Parent = guiObject
			newFrame.ZIndex = Z
			table.insert(units,newFrame)
			--table.insert(subBuffer,0)
		end
		--table.insert(buffer,subBuffer)
	end
	
	Z = Z + 1
	local cos_tab = {}
	local pnt = {0,0,0,0}
	
    local i = 0
	local inc = 0
	
	--unused blit-buffer below lolololo
	
	--[[local length = 10
    for i=0, length do
        cos_tab[i]=(cos(inc))
		inc = inc + 0.1
	end]]--
	--print(table.concat(cos_tab,"< "))

	--[[local function addCos()
		for y=1,#buffer do
			for x=1,#buffer[1] do
				local color = cos_tab[(pnt[1])%length]+cos_tab[pnt[2]%length]+cos_tab[pnt[3]%length]+cos_tab[pnt[4]%length]
				pnt[3] = pnt[3] + 1
				pnt[4] = pnt[4] + 1
				buffer[x][y] = color
			end
			pnt[1] = pnt[1] + 2
			pnt[2] = pnt[2] + 1
		end
	end]]--
	local trans = 1
	local a = 0
	local scale = Vector2.new(0.1,0.1)
	coroutine.resume(coroutine.create(function()
	while stop == false do
			local a2=a*2
			--local tab = {}
			for x=1,#units do
				local frame = units[x]
				if frame ~= nil then
				--[[local x2=absPos.X/15
				local y2=absPos.Y/10
				local v1,v2=256+192*(sin(sqrt(y2+a2))),sin(a-x2+y2)
				local r,g,b=cos(a2+absPos.X/v1+v2)+colorOffset.r,sin((absPos.X+absPos.Y)/v1*v2)+colorOffset.g,cos((absPos.X*v2-absPos.Y)/v1)+colorOffset.b
				frame.BackgroundColor3 = Color3.new(r,g,b)]]--
				local scaleVal = 1+((1+sin(a))/4)
				scale = Vector2.new(scaleVal,scaleVal)
				local v_coords = (frame.AbsolutePosition/resolution)/frame.AbsoluteSize
				local v = 0
				local c = v_coords * scale - scale/2
				v = v + sin(c.X+a)
				v = v + sin(c.Y+a)/2
				v = v + sin(c.X+c.Y+a)/2
				c = c + scale/2 * Vector2.new(sin(a/3),cos(a/2))
				v = v + sin(sqrt(c.X*c.X+c.Y*c.Y+1)+a)
				v = v/2
				local color = Color3.new(sin(pi*v),cos(pi*v),0)
				color = (Color3.new(color.r+1/2,color.g+1/2,color.b+1/2))
				frame.BackgroundColor3 = color
				--table.insert(tab,plasmaVal)
				end
			end
			a = a + 0.025
			HB:wait()
			--print("MAX: "..math.max(unpack(tab)).."\nMIN: "..math.min(unpack(tab)))
	end
	end))
	
end

plasma.initPlasmaSphere = function(guiObject,res)
	local r = 1
	resolution = res
	local units = {}
	local tbk = {}
	local buffer = {}
	local inc = 1/resolution
	for phi=0,twoPi,inc do
		local unitSubTable = {}
		--local subBuffer = {}
		for theta=0,twoPi,inc do
			local x = 0.4+map(r*sin(phi)*cos(theta),-0.086357379815342,1.000605397208,0,1)
			local y = 0.25+map(r*sin(phi)*sin(theta),-0.49645252164865,1.497207965404,0,1)
			local newFrame = Instance.new("Frame")
			newFrame.Name = "PlasmaFrame"
			newFrame.BorderSizePixel = 0
			newFrame.Size = UDim2.new(inc/2,1,inc/2,1) --thanks for the 1 pixel offset roblox
			newFrame.Position = UDim2.new(x,0,y,0)
			newFrame.Parent = guiObject
			newFrame.ZIndex = 3
			table.insert(unitSubTable,newFrame)
			--table.insert(subBuffer,0)
		end
		table.insert(units,unitSubTable)
	end
	
	Z = Z + 1
	local cos_tab = {}
	local pnt = {0,0,0,0}
	
    local i = 0
	local inc = 0
	
	--unused blit-buffer below lolololo
	
	--[[local length = 10
    for i=0, length do
        cos_tab[i]=(cos(inc))
		inc = inc + 0.1
	end]]--
	--print(table.concat(cos_tab,"< "))

	--[[local function addCos()
		for y=1,#buffer do
			for x=1,#buffer[1] do
				local color = cos_tab[(pnt[1])%length]+cos_tab[pnt[2]%length]+cos_tab[pnt[3]%length]+cos_tab[pnt[4]%length]
				pnt[3] = pnt[3] + 1
				pnt[4] = pnt[4] + 1
				buffer[x][y] = color
			end
			pnt[1] = pnt[1] + 2
			pnt[2] = pnt[2] + 1
		end
	end]]--
	local trans = 1
	local a = 0
	local scale = Vector2.new(0.1,0.1)
	wait(1.5)
	coroutine.resume(coroutine.create(function()
	while stop == false do
			local a2=a*2
			--local tab = {}
			for x=1,#units do
			for y=1, #units[x] do
				local frame = units[x][y]
				if frame ~= nil then
				--[[local x2=absPos.X/15
				local y2=absPos.Y/10
				local v1,v2=256+192*(sin(sqrt(y2+a2))),sin(a-x2+y2)
				local r,g,b=cos(a2+absPos.X/v1+v2)+colorOffset.r,sin((absPos.X+absPos.Y)/v1*v2)+colorOffset.g,cos((absPos.X*v2-absPos.Y)/v1)+colorOffset.b
				frame.BackgroundColor3 = Color3.new(r,g,b)]]--
				local scaleVal = 0.5+((1+sin(a))/10)
				scale = Vector2.new(scaleVal,scaleVal)
				local v_coords = Vector2.new(x,y)
				local v = 0
				local c = v_coords * scale - scale/2
				v = v + sin(c.X+a)
				v = v + sin(c.Y+a)/2
				v = v + sin(c.X+c.Y+a)/2
				c = c + scale/2 * Vector2.new(sin(a/3),cos(a/2))
				v = v + sin(sqrt(c.X*c.X+c.Y*c.Y+1)+a)
				v = v/2
				local color = Color3.new(sin(pi*v),cos(pi*v),0)
				color = (Color3.new(color.r+1/2,color.g+1/2,color.b+1/2))
				frame.BackgroundColor3 = color
				--table.insert(tab,plasmaVal)
				end
			end
			end
			a = a + 0.025
			HB:wait()
			--print("MAX: "..math.max(unpack(tab)).."\nMIN: "..math.min(unpack(tab)))
	end
	end))
	
end




plasma.playback = function()
	return
end

plasma.stop = function()
	stop = true
	wait(1)
	stop = false
end

return plasma
