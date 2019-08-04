-- New Dominating Mod By Factis699 --
function posInArea(posx, posy, x1, y1, x2, y2)
	return posx >= x1 and posy >= y1 and posx <= x2 and posy <= y2
end

function objectDestroyInArea(x1, y1, x2, y2)
	for n, w in ipairs(object(0, 'table')) do
		local x = object(w, 'tilex')
		local y = object(w, 'tiley')
		if x >= x1 and y >= y1 and x <= x2 and y <= y2 then
			parse('killobject '.. w)
		end
	end
end

function a()
	local d = {}
	for id = 1, 32 do
		d[id] = 0
	end
	return d
end

function pouse(id, what)
	if what then
		wpns[id] = playerweapons(id)
		mwpn[id] = player(id, 'weapontype')
		parse('strip '.. id ..' 0')
	elseif not what then
		for n, w in ipairs(wpns[id]) do
			parse('equip '.. id ..' '.. w)
		end
		parse('setweapon '.. id ..' '.. mwpn[id])
	end
end

function menuOC(id)
	if actived[id] == 0 then
		imgid[id] = image('gfx/ndominate/hud.png', 320, 240, 2, id)
		parse('sv_sound2 '.. id ..' "wpn_moveselect.wav"')
		actived[id] = 1
		pouse(id, true)
		for g = 1, 16 do
			if xy[g][id] ~= nil and xy[g][id] ~= 0 then
				img[g][id] = image('gfx/ndominate/b'.. xy[g][id] ..'.png', pos[g][1] + 16, pos[g][2] + 15, 2, id)
			end
		end
	else
		freeimage(imgid[id])
		parse('sv_sound2 '.. id ..' "wpn_select.wav"')
		actived[id] = 0
		pouse(id, false)
		for f = 1, 16 do
			if img[f][id] ~= 0 then
				freeimage(img[f][id])
			end
		end
	end
end


function building(id, type, x, y)
	parse('spawnobject '.. type ..' '.. x ..' '.. y ..' 0 0 '.. player(id, 'team') ..' '.. id)
end	

function open_menu(id)
	menu(id, 'Select Building, Wall I|1000, Wall II|2000, Wall III|3000, Turret|5000, Dispenser|5000, Supply|5000, Nothing')
end

xy = {}
img = {}
for d = 1, 16 do
	xy[d] = a()
	img[d] = a()
end
imgid = a()
actived = a()
closebutton = {385, 145, 398, 157}
pos = {}
pos[1] = {240, 162, 270, 190} pos[2] = {272, 162, 302, 190} pos[3] = {336, 162, 365, 190} pos[4] = {368, 162, 397, 190}
pos[5] = {240, 194, 270, 222} pos[6] = {272, 194, 302, 222} pos[7] = {336, 194, 365, 222} pos[8] = {368, 194, 397, 222}
pos[9] = {240, 258, 270, 286} pos[10] = {272, 258, 302, 287} pos[11] = {336, 258, 365, 286} pos[12] = {368, 258, 397, 286}
pos[13] = {240, 290, 270, 318} pos[14] = {272, 290, 302, 318} pos[15] = {336, 290, 365, 317} pos[16] = {368, 290, 397, 318}
wpns = {}
mwpn = a()
lastselect = a()

for id = 1, 32 do
	wpns[id] = {}
end

addhook('dominate', 'dominate_hook')
addhook('serveraction', 'serveraction_hook')
addhook('attack', 'attack_hook')
addhook('clientdata', 'clientdata_hook')
addhook('menu', 'menu_hook')
addhook('endround', 'endround_hook')
addhook('minute', 'minute_hook')

