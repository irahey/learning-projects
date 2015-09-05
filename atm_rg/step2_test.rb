def withdraw(amount)
  if amount <= 0 # this deals with some of the situations...
    return false
  elsif amount % 5 == 0
    return amount/5
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
    [7, false],
    [5, 1],
    [20, 4],
    [35, 7],
  ].each do |input, expected|
    it "should return #{expected} when $#{input} is withdrawn" do
      withdraw(input).must_equal expected
    end
  end
end