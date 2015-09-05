def withdraw(amount)
  if amount <= 0 # this deals with some of the situations...
    return false
  elsif amount % 5 == 0
    my_array = []
    if amount % 20 == 0  
      twenties = amount / 20
      twenties.times {my_array << 20}
      return my_array
    elsif amount % 10 == 0
      minusten = amount - 10
      twenties = amount / 20
      twenties.times {my_array << 20}
      my_array << 10
      return my_array
    else 
      minusfive = amount - 5
      if minusfive % 20 == 0
        twenties = minusfive / 20
        twenties.times {my_array << 20}
        my_array << 5
        return my_array
      else
        minusfiveten = minusfive - 10
        twenties = minusfiveten / 20
        twenties.times {my_array << 20}
        my_array << 10
        my_array << 5
        return my_array
      end
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
    [53, false],
    [35, [20, 10, 5]],
    [40, [20, 20]],
    [65, [20, 20, 20, 5]],
    [70, [20, 20, 20, 10]],
    [75, [20, 20, 20, 10, 5]],
  ].each do |input, expected|
    it "should return #{expected} when $#{input} is withdrawn" do
      withdraw(input).must_equal expected
    end
  end
end