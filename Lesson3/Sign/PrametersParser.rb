require 'optparse'
class PrametersParser
  @@available_positions = ['top-right','top-left','bottom-right', 'bottom-left']
  
  def self.parse
    options = {}
    optparse = OptionParser.new do |opts|
      opts.banner =  "************************************ SIGN ************************************
                  \n\rSimple tool to add signature to all pictures in directory
                    \rUsage: sign.rb --padding 20 --position top-right photos/b-day/ 'Amazing sign'
                    \rNote: padding and position is an optional params.\n\r"

      opts.on('-p', '--padding PADDING',OptionParser::DecimalInteger,"Setup sign padding. Must be integer value") do |f|
       options[:padding] = f 
      end
      
      opts.on('--position POSITION_TYPE',@@available_positions, "Position of sign #{@@available_positions}") do |f|
        options[:position] = f
      end    
    end.parse!

    options[:padding]  ||= 10
    options[:position] ||= @@available_positions.first
    
    [:directory,:message].each do |param|
      options[param] = ARGV.shift
      raise "Please specify #{param} parameter." if options[param].nil?
    end
    
    options
  end  
end