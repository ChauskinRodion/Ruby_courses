#!/usr/bin/env ruby
require  "curses"

def draw_picture (message,x,y)
  win = Curses::Window.new(20, 100, y, x)
  win.addstr(message)
  win.refresh
end

message =
".d8888b.  888                     888    888       888 d8b                 
d88P  Y88b 888                     888    888   o   888 Y8P                 
Y88b.      888                     888    888  d8b  888                     
  Y888b.   888888  8888b.  888d888 888888 888 d888b 888 888 888d888 .d88b.  
     Y88b. 888         88b 888P    888    888d88888b888 888 888P   d8P  Y8b 
       888 888    .d888888 888     888    88888P Y88888 888 888    88888888 
Y88b  d88P Y88b.  888  888 888     Y88b.  8888P   Y8888 888 888    Y8b.     
  Y8888P     Y888  Y888888 888       Y888 888P     Y888 888 888      Y8888"   

Curses.init_screen
Curses.curs_set(0)
cols = Curses.cols

cols.times do |i|
  draw_picture(message,cols - i,10)
  sleep(0.08)
end 

Curses.close_screen