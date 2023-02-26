-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

function love.conf(t)
	t.version = "11.3"
	t.window.icon = "res/img/icon.png"
	t.window.title = "Gothic World"
	t.window.width = 640
	t.window.height = 640
	t.window.resizable = false

	t.modules.data = false
	t.modules.joystick = false
	t.modules.mouse = false
	t.modules.physics = false
	t.modules.system = false
	t.modules.thread = false
	t.modules.touch = false
	t.modules.video = false
end
