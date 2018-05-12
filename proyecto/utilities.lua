-- Utilities.lua


function getColumn(data,name)
	local column = {}
	for i=1,#data do
		column[i] = data[i][name]
	end
	return column
end

function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

function tableMax(data,columns)
	local value = 0
	for k1,v1 in pairs(data) do
		for k2,v2 in pairs(v1) do
			if (v2 ~= nill and tonumber(v2) ~= nil ) then
				if (value<tonumber(v2)) then
					value = tonumber(v2)
				end
			end
		end
	end
	return value
end
