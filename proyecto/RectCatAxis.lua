-- RectCatAxis.lua

function RectCatAxisTicks(ext, pos, items, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		axisMode = -1
	end

	local size = #items
	local inc = ext/size

	local i = 0
	while (i <= ext) do
		if ((pos == TOP) or (pos == BOTTOM)) then
			line(i, 0, i, -tickLen*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			line(0, i, tickLen*axisMode, i)
		end
		i = i + inc
	end
end

function RectCatAxisLabels(ext, pos, items, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		axisMode = -1
	end
	
	local anchorMode = CENTER
	if (pos == LEFT) then
		anchorMode = RIGHT
	elseif (pos == RIGHT) then
		anchorMode = LEFT
	end
	textAlign(anchorMode)

	local size = #items
	local inc = ext/size

	local n = 1
	local i = 0
	while (n <= size) do
		local label = items[n]
		if ((pos == TOP) or (pos == BOTTOM)) then
			text(label,i+(inc/2), -(tickLen*2)*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			text(label,(tickLen*2)*axisMode,i+inc/2)
		end
		i = i + inc
		n = n + 1
	end
end

function RectCatAxis(ext, pos, items, tickLen)
	stroke(0)
	strokeWeight(1)
	if ((pos == TOP) or (pos == BOTTOM)) then
		line(0, 0, ext, 0)
	elseif ((pos == LEFT) or (pos == RIGHT)) then
		line(0, 0, 0, ext)
	end
	RectCatAxisTicks(ext,pos,items,tickLen)
	fill(0)
	RectCatAxisLabels(ext,pos,items,tickLen)
end
