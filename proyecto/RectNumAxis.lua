-- RectNumAxis.lua

function RectNumAxisTicks(ext, pos, minn, maxn, tickInc, tickLen)
	local axisMode = 1
	if ((pos == LEFT) or (pos == BOTTOM)) then
		 axisMode = -1
	end

	local coord
	for v=minn,maxn,tickInc do
		coord = map(v, minn, maxn, 0, ext)
		if ((pos == TOP) or (pos == BOTTOM)) then
			line(coord, 0, coord, -tickLen*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			line(0, coord, tickLen*axisMode, coord)
		end
	end
end

function RectNumAxisLabel(ext, pos, minn, maxn, tickInc, tickLen)
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

	for v=minn,maxn,tickInc do
		if ((pos == LEFT) or (pos == RIGHT)) then
			coord = map(v, maxn, minn, 0, ext)
		else
			coord = map(v, minn, maxn, 0, ext)
		end
		if ((pos == TOP) or (pos == BOTTOM)) then
			text(v, coord,5-(tickLen*2)*axisMode)
		elseif ((pos == LEFT) or (pos == RIGHT)) then
			text(v, (tickLen*2)*axisMode, 5+coord)
		end
	end
end

function RectNumAxis(ext, pos, minn, maxn, tickInc, tickLen)
	stroke(0)
	strokeWeight(1)
	if ((pos == TOP) or (pos == BOTTOM)) then
		line(0, 0, ext, 0)
	elseif ((pos == LEFT) or (pos == RIGHT)) then
		line(0, 0, 0, ext)
	end
	RectNumAxisTicks(ext, pos, minn, maxn, tickInc, tickLen)
	fill(0)
	RectNumAxisLabel(ext, pos, minn, maxn, tickInc, tickLen)
end
