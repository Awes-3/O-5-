local module = {}
local cam
local screen
local offset = 0
_G.zGL_Shade = false -- For testing/debugging



---------------:[[zGL.init]]:-------------
--	Description:						--
--			Initalizes zGL. Must call	--
--		before using zGL functions!		--
------------------------------------------
function module.init(customScreen)
	if customScreen then
		screen = customScreen
	else
		screen = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
		screen.Name = "zGL_screen"
	end
	repeat wait() until screen.AbsoluteSize.x > 0
	cam = game.Workspace.CurrentCamera
end


-----------:[[zGL.project]]:----------
--	Description:					--
--			Projects 3D vertice		--
--		to absolute 2D position 	--
--	Input:							--
--		Vector3(3D point)			--
--	Output:							--
--		Vector3(2D point + depth)	--
--		Number(Clipping plane)		--
--------------------------------------
function module.project(point, camera)
	local resolution = screen.AbsoluteSize
	local point = (camera and camera.CFrame or cam.CoordinateFrame):inverse() * point
	local z = resolution.y/2/math.tan(math.rad((camera and camera.FoV or cam.FieldOfView)/2))
	local x = -(z * point.x)/point.z
	local y = (z * point.y)/point.z
	return Vector3.new(x, y, point.z) + Vector3.new(resolution.x/2, resolution.y/2, 0), z
end

------------:[[zGL.render]]:----------
--	Description:					--
--			Renders scene with zGL	--
--		objects						--
--	Input:							--
--		table(Scene)				--
--		~zGL_Camera(Camera)			--
--------------------------------------
function module.render(scene, camera)
	local pos2D = {}
	local visible = 0
	
	for num, obj in pairs(scene.Objects) do
		obj:project(camera)
		if obj.render then
			table.insert(pos2D, obj)
		end
	end
	table.sort(pos2D, function(a, b) return a.Depth < b.Depth end)
	local zIndex = 0
	
	for num, obj in pairs(pos2D) do
		local uis = {}
		for num=1, obj.Surfaces do
			zIndex = zIndex + 1
			uis[num] = scene.UIList[zIndex]
		end
		obj:render(unpack(uis))
	end
	offset = offset + 0.005
	if offset > 1 then
		offset = 0
	end
end

----------:[[zGL.newScene]]:---------
--	Description:					--
--			Creates new 3D scene	--
--	Input:							--
--		~UserData(ScreenGui)			--
--	Output:							--
--		UserData(zGL_Scene)			--
--------------------------------------
function module.newScene(screenGui)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					Screen = screenGui or screen;
					UIList = {};
					Objects = {};
				}
	
	function prop:insert(obj)
		if type(obj) == "userdata" and obj.Type and obj.Type:match("^zGL") then
			table.insert(self.Objects, obj)
			obj.Scene = self
			for n=1,obj.Surfaces do
				local ui = Instance.new("ImageLabel")
				ui.Visible = false
				ui.Parent = self.Screen
				ui.BorderSizePixel = 0
				table.insert(self.UIList, ui)
			end
			if obj.loadChildren then
				obj:loadChildren()
			end
		else
			error("[zGL] scene.insert: Object must be a zGL object")
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end

----------:[[zGL.newCamera]]:---------
--	Description:					--
--			Creates custom camera	--
--	Input:							--
--		CFrame(Camera's CFrame)		--
--	Output:							--
--		UserData(zGL_damera)		--
--------------------------------------
function module.newCamera(cframe, fov)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					CFrame = cframe;
					FoV = fov or cam.FieldOfView;
					Type = "zGL_camera";
				}
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end

---------:[[zGL.newPoint]]:-------
--	Description:				--
--			Creates new 3D GUI	--
--		point					--
--	Input:						--
--		Vector3(3D point)		--
--		~Color3(Color)			--
--	Output:						--
--		UserData(zGL_drawable)	--
----------------------------------
function module.newPoint(point, color)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					Type = "zGL_point";
					Vertices = {point};
					Surfaces = 1; -- I know, I know, but I need UI object for point as well..
					Scale = Vector2.new(100, 100);
					Pos2D = Vector3.new(0, 0, 0);
					Depth = 0;
					Color = color or Color3.new(1, 1, 1);
					BgTransparency = 0;
					Image = "";
					Visible = false;
					Rotation = 0;
				}
	
	function prop:project(camera)
		self.Pos2D = module.project(self.Vertices[1], camera)
		self.Depth = self.Pos2D.z
		self.Visible = (self.Pos2D.z < 0)
	end
	
	function prop:render(ui)
		ui.Visible = self.Visible
		if self.Visible then
			ui.BackgroundTransparency = self.BackgroundTransparency
			ui.Image = self.Image
			ui.Rotation = self.Rotation;
			ui.Size = UDim2.new(0, self.Scale.x/self.Position2D.z, 0, self.Scale.y/self.Position2D.z)
			ui.Position = UDim2.new(0, self.Position2D.x-self.GUI.Size.X.Offset/2, 0, self.Position2D.y-self.GUI.Size.Y.Offset/2)
			ui.BackgroundColor3 = self.Color
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end

