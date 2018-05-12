-- CircCatAxis.lua

function circScale(v, b, s, r)
	local result = {};
	result.x = r/2*math.cos(((v-b)*(PI*2)/(s-b)))
	result.y = r/2*math.sin(((v-b)*(PI*2)/(s-b)))
	return result
end

function CircCatAxisTicks(ext, items, tickLen)
	local n = #items
	local posA,posB
	for i=1,n do
		posA = circScale(i-n/4,0,n,ext)
		posB = circScale(i-n/4,0,n,ext+tickLen)
		line(posA.x, posA.y, posB.x, posB.y)
	end
end

function CircCatAxisLabels(ext, items, tickLen)
	local n = #items
	local label,coord
	for i=1,n do
		label = items[i]
		coord = circScale(i+0.5-n/4,0,n,ext+tickLen*4)
		text(label, coord.x-5, coord.y+5)
	end
end

function CircCatAxis(ext, items, tickLen)
	stroke(0)
	noFill()
	ellipse(0,0,ext,ext)
	CircCatAxisTicks(ext,items,tickLen)
	fill(0)
	CircCatAxisLabels(ext,items,tickLen)
end
