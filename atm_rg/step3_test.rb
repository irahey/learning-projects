def withdraw(amount)
  if amount <= 0 # this deals with some of the situations...
    return false
  elsif amount % 5 == 0
    my_array = []
    notes = amount/5
    notes.times {my_array << 5}
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
    [1, false],
    [43, false],
    [20, [5, 5, 5, 5]],
    [35, [5, 5, 5, 5, 5, 5, 5]],
  ].each do |input, expected|
    it "should return #{expected} when $#{input} is withdrawn" do
      withdraw(input).must_equal expected
    end
  end
end