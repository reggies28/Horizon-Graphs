-- GroupedLineGraph.lua
require "RectCatAxis"
require "RectNumAxis"
require "Legend"
require "Label"
require "utilities"

function GroupedLine(w,h,data,series,colors,mode,selected,categories,minn,maxn)

	local m = #data
	local n = #categories
	local l = #series
	
	local interval = w/m
	local selection = {}

	for i=1,l do
		local size = 1
		stroke(colors[i])
		beginShape()
		if selected[i] then size = 3 end
		strokeWeight(size)
		for j=1,m do
			local value = map(data[j][series[i]],minn,maxn,0,h)
			local pos = (j-1)*interval+interval/2
			if (mode == VERTICAL) then
				vertex(pos,h-value)
			elseif (mode == HORIZONTAL) then
				vertex(value,pos)
			end
		end
		endShape()
		if (shapeLooked()) then
			selection[i] = {x=0,y=0,data=0}
		end
	end
	return selection
end

function _GroupedLineGraph(x,y,w,h,series,data,colors,
								mode,gap,tickInc,tickLen,selected,categories,minn,maxn)

	local selection = {}
	pushMatrix()
	translate(x,y)
	selection = GroupedLine(w,h,data,series,colors,mode,selected,categories,minn,maxn)
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
