-- CircNumAxis.lua

function circScale(v, b, s, r)
	local result = {};
	result.x = r/2*math.cos(((v-b)*(PI*2)/(s-b)))
	result.y = r/2*math.sin(((v-b)*(PI*2)/(s-b)))
	return result
end

function CircNumAxisTicks(ext, minn, maxn, tickInc, tickLen)
	for v=minn,maxn-tickInc,tickInc do
		local posA = circScale(v-maxn/4,minn,maxn,ext)
		local posB = circScale(v-maxn/4,minn,maxn,ext+tickLen)
		line(posA.x,posA.y,posB.x,posB.y)
	end
end

function CircNumAxisLabel(ext, minn, maxn, tickInc, tickLen)
	for v=minn,maxn-tickInc,tickInc do
		local coord = circScale(v-maxn/4,minn,maxn,ext+tickLen*4)
		text(tostring(v),coord.x-5,coord.y+5)
	end
end

function CircNumAxis(ext, minn, maxn, tickInc, tickLen)
	stroke(0)
	noFill()
	ellipse(0,0,ext,ext)
	CircNumAxisTicks(ext,minn,maxn,tickInc,tickLen)
	fill(0)
	CircNumAxisLabel(ext,minn,maxn,tickInc,tickLen)
end
