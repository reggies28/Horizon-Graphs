--
-- DklBaseGraphics.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

require "dkl/DklUtilities"
require "dkl/DklPlot"
require "dkl/DklAxis"
require "dkl/DklLegend"

DklBaseGraphics = DklBaseGraphics or {}

function DklBaseGraphics:_makeSymbols(w,h)
	local c = 0.275957512247
	beginShape()
	vertex(-0.5,0.5)
	vertex(0.5,0.5)
	vertex(0.5,-0.5)
	vertex(-0.5,-0.5)
	vertex(-0.5,0.5)
	saveShape()
	beginShape()
	vertex(0,0.5)
	bezierVertex(c,0.5,0.5,c,0.5,0)
	vertex(0.5,0)
	bezierVertex(0.5,-c,c,-0.5,0,-0.5)
	vertex(0,-0.5)
	bezierVertex(-c,-0.5,-0.5,-c,-0.5,0)
	vertex(-0.5,0)
	bezierVertex(-0.5,c,-c,0.5,0,0.5)
	saveShape()
end

function DklBaseGraphics:new(w,h)
	d = {}
	self:_makeSymbols()
   setmetatable(d, self)
   self.__index = self
   self.dpi = 96
   self.dev = {size = {w,h}}
   self.mfrow = {1,1}
   self.row = 0
   self.col = 0
   self._def = {
		x=nil, y = nil, type = "p",  xlim = nil, ylim = nil, bg= "#000000",
		main = nil, sub = nil, xlab = nil, ylab = nil, col = "#000000",
		pch = 1, cex = 10, csi = 11, ps = 8, horiz = FALSE, xaxp = 0,  
		yaxp = 0,  xaxs = 0, tck = 10, lwd = 1, lty, xaxs = "r", yaxs = "r",
		mar =  {5, 4, 4, 2}, oma = {3,3,3,3}, mex = 1, pos=1, 
		offset = 1.5
	}
	self.def = tableCopy(self._def)
   return d
end

function DklBaseGraphics:mtext(text,param)
end

function DklBaseGraphics:box(a,b)
end

function DklBaseGraphics:title(main,sub)
end

function DklBaseGraphics:plotNew()
	self.def = tableCopy(self._def)
end

function DklBaseGraphics:_update(xlim,ylim)
	if (xlim) then self.def.xlim = xlim end
	if (ylim) then self.def.ylim = ylim end
	self.xExt = xlim[2] - xlim[1]
	self.yExt = ylim[2] - ylim[1]

	if (self.def.xaxs=="r") then
		self.def.xlim[1] = self.def.xlim[1]-math.floor(self.xExt*0.04)
		self.def.xlim[2] = self.def.xlim[2]+math.floor(self.xExt*0.04)
	end
	if (self.def.yaxs=="r") then
		self.def.ylim[1] = self.def.ylim[1]-math.floor(self.yExt*0.04)
		self.def.ylim[2] = self.def.ylim[2]+math.floor(self.yExt*0.04)
	end
	self.xExt = xlim[2] - xlim[1]
	self.yExt = ylim[2] - ylim[1]
	
	local din = self.dev.size -- window size
	local oma = self.def.oma -- outer margins
	local mar = self.def.mar -- inner margins
	local mex = self.def.mex -- lines magnification factor
	local csi = self.def.csi -- font size
	
	local ppx = { 	din[1]-((oma[1]+oma[3]+mar[1]+mar[3])*mex*csi),
						din[2]-((oma[2]+oma[4]+mar[2]+mar[4])*mex*csi)}

	self.xScale = ppx[1]/self.xExt/self.mfrow[1]
	self.yScale = ppx[2]/self.yExt/self.mfrow[2]
	self.xOffset = (oma[1]+oma[3])*mex*csi
	self.yOffset = (oma[2]+oma[4])*mex*csi
	
	self.plotWidth = din[1]-((oma[1]+oma[3])*mex*csi)/self.mfrow[1]
	self.plotHeight = din[2]-((oma[2]+oma[4])*mex*csi)/self.mfrow[2]
end

function DklBaseGraphics:plotWindow(xlim,ylim)
	self:_update(xlim,ylim)
end

function DklBaseGraphics:resizeWindow(w,h)
   self.dev = {size = {w,h}}
	self:_update()
end
   
function DklBaseGraphics:par(key,value)
	local specials = {mfrow=true}
	local temp
	if (value) then 
		if (specials[key]) then
			temp = self[key]
			self[key]=value
		else
			temp = self.def[key]
			self.def[key]=value
		end
		return temp
	else
		if (specials[keys]) then
			return self[key]
		else
			return self.def[key]
		end
	end
end
