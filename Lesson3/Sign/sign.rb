#!/usr/bin/env ruby
require_relative 'PrametersParser.rb'
require_relative 'SignTool.rb'

GRAVITIES = {'top-right'    => Magick::NorthEastGravity,
             'top-left'     => Magick::NorthWestGravity,
             'bottom-right' => Magick::SouthEastGravity,
             'bottom-left'  => Magick::SouthWestGravity }

params       =  PrametersParser.parse
padding,sign =  params[:padding], params[:message]
files        =  Dir["#{params[:directory]}/*"]


SignTool.new(sign, GRAVITIES[params[:position]], padding)
        .sign_files(files)