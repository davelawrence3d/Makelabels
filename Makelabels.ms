dirName = "P:\Projects\NHA\Sims\LIS_videos\Shiprock Data for 2 minute video"
	
if dirName != undefined do
(
	--Draw Center line
	pos = [0.0,0.0,0.0]
	E = 5 -- Extrude amount
	H = 50 -- height above grade
	FH = 100 --Font Height
	f = openfile (dirName + @"\" + "EPA_stations.dbf") 
	f = openfile (dirName + @"\" + "pole_loc.csv") 
	pole = readDelimitedString f ","; pos.x = readvalue f; pos.y = readvalue f; pos.z = readvalue f; rot = readvalue f;
	format "%\t%\t%\n" pos.x pos.y pos.z
	--change = pole as string
	print rot
	print H
	new_point = Sphere radius:E pos:pos
	new_point.wirecolor = color 255 255 255
	new_point.name = pole as string

	
	--Cylinder smooth:on heightsegs:1 capsegs:1 sides:18 height:H radius:(E/2) pos:pos
	
	new_text = Text Text:pole pos:pos
	rotate new_text (angleaxis 90 [1,0,0])
	rotate new_text (angleaxis rot [0,0,1])
	new_text.size = FH
	addmodifier new_text (Extrude ())
	new_text.modifiers[#Extrude].amount = E
	move new_text  [0,0,H]
	new_text.wirecolor = color 255 255 255
	new_text.name = pole as string

	new_text = Text Text:pole pos:pos
	rotate new_text (angleaxis 90 [1,0,0])
	rotate new_text (angleaxis rot [0,0,1])
	new_text.wirecolor = color 0 0 0
	new_text.size = FH
	addmodifier new_text (Extrude ())
	new_text.modifiers[#Extrude].amount = E/2
	move new_text  [0,0,H]
	addmodifier new_text (Shell ()) ui:on
	new_text.modifiers[#Shell].outerAmount = 2
	new_text.name = pole as string


	if f == undefined do
	(
		local fname
		MessageBox "Could not find pole_loc.csv. Please point locate the file"
		fname = getOpenFileName caption:"Locate pole_loc.csv" filename:"pole_loc.csv"
		if fname != undefined then 
			f = openFile fname
	)

	if f != undefined then
	(
		while (not eof f) do
		(
			-- read values from csv
			pole = readDelimitedString f ","; pos.x = readvalue f; pos.y = readvalue f; pos.z = readvalue f; rot = readvalue f;
			--format xyz values
			format "%\t%\t%\n" pos.x pos.y pos.z
			--change = pole as string
			
			new_point = Sphere radius:E pos:pos
			new_point.wirecolor = color 255 255 255
			new_point.name = pole as string
			
			new_text = Text Text:pole pos:pos
			rotate new_text (angleaxis 90 [1,0,0])
			rotate new_text (angleaxis rot [0,0,1])
			new_text.size = FH
			addmodifier new_text (Extrude ())
			new_text.modifiers[#Extrude].amount = E
			move new_text  [0,0,H]
			new_text.wirecolor = color 255 255 255
			new_text.name = pole as string

			new_text = Text Text:pole pos:pos
			rotate new_text (angleaxis 90 [1,0,0])
			rotate new_text (angleaxis rot [0,0,1])
			new_text.wirecolor = color 0 0 0
			new_text.size = FH
			addmodifier new_text (Extrude ())
			new_text.modifiers[#Extrude].amount = E/2
			move new_text  [0,0,H]
			addmodifier new_text (Shell ()) ui:on
			new_text.modifiers[#Shell].outerAmount = 2
			new_text.name = pole as string



		)	
		--updateShape s --update the shape
		close f

	)

)
