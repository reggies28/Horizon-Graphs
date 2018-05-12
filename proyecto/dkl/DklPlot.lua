--
-- DklPlot.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

DklBaseGraphics = DklBaseGraphics or {}

function DklBaseGraphics:plot(x,y,param)
	if (param==nil) then param = {} end
	if (param.xlim==nil) then 
		param.xlim = range(x) 
	else
		self.def.xaxs="i"
	end
	if (param.ylim==nil) then 
		param.ylim = range(y)
	else
		self.def.yaxs="i"
	end
	self:plotNew()
	self:plotWindow(param.xlim,param.ylim)
	pushMatrix()
	translate(self.plotWidth*self.col,self.plotHeight*self.row)
	if (param.type==nil) then param.type='p' end
	if (param.type=='p') then -- points
		self:points(x,y,param)
	elseif (param.type=='l') then -- lines
		self:lines(x,y,param)
	elseif (param.type=='b') then -- both (points and lines)
		self:lines(x,y,param)
		self:points(x,y,param)
	elseif (param.type=='o') then -- overwrite (points and lines)
		self:lines(x,y,param)
		self:points(x,y,param)
	elseif (param.type=='h') then -- fall lines
	elseif (param.type=='s') then -- steplines
	end
	self:axis(1)
	self:axis(2)
	if (self.row<self.mfrow[1]) then
		self.row = self.row + 1
	elseif (self.col<self.mfrow[2]) then
		self.row = 0
		self.col = self.col + 1
	end
	popMatrix()
end

function DklBaseGraphics:_plot(x,y,param)
	if (param==nil) then param={} end
	
	self.def.col = param.col or self.def.col
	self.def.cex = param.cex or self.def.cex
	
	if (param.xlim and param.ylim) then
		self:_update(param.xlim,param.ylim)
	end
	if (self.def.xlim==nil or self.def.ylim==nil) then
		self:_update(range(x),range(y))
	end

	self.varColor = (type(self.def.col) =='table')
	if (not self.varColor) then stroke(self.def.col) end
	self.varSize = (type(self.def.cex) =='table')
	if (not self.varSize) then self.sizeV = self.def.cex end
	self.varWeight = (type(self.def.lwd) =='table')
	if (not self.varWeight) then strokeWeight(self.def.lwd) end
	
	pushMatrix()
	translate(self.xOffset-self.def.xlim[1]*self.xScale,
		self.dev.size[2]-self.yOffset+self.def.ylim[1]*self.yScale)
end

function DklBaseGraphics:points(x,y,param)
	self:_plot(x,y,param)
	scale(self.xScale,self.yScale)
	
	self.varSymbol = (type(self.def.pch) =='table')
	if (not self.varSymbol) then self.symbol = self.def.pch+1 end
	self.varFill = (type(self.def.bg) =='table')
	noFill()
	if (not self.varFill and not self.varSymbol and self.symbol>14) then 
		fill(self.def.bg)
	end
	
	rectMode(CENTER)
	for i=1,#x do
		if (self.varColor) then stroke(col[i]) end
		if (self.varWeight) then strokeWeight(lwd[i]) end
		if (self.varSize) then self.sizeV = self.def.cex[i] end
		if (self.varSymbol) then self.symbol = self.def.pch[i]+1 end
		if (self.varFill and self.symbol>14) then 
			fill(self.def.bg[i])
		end
		shape(self.symbol,x[i],-y[i],self.sizeV/self.xScale,self.sizeV/self.yScale)
	end

	popMatrix()
end

function DklBaseGraphics:lines(x,y,param)
	self:_plot(x,y,param)
	scale(self.xScale,self.yScale)

	table.sort(x)

	beginShape()
	for i=1,#x do
		vertex(x[i],-y[i])
	end
	endShape()
	
	popMatrix()
end

function DklBaseGraphics:text(x,y,labels,param)
	self:_plot(x,y,param)
	local offX = 0
	local offY = 0
	
	if (param==nil) then param={} end
	self.def.pos = param.pos or self.def.pos
	self.def.offset = param.offset or self.def.offset
	
	if (self.def.pos==1) then
		offY = self.def.offset*self.def.csi
	elseif (self.def.pos==2) then
		offX = -self.def.offset*self.def.csi
	elseif (self.def.pos==3) then
		offY = -self.def.offset*self.def.csi
	elseif (self.def.pos==4) then
		offX = self.def.offset*self.def.csi
	end

	for i=1,#x do
		if (self.varColor) then fill(col[i]) end
		text(labels[i],x[i]*self.xScale+offX,-y[i]*self.yScale-offY)
	end
	
	popMatrix()
end

function DklBaseGraphics:polygon(x,y,param)
	self:_plot(x,y,param)

	beginShape()
	for i=1,#x do
		vertex(x[i]*self.xScale,-y[i]*self.yScale)
	end
	endShape(CLOSE)

	popMatrix()
end

function DklBaseGraphics:xycoords(x,y,param)
end


function DklBaseGraphics:segments(x0,y0,x1,y1,param)
	self:_plot(x,y,param)

	for i=1,#x do
		if (self.varColor) then fill(col[i]) end
		if (self.varWeight) then strokeWeight(lwd[i]) end
		line(x0[i]*self.xScale,-y0[i]*self.yScale,
			x1[i]*self.xScale,-y1[i]*self.yScale)
	end

	popMatrix()
end

function DklBaseGraphics:rect(xleft,ybottom,xright,ytop,param)
	self:_plot(x,y,param)

	for i=1,#x do
		if (self.varColor) then fill(col[i]) end
		if (self.varWeight) then strokeWeight(lwd[i]) end
		rect(xleft[i]*self.xScale,-ybottom[i]*self.yScale,
			xright[i]*self.xScale,-ytop[i]*self.yScale)
	end

	popMatrix()
end

function DklBaseGraphics:abline(a,b)
end
