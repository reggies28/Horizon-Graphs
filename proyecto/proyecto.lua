--
-- Example2_1.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "csv"
require "dbg/DklBaseGraphics"
require "DataVizDkl"
json = require "json"

local bg
local data
local data2
local data3 
local datax 
local datay
local datax2 
local datay2
local datax3 
local datay3
local dd

function setup()
	size(500,350)
	local f = loadFont("data/Karla.ttf",12)
	textFont(f)
	bg = DklBaseGraphics:new(width(),height())
	data = readCSV("data/venta1.csv",true,',')
	data2 = readCSV("data/venta2.csv",true,',')
	data3 = readCSV("data/venta3.csv",true,',')

	str = readAll("data/venta1.json")
	dd = json.decode(str)
	datax = getColumn(dd,"x")
	datay = getColumn(dd,"y")
	str = readAll("data/venta1.json")
	dd = json.decode(str)
	datax2 = getColumn(dd,"x")
	datay2 = getColumn(dd,"y")
	str = readAll("data/venta1.json")
	dd = json.decode(str)
	datax3 = getColumn(dd,"x")
	datay3 = getColumn(dd,"y")
end

function draw()
	background(255)
	--bg:par({mfrow={2,1}})
	bg:plot(data["x"],data["y"],{type="l",sub="Ubisft",ylab="ventas assassins creed",xlab="meses",col = "#FF0000"})-- parametros del plot dibuja, cex= tamaño del cirulo,
	bg:plot(data2["x"],data2["y"],{type="l",sub="Ubisft",ylab="ventas assassins creed",xlab="meses",col = "#00FF00"})
end

function windowResized(w,h)
	bg:resize_window(w,h)
end
