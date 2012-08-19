require "spec_helper"

describe MoviesController do
  before do
    Movie.create({:title => 'Star Wars',    :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'})
    Movie.create({:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'})
    Movie.create({:title => 'Alien',        :rating => 'R',  :director => '',             :release_date => '1979-05-25'})
    Movie.create({:title => 'THX-1138',     :rating => 'R',  :director => 'George Lucas', :release_date => '1971-03-11'})
  end
  after do
    Movie.delete_all
  end
  describe "index" do
    context "sorting by index" do
      before do
        @sort = 'title'
      end
      it "should redirect to index with correct params" do
        get :index, sort:@sort
        page.should redirect_to '/movies?&sort=title'
      end
    end
    context "sorting by release_date" do
      before do
        @sort = 'release_date'
      end
      it "should redirect to index with correct params" do
        get :index, sort:@sort        
        page.should redirect_to '/movies?&sort=release_date'
      end
    end
    context "sorting by rating" do
      before do
        @sort = 'ratings'
      end
      it "should redirect to index with correct params" do
        get :index, sort:@sort        
        page.should redirect_to '/movies?&sort=ratings'
      end
    end
    context "sorting by different rating and title" do
      before do
        @sort_1 = 'title'
        @sort_2 = 'ratings'
        session.stub(:sort).with(@sort_1)
        session.stub(:rating).with(nil)
      end
      it "should redirect to index with correct params" do
        get :index, ratings:@sort_2
        page.should redirect_to '/movies?ratings=ratings'
      end
    end
  end

  describe "create" do
    it "should increase the count by 1" do
      before_count = Movie.count
      post :create, {title:'A new title'}
      after_count = Movie.count
      after_count.should == before_count+1
    end
    it "should redirect and flash" do
      post :create, id:Movie.first
      page.should redirect_to movies_path
      flash[:notice].should_not be_nil
    end
  end

  describe "destroy" do
    it "should decrease the count by 1" do
      before_count = Movie.count
      delete :destroy, id:Movie.first
      after_count = Movie.count
      after_count.should_not == before_count
    end
    it "should redirect and flash" do
      delete :destroy, id:Movie.first
      page.should redirect_to movies_path
      flash[:notice].should_not be_nil
    end
  end

  describe "search" do
    it "should find the movie" do
      get :search, id:Movie.first
      assigns(:movies).count.should == 2
    end
    it "should redirect and flash" do
      get :search, id:Movie.where(title:'Alien').limit(1).first
      page.should redirect_to movies_path
      flash[:notice].should_not be_nil
    end
  end

  describe "edit" do
    it "should find the movie" do
      get :edit, id:Movie.first
      assigns(:movie).should_not be_nil
    end
  end
  
end
