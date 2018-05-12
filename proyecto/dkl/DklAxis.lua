--
-- DklAxis.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

DklBaseGraphics = DklBaseGraphics or {}

function DklBaseGraphics:axis(side,param)
	-- 1=below, 2=left, 3=above and 4=right.
	if (param==nil) then param = {} end
	local axisMode = 1
	if ((side == 2) or (side == 3)) then
		 axisMode = -1
	end
	
	if (param.labels~=nil and param.at==nil) then
		param.at = seq(0,#param.labels,1)
	end
	
	local xlim = self.def.xlim
	local ylim = self.def.ylim
	
	if (param.at==nil) then
		if (side==1 or side==3) then
			param.at = seq(xlim[1],xlim[2],math.floor(100/self.dev.size[1]*self.xExt))
		elseif (side == 2 or side==4) then
			param.at = seq(ylim[1],ylim[2],math.floor(100/self.dev.size[2]*self.yExt))
		end
	end
	
	if (param.labels==nil) then
		if (side==1 or side==3) then
			param.labels = param.at
		elseif (side == 2 or side==4) then
			param.labels = reverse(param.at)
		end
	end
	
	stroke(0)
	textAlign(CENTER,CENTER)
	pushMatrix()
	translate(self.xOffset,self.yOffset)
	
	if (side==1) then
		translate(0,self.yExt*self.yScale)
	elseif (side==4) then
		translate(self.xExt*self.xScale,0)
	end
	
	if ((side == 1) or (side == 3)) then
		line(0, 0, self.xExt*self.xScale, 0)
		translate(-xlim[1]*self.xScale,0)
		for i=1,#param.at do
			line(param.at[i]*self.xScale,0,param.at[i]*self.xScale,self.def.tck*axisMode)
			text(param.labels[i],param.at[i]*self.xScale,self.def.tck*axisMode*3)
		end
	elseif ((side == 2) or (side == 4)) then
		line(0, 0, 0, self.yExt*self.yScale)
		translate(0,-ylim[1]*self.yScale)
		for i=1,#param.at do
			line(0,param.at[i]*self.yScale,self.def.tck*axisMode,param.at[i]*self.yScale)
			text(param.labels[i],self.def.tck*axisMode*3,param.at[i]*self.yScale)
		end
	end
	popMatrix()
end