function dominate_hook(id, team, x, y)
	objectDestroyInArea(x - 2, y - 2, x + 2, y + 2)
	if xy[1][id] ~= 0 and xy[1][id] ~= nil then
		building(id, xy[1][id], x - 2, y - 2)
	end
	if xy[2][id] ~= 0 and xy[2][id] ~= nil then
		building(id, xy[2][id], x - 1, y - 2)
	end
	if xy[3][id] ~= 0 and xy[3][id] ~= nil then
		building(id, xy[3][id], x + 1, y - 2)
	end
	if xy[4][id] ~= 0 and xy[4][id] ~= nil then
		building(id, xy[4][id], x + 2, y - 2)
	end
	if xy[5][id] ~= 0 and xy[5][id] ~= nil then
		building(id, xy[5][id], x - 2, y - 1)
	end
	if xy[6][id] ~= 0 and xy[6][id] ~= nil then
		building(id, xy[6][id], x - 1, y - 1)
	end
	if xy[7][id] ~= 0 and xy[7][id] ~= nil then
		building(id, xy[7][id], x + 1, y - 1)
	end
	if xy[8][id] ~= 0 and xy[8][id] ~= nil then
		building(id, xy[8][id], x + 2, y - 1)	
	end
	if xy[9][id] ~= 0 and xy[9][id] ~= nil then
		building(id, xy[9][id], x - 2, y + 1)
	end
	if xy[10][id] ~= 0 and xy[10][id] ~= nil then
		building(id, xy[10][id], x - 1, y + 1)
	end
	if xy[11][id] ~= 0 and xy[11][id] ~= nil then
		building(id, xy[11][id], x + 1, y + 1)
	end
	if xy[12][id] ~= 0 and xy[12][id] ~= nil then
		building(id, xy[12][id], x + 2, y + 1)
	end
	if xy[13][id] ~= 0 and xy[13][id] ~= nil then
		building(id, xy[13][id], x - 2, y + 2)
	end
	if xy[14][id] ~= 0 and xy[14][id] ~= nil then
		building(id, xy[14][id], x - 1, y + 2)
	end
	if xy[15][id] ~= 0 and xy[15][id] ~= nil then
		building(id, xy[15][id], x + 1, y + 2)
	end
	if xy[16][id] ~= 0 and xy[16][id] ~= nil then
		building(id, xy[16][id], x + 2, y + 2)
	end
	building(id, 6, x, y - 2)
	building(id, 6, x, y - 1)
	building(id, 6, x, y + 1)
	building(id, 6, x, y + 2)
	building(id, 6, x - 2, y)
	building(id, 6, x - 1, y)
	building(id, 6, x + 1, y)
	building(id, 6, x + 2, y)
end

function serveraction_hook(id, action)
	if action == 1 then
		menuOC(id)
	end
end

function clientdata_hook(id, mode, data1, data2)
	local x = data1
	local y = data2
	if actived[id] == 1 then
		if posInArea(x, y, closebutton[1], closebutton[2], closebutton[3], closebutton[4]) then
			menuOC(id)
		else
			for n, w in ipairs(pos) do
				if posInArea(x, y, w[1], w[2], w[3], w[4]) then
					lastselect[id] = n 
					menuOC(id)
					timer(20, 'open_menu', id)
					break
				end
			end
		end
	end
end

function attack_hook(id)
	reqcld(id, 0)
end

function menu_hook(id, title, button)
	if title == 'Select Building' then
		local c = string.char(169)
		if button == 1 then
			if player(id, 'money') >= 1000 then
				xy[lastselect[id]][id] = 3
				parse('setmoney '.. id ..' '.. player(id, 'money') - 1000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 2 then
			if player(id, 'money') >= 2000 then
				xy[lastselect[id]][id] = 4
				parse('setmoney '.. id ..' '.. player(id, 'money') - 2000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 3 then
			if player(id, 'money') >= 3000 then
				xy[lastselect[id]][id] = 5
				parse('setmoney '.. id ..' '.. player(id, 'money') - 3000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 4 then
			if player(id, 'money') >= 5000 then
				xy[lastselect[id]][id] = 8
				parse('setmoney '.. id ..' '.. player(id, 'money') - 5000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 5 then
			if player(id, 'money') >= 5000 then
				xy[lastselect[id]][id] = 7
				parse('setmoney '.. id ..' '.. player(id, 'money') - 5000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 6 then
			if player(id, 'money') >= 5000 then
				xy[lastselect[id]][id] = 9
				parse('setmoney '.. id ..' '.. player(id, 'money') - 5000)
			else
				msg2(id, c ..'255000000Not Enough Money!')
			end
		elseif button == 7 then
			xy[lastselect[id]][id] = 0
		end
		menuOC(id)
	end
end

function endround_hook(mode)
	for id = 1, 32 do
		if actived[id] == 1 then
			menuOC(id)
		end
	end
end

function minute_hook()
	local c = string.char(169)
	msg(c ..'000255000Press F2 To Edit Your Base! Press F2 Again To Close Base Edit!')
end