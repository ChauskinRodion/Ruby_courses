class ParamsReader
  
  def self.get_params (argv)
    params = Params.new
    params.max_price = argv[0]

    raise ArgumentError if params.invalid?
    params
  end

end