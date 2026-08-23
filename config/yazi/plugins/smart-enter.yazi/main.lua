--- @since 25.5.31
--- @sync entry

local function entry()
	local hovered = cx.active.current.hovered
	if not hovered then
		return
	end

	ya.emit(hovered.cha.is_dir and "enter" or "open", { hovered = true })
end

return { entry = entry }
