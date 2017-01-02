FactoryGirl.define do
  factory :document_with_enum do |d|
    d.valid_from '2011-01-05'.to_date
    d.valid_until '2011-01-08'.to_date
    d.kind :draft
  end
end
