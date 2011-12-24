Given /^I have a new line of credit$/ do
  @loc = LineOfCredit.new
  @loc.open
end

Given /^my credit limit is \$(\d+)$/ do |amount|
  @loc.credit_limit = amount
end

Given /^I draw \$(\d+)$/ do |amount|
  @loc.draw(amount)
end

Then /^my available credit should be \$(\d+)$/ do |amount|
  @loc.available_credit.should == amount
end
