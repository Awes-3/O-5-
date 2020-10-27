local swirl = {}

local swirlParts = {}
local angles = {}
local swirlDT = {}

math.randomseed(tick())

local sin,cos = math.sin,math.cos
local HB = game:GetService("RunService").Heartbeat

local function map(value, istart, istop, ostart, ostop)
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
end


swirl.addPart = function(part)
	table.insert(swirlParts,part)
	table.insert(angles,map(part.Position.X.Scale,0,1,0,180))
	table.insert(swirlDT,0)
	angles[#angles] = angles[#angles] + math.random(-100,100)
	local sinVal = ((1.3+sin(angles[#angles]))/2.5)-0.05
	part.Position = UDim2.new(sinVal,0,part.Position.Y.Scale,0)
	local z = (1.3+cos(angles[#angles]+math.rad(25)))/2.5
	part.Size = UDim2.new(z/5,0,z/5,0)
	if part.Size.X.Scale <= 0.1 then
		part.ZIndex = 1
	end
	if part.Size.X.Scale >= 0.1 then
		part.ZIndex = 2
	end
end

local amp = 0.05

local cor = coroutine.create(function()
	while HB:wait() do
		for i,part in pairs(swirlParts) do
			if part == nil then table.remove(swirlParts,i) table.remove(angles,i) table.remove(swirlDT,i) else
				angles[i] = angles[i] + amp
				local sinVal = ((1.3+sin(angles[i]))/2.5)-0.05
				if sinVal >= 0.8 then
					part.ZIndex = 1
				end
				if sinVal <= 0.2 then
					part.ZIndex = 2
				end
				part.Position = UDim2.new(sinVal,0,part.Position.Y.Scale,0)
				local z = (1.3+cos(angles[i]+math.rad(25)))/2.5
				part.Size = UDim2.new(z/5,0,z/5,0)
			end
		end
	end
end)

swirl.Play = function()
	coroutine.resume(cor)
end

swirl.Stop = function()
	coroutine.yield(cor)
end

return swirl
