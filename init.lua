minetest.register_privilege("teamskin", {
	description = "Player can set the team-skin.",
	give_to_singleplayer= false,
})

minetest.register_chatcommand("setskin", {
	params = "<player> <team>",
	description = "set the skin of the player given",
	privs = { teamskin=true },
	func = function(name, param)
		local first_param_end, second_param_start = param:find(" +")
		if second_param_start == nil then 
			minetest.chat_send_player(name, "invalid Usage of /setskin!")
			return 
		end
		second_param_start = second_param_start+1
		playername = param:sub(0, first_param_end-1)
		team = param:sub(second_param_start, #param)
		minetest.chat_send_player(name, "set the team_"..team..
						" skin for player "..playername)
		local player = minetest.get_player_by_name(playername)
		if player == nil then
			minetest.chat_send_player(name, "don't know player "..playername)
			return
		end
		
		player:set_properties({
			textures = {"team_"..team..".png"},
		})

	end,
})
