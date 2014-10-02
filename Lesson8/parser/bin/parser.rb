#!/usr/bin/env ruby
require 'mechanize' 
require 'pry'
require 'csv'

Dir["../lib/*.rb"].each{|file| require file}
file_name = "file.csv"

params = ParamsReader.get_params ARGV

site = Hata_by.new

apartments = site.apartments(params)
unless (apartments.nil? || apartments.empty?)
  CSV.open(file_name, "wb") do |csv|
    csv << apartments.first.keys      
    
    apartments.each do |apartment|
      csv << apartment.values      
    end
  end
end

puts "All done! Browse'parser/bin/file.csv to details'"