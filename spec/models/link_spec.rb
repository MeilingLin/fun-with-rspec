require 'spec_helper'

describe Link do
  before(:each) do
  	@link = FactoryGirl.create(:link)
  end

  it "has a url" do
    @link.url.should be_present
    @link.url.should == "http://myfavorite.com/thing"
  end

  it "has a score" do
    @link.score.should be_present
    @link.score.should == 0
  end

  it "belongs to a user" do
  	user = FactoryGirl.create(:user)
  	user.links << @link

  	@link.user.should == user
  end

  context "with comments" do
  	before(:each) do
  		@link = FactoryGirl.create(:link_with_comment)
  	end

    it "has a comment" do
      @link.comments.should be_present
      @link.comments.count.should ==1
    end
    

    it "updates its cumulative score when a comment gets a score" do
      ## This one is tricky. You'll have to have several lines of code here. 
      ## The idea is that a link with 2 comments, one of a score 2, the other of a score 3, 
      ## will have a composite score of 5.

      ## A hint is that you may want to leverage the after_save callback of the 
      ## comment method to maybe update the parent link. 
      c1 = @link.comments.first
      1.times{c1.vote_up}

      c2 = FactoryGirl.create(:comment, link:@link)
      2.times{c2.vote_up}

      c2.save
      c1.save

      @link.reload
      @link.score.should == 5
    end
  end
end
