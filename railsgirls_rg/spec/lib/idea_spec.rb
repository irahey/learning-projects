require "spec_helper"
require "rspec"
require "rails_helper"
require "idea"
=begin
describe Idea do
  it "has a name" do # yep, you can totally use 'it'
    idea = Idea.new # creating a new idea 'instance'
    idea.name.should be true # this is our expectation
  end
end


describe Idea do
  it "has a name" do
    idea = Idea.new
    idea.name.should be_present #passes
  end
  #it { idea.name.should be_true }
end
=end

#refactored version of above ^
describe Idea do
  it(:name) { should be_present }
end




