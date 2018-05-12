-- GroupedPointGraph.lua
require "RectCatAxis"
require "RectNumAxis"
require "Legend"
require "Label"
require "utilities"

function GroupedPoint(w,h,data,series,colors,mode,selected,categories,minn,maxn)

	local m = #data
	local n = #categories
	local l = #series
	
	local interval = w/m
	local selection = {}

	for i=1,l do
		for j=1,m do
			local value = map(data[j][series[i]],minn,maxn,0,h)
			local pos = (j-1)*interval+interval/2
			local size = 4
			fill(colors[i])
			rectMode(CENTER)
			if selected[i..":"..j] then size = 8 end
			if (mode == VERTICAL) then
				rect(pos,h-value,size,size)
				if shapeLooked() then
					selection[i..":"..j] = 
						{x=pos,y=h-value,data=data[j][series[i]]};
				end
			elseif (mode == HORIZONTAL) then
				rect(value,pos,size,size)
				if shapeLooked() then
					selection[i..":"..j] = 
						{x=value,y=pos,data=data[j][series[i]]};
				end
			end
		end
	end
	return selection
end

function _GroupedPointGraph(x,y,w,h,series,data,colors,
								mode,gap,tickInc,tickLen,selected,categories,minn,maxn)

	local selection = {}
	pushMatrix()
	translate(x,y)
	selection = GroupedPoint(w,h,data,series,colors,mode,selected,categories,minn,maxn)
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
