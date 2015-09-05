def withdraw(amount)
  if amount <= 0 # this deals with some of the situations...
    return false
  elsif amount % 5 == 0
    my_array = []
    if amount % 10 == 0
      tens = amount / 10
      tens.times {my_array << 10}
      return my_array
    else
      minusfive = amount - 5
      alltens = minusfive / 10
      alltens.times {my_array << 10}
      my_array << 5
      return my_array
    end
  else
    return false
  end
  # ToDo: figure out this bit
end


# import required testing libraries
require 'minitest/spec'
require 'minitest/autorun'

# Replace your existing tests with the ones below.
describe 'atm' do
  [
    [-1, false],
    [0, false],
    [7, false],
    [20, [10, 10]],
    [25, [10, 10, 5]],
    [35, [10, 10, 10, 5]],
  ].each do |input, expected|
    it "should return #{expected} when $#{input} is withdrawn" do
      withdraw(input).must_equal expected
    end
  end
end