---------:[[zGL.newLine]]:-------
--	Description:				--
--			Creates new 3D GUI	--
--		line					--
--	Input:						--
--		Vector3(3D point A)		--
--		Vector3(3D point B)		--
--		~Color3(Color)			--
--	Output:						--
--		UserData(zGL_Drawable)	--
----------------------------------
function module.newLine(pA, pB, color)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local gui = Instance.new("Frame")
	local prop = {
					Type = "zGL_line";
					Vertices = {pA, pB};
					Surfaces = 1; -- Still ilogical, but let's flow with it.
					GUI = gui;
					Scale = Vector2.new(20, 100);
					Pos2DA = Vector3.new(0, 0, 0);
					Pos2DB = Vector3.new(0, 0, 0);
					Depth = 0;
					Visible = true;
					Image = "";
					BackgroundTransparency = 0;
					Color = color or Color3.new(1, 1, 1);
				}
	
	function prop:project(camera)
		self.Pos2DA = module.project(self.Vertices[1], camera)
		self.Pos2DB = module.project(self.Vertices[2], camera)
		self.Depth = math.max(self.Pos2DA.z, self.Pos2DB.z)
		self.Visible = (self.Position2DA.z < 0) and (self.Position2DB.z < 0)
		-- To-do: Add clamp, if one vertice is visible
	end
	
	function prop:render(ui)
		ui.Visible = self.Visible
		if self.Visible then
			local off = Vector2.new(self.Position2DB.x, self.Position2DB.y) - Vector2.new(self.Position2DA.x, self.Position2DA.y)
			ui.Size = UDim2.new(0, off.magnitude, 0, self.Scale.y/self.Depth);
			local s = Vector2.new(self.GUI.Size.X.Offset, self.GUI.Size.Y.Offset)
			ui.Position = UDim2.new(0, (self.Position2DA.x-s.x/2)+off.x/2, 0, (self.Position2DA.y-s.y/2)+off.y/2)
			ui.Rotation = math.deg(math.atan2(off.y, off.x))
			ui.Image = self.Image
			ui.BackgroundTransparency = self.BackgroundTransparency;
			ui.BackgroundColor3 = self.Color;
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end


