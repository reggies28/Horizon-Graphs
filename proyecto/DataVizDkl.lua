require "GroupedBarGraph"
require "GroupedPointGraph"
require "GroupedLineGraph"
require "GroupedAreaGraph"

DataVizDkl = {}
DataVizDkl.__index = DataVizDkl

function DataVizDkl:new()
	local self = setmetatable({}, DataVizDkl)
	self.id = 0
	self.selection = {}
	return self
end

function DataVizDkl:GroupedBarGraph(options)
	self.id = self.id + 1
	local id = self.id
	if (not options.minvalue) then options.minvalue = 0 end
	if (not options.maxvalue) then options.maxvalue = 100 end
	self.selection[id] = _GroupedBarGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100,
		options.series or {}, options.data or {{}}, options.colors or {}, 
		options.mode or VERTICAL, options.gap or 10, options.overlap or 0.1, 
		options.tickInc or (options.maxvalue-options.minvalue)/5, 
		options.tickLen or 10, self.selection[id] or {},
		options.categories or "", options.minvalue or 0,
		options.maxvalue or 100)
end

function DataVizDkl:GroupedPointGraph(options)
	self.id = self.id + 1
	local id = self.id
	if (not options.minvalue) then options.minvalue = 0 end
	if (not options.maxvalue) then options.maxvalue = 100 end
	self.selection[id] = _GroupedPointGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100,
		options.series or {}, options.data or {{}}, options.colors or {}, 
		options.mode or VERTICAL, options.gap or 10, options.tickInc or (options.maxvalue-options.minvalue)/5, 
		options.tickLen or 10, self.selection[id] or {},
		options.categories or "", options.minvalue or 0, 
		options.maxvalue or 100)
end

function DataVizDkl:GroupedLineGraph(options)
	self.id = self.id + 1
	local id = self.id
	if (not options.minvalue) then options.minvalue = 0 end
	if (not options.maxvalue) then options.maxvalue = 100 end
	self.selection[id] = _GroupedLineGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, 
		options.series or {}, options.data or {{}}, options.colors or {}, 
		options.mode or VERTICAL, options.gap or 10, options.tickInc or (options.maxvalue-options.minvalue)/5, 
		options.tickLen or 10, self.selection[id] or {},
		options.categories or "", options.minvalue or 0, 
		options.maxvalue or 100)
end

function DataVizDkl:GroupedAreaGraph(options)
	self.id = self.id + 1
	local id = self.id
	if (not options.minvalue) then options.minvalue = 0 end
	if (not options.maxvalue) then options.maxvalue = 100 end
	self.selection[id] = _GroupedAreaGraph(options.x or 0, options.y or 0, 
		options.w or 100, options.h or 100, 
		options.series or {}, options.data or {{}}, options.colors or {}, 
		options.mode or VERTICAL, options.gap or 10, options.tickInc or 10, 
		options.tickLen or 10, self.selection[id] or {},options.categories or "",
		options.minvalue or 0,options.maxvalue or 100)
end

function DataVizDkl:Begin(options)
	self.id = 0
end

function DataVizDkl:End(options)
end
