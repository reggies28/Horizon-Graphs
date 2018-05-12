-- GroupedAreaGraph.lua
require "RectCatAxis"
require "RectNumAxis"
require "Legend"
require "Label"
require "utilities"

function GroupedArea(w,h,data,series,colors,mode,selected,categories,minn,maxn)

	local m = #data
	local n = #categories
	local l = #series

	local interval = w/m
	local selection = {}

	for i=1,l do
		local size = 1
		local value
		local pos
		stroke(colors[i])
		fill(colors[i])
		if selected[i] then size = 3 end
		strokeWeight(size)
		beginShape()
		for j=1,m do
			value = map(data[j][series[i]],minn,maxn,0,h)
			pos = (j-1)*interval+interval/2
			if (mode == VERTICAL) then
				if (j==1) then vertex(pos,h) end
				vertex(pos,h-value)
				if (j==n) then vertex(pos,h) end
			elseif (mode == HORIZONTAL) then
				if (j==1) then vertex(0,pos) end
				vertex(value,pos)
				if (j==n) then vertex(0,pos) end
			end
		end
		endShape(CLOSE)
		if (shapeLooked()) then
			selection[i] = {x=0,y=0,data=0}
		end
	end
	return selection
end

function _GroupedAreaGraph(x,y,w,h,series,data,colors,
								mode,gap,tickInc,tickLen,selected,categories,minn,maxn)
	local selection = {}
	pushMatrix()
	translate(x,y)
	selection = GroupedArea(w,h,data,series,colors,mode,selected,categories,minn,maxn)
	Label(selection)
	RectNumAxis(h,LEFT,minn,maxn,tickInc,tickLen)
	pushMatrix()
	translate(0,h)
	RectCatAxis(w,BOTTOM,categories,tickLen)
	popMatrix()
	translate(w*1.1,0)
	Legend(w/10,h/10,series,colors,VERTICAL,gap)
	popMatrix()
	return selection
end
