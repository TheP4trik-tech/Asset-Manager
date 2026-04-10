FactoryBot.define do
  factory :attachment do
    added_date {Date.today}
    association :asset, factory: :asset
    attachment_type {"image"}
    description {"test"}


    
  end
end
