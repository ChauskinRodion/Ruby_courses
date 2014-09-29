require 'benchmark'

#1
def fib_non_recursive(n)
  b = 0; c = 1
  n.times { |n| a = b; b = c; c=a+b; }
  c
end

#2 
def fib_recursive(n)  
  n < 2 ? 1 : fib_recursive(n - 1) + fib_recursive(n - 2)
end

#3 hash wrapped into method to avoid using already built hash
def fib_hash(n)  
  fib_hash = Hash.new { |hash, i| hash[i] =  hash[i - 1] + hash[i -2]}.update(0=> 1, 1=>1);
  fib_hash[n]
end


methods =  [:fib_recursive,:fib_non_recursive,:fib_hash]
params =   [[25           ,250               ,250      ],
            [35           ,2000              ,2000     ],
            [40           ,3000              ,3000     ],
            [4            ,5000              ,5000     ]]




p "Fibonacci calculation benchmarks"
Benchmark.bm(30) do |x|
  params.each do |test_parameters|
    methods.each_with_index do|method,i|
      n = test_parameters[i]
      x.report("#{method}(#{n}):") { self.send(method,n) }
    end
  p "=."*38  
  end  
end  