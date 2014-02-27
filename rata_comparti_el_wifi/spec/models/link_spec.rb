require 'spec_helper'

	describe Link do

		before :each do
			@link = Link.new Coordinate.new
			@coordinate = Coordinate.new
		end


		describe "#link_to" do

		   it "linked to other coordinate should have one node" do
		      @link.one_node?.should == true
		   end
		       
		   it "link_to another coordinate should have lniked" do
		   		@link.link_to Coordinate.new
		   		@link.linked?.should == true	
		   end
		end

	end