----------:[[zGL.newTriangle]]:-------
--	Description:					--
--			Creates a new 3D GUI	--
--		triangle					--
--	Input:							--
--		Vector3(Point A)			--
--		Vector3(Point B)			--
--		Vector3(Point C)			--
--		~Color3(Color)				--
--	Output:							--
--		UserData(zGL_Drawable)		--
--------------------------------------
function module.newTriangle(A, B, C, color)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)	
	
	local prop = {
					Type = "zGL_triangle";
					Vertices = {A, B, C};
					Surfaces = 2;
					Scale = Vector2.new(100, 100);
					Pos2DA = Vector3.new(0, 0, 0);
					Pos2DB = Vector3.new(0, 0, 0);
					Pos2DC = Vector3.new(0, 0, 0);
					Depth = 0;
					Visible = false;
					Color = color or Color3.new(1, 1, 1);
					Image1 = "http://www.roblox.com/asset/?id=190752599";
					Image2 = "http://www.roblox.com/asset/?id=190752612";
					BackgroundTransparency = 1;
				}
	
	function prop:project(camera)
		local clipPlane
		self.Pos2DA, clipPlane = module.project(self.Vertices[1], camera)
		self.Pos2DB = module.project(self.Vertices[2], camera)
		self.Pos2DC = module.project(self.Vertices[3], camera)
		if not self.CustomDepth then
			self.Depth = (self.Pos2DA.z + self.Pos2DB.z + self.Pos2DC.z) / 3
		end
			
		if self.Pos2DA.z > 0 and self.Pos2DB.z > 0 and self.Pos2DC.z > 0 then
			self.Visible = false
		else
			self.Visible = true
			if self.Pos2DA.z > 0 then
				if self.Pos2DB.z < 0 then
					self.Pos2DA = clampVertex(self.Pos2DA, self.Pos2DB, clipPlane)
				else
					self.Pos2DA = clampVertex(self.Pos2DA, self.Pos2DC, clipPlane)
				end
			end
			if self.Pos2DB.z > 0 then
				if self.Pos2DA.z < 0 then
					self.Pos2DB = clampVertex(self.Pos2DB, self.Pos2DA, clipPlane)
				else
					self.Pos2DB = clampVertex(self.Pos2DB, self.Pos2DC, clipPlane)
				end
			end
			if self.Pos2DC.z > 0 then
				if self.Pos2DA.z < 0 then
					self.Pos2DC = clampVertex(self.Pos2DC, self.Pos2DA, clipPlane)
				else
					self.Pos2DC = clampVertex(self.Pos2DC, self.Pos2DB, clipPlane)
				end
			end
		end 
	end
	
	function prop:render(uiA, uiB)
		uiA.Visible = self.Visible;
		uiB.Visible = self.Visible;
		if self.Visible then			
			local A = Vector2.new(self.Pos2DA.x,self.Pos2DA.y)
			local B = Vector2.new(self.Pos2DB.x,self.Pos2DB.y)
			local C = Vector2.new(self.Pos2DC.x,self.Pos2DC.y)
			local u = self.Pos2DB - self.Pos2DA
			local v = self.Pos2DC - self.Pos2DA
			local n = Vector3.new(u.y*v.z - u.z*v.y, u.z*v.x - u.x*v.z, u.x*v.y - u.y*v.x).unit
			
			local a, b, len, len2
			if (B-C).magnitude > math.max((A-B).magnitude, (A-C).magnitude) then
				a = (C-B).unit
				b = (A-B).unit
				self.Pos2D = A
				len = (C-B).magnitude
				len2 = (A-B).magnitude
			elseif (A-C).magnitude > (A-B).magnitude then
				a = (A-C).unit
				b = (B-C).unit
				self.Pos2D = B
				len = (A-C).magnitude
				len2 = (B-C).magnitude
			else
				a = (B-A).unit
				b = (C-A).unit
				self.Pos2D = C
				len = (B-A).magnitude
				len2 = (C-A).magnitude
			end
			local p = 2
			local ang = math.acos((a.x*b.x + a.y*b.y) / (math.sqrt(a.x*a.x + a.y*a.y) * math.sqrt(b.x*b.x + b.y*b.y)))
			local x,y = math.cos(ang)*len2, math.sin(ang)*len2
			local v = (a*x-b*len2)
			local rot = -math.atan2(v.y, v.x)
			if n.z > 0 then
				uiA.Size = UDim2.new(0, -(len-x)-p, 0, y+p)
				uiB.Size = UDim2.new(0, x+p, 0, y+p)
			else
				uiA.Size = UDim2.new(0, -(x)-p, 0, y+p)
				uiB.Size = UDim2.new(0, (len-x)+p, 0, y+p)
			end
			uiA.Rotation = -math.deg(rot)-90
			uiB.Rotation = uiA.Rotation
			local s1 = Vector2.new(uiA.Size.X.Offset, uiA.Size.Y.Offset)
			local s2 = Vector2.new(uiB.Size.X.Offset, uiB.Size.Y.Offset)
			uiA.Position = UDim2.new(0, (self.Pos2D.x-s1.x/2)+math.cos(math.rad(uiA.Rotation))*(s1.x/2+0.5)+v.x/2, 0, (self.Pos2D.y-s1.y/2)+math.sin(math.rad(uiA.Rotation))*(s1.x/2+0.5)+v.y/2)
			uiB.Position = UDim2.new(0, (self.Pos2D.x-s2.x/2)+math.cos(math.rad(uiA.Rotation))*(s2.x/2-0.5)+v.x/2, 0, (self.Pos2D.y-s2.y/2)+math.sin(math.rad(uiA.Rotation))*(s2.x/2-0.5)+v.y/2)
			uiA.Image = self.Image1
			uiB.Image = self.Image2
			uiA.ZIndex = 5
			uiB.ZIndex = 5
			uiA.BackgroundTransparency = self.BackgroundTransparency
			uiB.BackgroundTransparency = self.BackgroundTransparency
			if _G.zGL_Shade then
				local dot = n:Dot(game.Lighting:GetSunDirection())
				local r, g, b = self.Color.r, self.Color.g, self.Color.b
				uiA.ImageColor3 = Color3.new(r*0.7+dot*r*0.3, b*0.7+g*dot*0.3, b*0.7+b*dot*0.3)
				uiB.ImageColor3 = uiA.ImageColor3
			else
				local Color = Color3.fromHSV(offset,1,1)
				uiA.ImageColor3 = Color
				uiB.ImageColor3 = Color
			end
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end


