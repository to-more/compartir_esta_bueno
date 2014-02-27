
require 'spec_helper'

describe Node do

		before :each do
			@node = Node.new Coordinate.new,nil
			@coordinate = Coordinate.new
		end


		describe "#link_to" do

		   it "@node in link_to should have linked" do
		   		@node.link_to @coordinate
		   		@node.linked?.should == true	
		   end
		end

end
