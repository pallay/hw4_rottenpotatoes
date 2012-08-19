Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create({:title => 'Star Wars',    :rating => 'PG', :director => 'George Lucas', :release_date => '1977-05-25'});
    Movie.create({:title => 'Blade Runner', :rating => 'PG', :director => 'Ridley Scott', :release_date => '1982-06-25'});
    Movie.create({:title => 'Alien',        :rating => 'R',  :director => '',             :release_date => '1979-05-25'});
    Movie.create({:title => 'THX-1138',     :rating => 'R',  :director => 'George Lucas', :release_date => '1971-03-11'});
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  Movie.where(title:arg1).limit(1).first.director == arg2
end