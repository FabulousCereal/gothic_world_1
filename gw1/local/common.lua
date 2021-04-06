return {
	layerComposite = function(input)
		local ops = f0b.layers.ops
		local layers = input.layers

		for i = 1, #layers do
			layers[i][1] = i
			ops(layers, "set", layers[i])
		end

		local graphics = love.graphics
		local cnv = graphics.newCanvas()
		graphics.setCanvas(cnv)
		f0b.layers.draw(layers)
		graphics.setCanvas()

		input.layers = nil
		input.args = {cnv}
		return {input}
	end,
}
