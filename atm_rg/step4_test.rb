def withdraw(amount)
  if amount <= 0 # this deals with some of the situations...
    return false
  elsif amount % 10 == 0
    my_array = []
    notes = amount/10
    notes.times {my_array << 10}
    return my_array
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
    [45, false],
    [20, [10, 10]],
    [40, [10, 10, 10, 10]],
  ].each do |input, expected|
    it "should return #{expected} when $#{input} is withdrawn" do
      withdraw(input).must_equal expected
    end
  end
end

