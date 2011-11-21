# Define factories.
FactoryGirl.define do
  factory :account do
    account_type Account::Type::ACCOUNTS_RECEIVABLE
    balance 0.0
    line_of_credit
  end

  factory :line_of_credit do
    status LineOfCredit::Status::OPEN
  end

  factory :action do
    type    Action::Type::DRAW
    status  Action::Status::SCHEDULED
    line_of_credit
  end

  factory :transaction do
    amount  100.0
  end
end
