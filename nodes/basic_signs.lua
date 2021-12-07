
-- Register wrench support for basic_signs

local S = wrench.translator

local function get_sign_description(pos, meta, node)
	local desc = minetest.registered_nodes[node.name].description
	local text = meta:get_string("text")
	if #text > 32 then
		text = text:sub(1, 24).."..."
	end
	return S("@1 with text \"@2\"", desc, text)
end

local function register_all(name, def)
	wrench.register_node(name, def)
	name = name:gsub("_wall", "")
	wrench.register_node(name.."_hanging", def)
	wrench.register_node(name.."_onpole", def)
	wrench.register_node(name.."_onpole_horiz", def)
	wrench.register_node(name.."_yard", def)
end

local sign_def = {
	metas = {
		text = wrench.META_TYPE_STRING,
		glow = wrench.META_TYPE_STRING,
		widefont = wrench.META_TYPE_INT,
	},
	after_place = function(pos, player, stack, pointed)
		signs_lib.after_place_node(pos, player, stack, pointed)
		signs_lib.update_sign(pos)
	end,
	description = get_sign_description,
	drop = true,
}

register_all("basic_signs:sign_wall_glass", sign_def)
register_all("basic_signs:sign_wall_obsidian_glass", sign_def)
register_all("basic_signs:sign_wall_plastic", sign_def)

-- Colored signs

local sign_colors = {
	"green",
	"yellow",
	"red",
	"white_red",
	"white_black",
	"orange",
	"blue",
	"brown",
}

for _, color in pairs(sign_colors) do
	register_all("basic_signs:sign_wall_steel_"..color, sign_def)
end

-- Locked sign

register_all("basic_signs:sign_wall_locked", {
	metas = {
		text = wrench.META_TYPE_STRING,
		glow = wrench.META_TYPE_STRING,
		widefont = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
	},
	after_place = function(pos, player, stack, pointed)
		signs_lib.after_place_node(pos, player, stack, pointed, true)
		signs_lib.update_sign(pos)
	end,
	description = get_sign_description,
	drop = true,
	owned = true,
})
