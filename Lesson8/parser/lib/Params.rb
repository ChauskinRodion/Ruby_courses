class Params
  attr_accessor :max_price


  def invalid?
    max_price.nil? && max_price.is_a?(Fixnumber) && max_price > 1000
  end
end