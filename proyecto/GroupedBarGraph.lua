-- GroupedBarGraph.lua
require "RectCatAxis"
require "RectNumAxis"
require "Legend"
require "Label"
require "utilities"

function GroupedBar(w,h,data,series,colors,mode,gap,overlap,selected,categories,minn,maxn)

	local m = #data
	local n = #categories
	local l = #series

	local section = w/m-gap
	local barWidth = map(overlap,0,1,section/l,section)
	local offset = map(overlap,0,1,section/l,0)
	local selection = {}

	for i=1,l do
		for j=1,m do
			local size = 1
			local barHeight = map(data[j][series[i]],minn,maxn,0,h)
			local pos = (j-1)*(section+gap)+(i-1)*offset+gap/2
			if selected[i..":"..j] then size = 3 end
			strokeWeight(size)
			fill(colors[i])
			if (mode == VERTICAL) then
				rect(pos, h-barHeight, barWidth, barHeight)
				if (shapeLooked()) then
					selection[i..":"..j] = {x=pos,y=h-barHeight,data=data[j][series[i]]}
				end
			elseif (mode == HORIZONTAL) then
				rect(0, pos, barHeight, barWidth)
				if (shapeLooked()) then
					selection[i..":"..j] = {x=barHeight,y=pos,data=data[j][series[i]]}
				end
			end
		end
	end
	return selection
end

function _GroupedBarGraph(x,y,w,h,series,data,colors,
								mode,gap,overlap,tickInc,tickLen,selected,categories,minn,maxn)
	local selection = {}
	pushMatrix()
	translate(x,y)
	selection = GroupedBar(w,h,data,series,colors,mode,gap,overlap,selected,categories,minn,maxn)
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