---------:[[zGL.newQuad]]:--------
--	Description:				--
--			Creates new 3D GUI	--
--		quad					--
--	Input:						--
--		Vector3(Point A)		--
--		Vector3(Point B)		--
--		Vector3(Point C)		--
--		Vector3(Point D)		--
--		~Color3(Color)			--
--	Output:						--
--		UserData(zGL_quad)		--
----------------------------------
function module.newQuad(A, B, C, D, color)
	color = color or Color3.new(1, 1, 1)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					Type = "zGL_quad";
					Vertices = {A, B, C, D};
					Surfaces = 0; -- You know what?... Screw this..
					triangle1 = module.newTriangle(A,B,D, color);
					triangle2 = module.newTriangle(D,C,B, color);
					Scale = Vector2.new(100, 100);
					Position2D = Vector3.new(0, 0, 0);
					Depth = 0;
					Visible = false;
					Scene = nil; -- Will be set after creation
				}
	prop.triangle1.CustomDepth = true
	prop.triangle2.CustomDepth = true

	function prop:loadChildren()
		self.Scene:insert(self.triangle1)
		self.Scene:insert(self.triangle2)
	end
	
	function prop:project(camera)
		local a, b, c, d = module.project(self.Vertices[1], camera), module.project(self.Vertices[2], camera), module.project(self.Vertices[3], camera),
								module.project(self.Vertices[4], camera)
		local depth = (a.z + b.z + c.z + d.z) / 4
		self.triangle1.Vertices[1] = self.Vertices[1]	
		self.triangle1.Vertices[2] = self.Vertices[2]
		self.triangle1.Vertices[3] = self.Vertices[4]
		self.triangle1.Depth = depth
		
		self.triangle2.Vertices[1] = self.Vertices[4]
		self.triangle2.Vertices[2] = self.Vertices[2]
		self.triangle2.Vertices[3] = self.Vertices[3]
		self.triangle2.Depth = depth
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end


-------:[[zGL.newTriangleStrip]]:-----
--	Description:					--
--			Creates new 3D GUI		--
--		triangles in a strip		--
--	Input:							--
--		Table(Strip vertices)		--
--		~Color3(Color)				--
--	Output:							--
--		UserData(zGL_triangleStrip)	--
--------------------------------------
function module.newTriangleStrip(v, color)
	color = color or Color3.new(1, 1, 1)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					Type = "zGL_triangleStrip";
					Vertices = v;
					Surfaces = 0;
					Triangles = {};
					Scale = Vector2.new(100, 100);
					Position2D = Vector3.new(0, 0, 0);
					Depth = 0;
					Visible = false;
					Scene = nil; -- Will be set after creation
					Static = true; -- Temporar workaround to updating vertices
				}
	for num=1,#v-2 do
		table.insert(prop.Triangles, module.newTriangle(prop.Vertices[num], prop.Vertices[num+1], prop.Vertices[num+2], color))
	end

	function prop:loadChildren()
		for num, triangle in pairs(self.Triangles) do
			self.Scene:insert(triangle)
		end
	end
	
	function prop:project(camera)
		if not self.Static then
			for num, obj in pairs(self.Triangles) do
				obj.Vertices[1] = self.Vertices[num]
				obj.Vertices[2] = self.Vertices[num+1]
				obj.Vertices[3] = self.Vertices[num+2] 
			end
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end

--------:[[zGL.newTriangleFan]]:------
--	Description:					--
--			Creates new 3D GUI		--
--		triangles in a fan			--
--	Input:							--
--		Table(Fan vertices)			--
--		~Color3(Color)				--
--	Output:							--
--		UserData(zGL_triangleFan)	--
--------------------------------------
function module.newTriangleFan(v, color)
	color = color or Color3.new(1, 1, 1)
	local newGuy = newproxy(true)
	local mt = getmetatable(newGuy)
	local prop = {
					Type = "zGL_triangleFan";
					Vertices = v;
					Surfaces = 0;
					Triangles = {};
					Scale = Vector2.new(100, 100);
					Position2D = Vector3.new(0, 0, 0);
					Depth = 0;
					Visible = false;
					Scene = nil; -- Will be set after creation
					Static = true; -- Temporar workaround to updating vertices
				}
	for num=1,#v-2 do
		table.insert(prop.Triangles, module.newTriangle(prop.Vertices[1], prop.Vertices[num+1], prop.Vertices[num+2], color))
	end

	function prop:loadChildren()
		for num, triangle in pairs(self.Triangles) do
			self.Scene:insert(triangle)
		end
	end
	
	function prop:project(camera)
		if not self.Static then
			for num, obj in pairs(self.Triangles) do
				obj.Vertices[1] = self.Vertices[1]
				obj.Vertices[2] = self.Vertices[num+1]
				obj.Vertices[3] = self.Vertices[num+2] 
			end
		end
	end
	
	mt.__index = prop
	mt.__newindex = prop
	return newGuy
end


function clampVertex(v1, v2, clip)
	local v = (Vector2.new(v2.x, v2.y) - Vector2.new(v1.x, v1.y)).unit * ((math.abs(v1.z)*(v2-v1).magnitude)/math.abs(v1.z)+math.abs(v2.z))  
	return Vector3.new(v.x, v.y, -clip)
end
	
function Dot2D(a, b)
	return a.x*b.x+a.y*b.y
end

return module






























