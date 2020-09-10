FactoryBot.define do
  factory :label do
    name { "MyString" }
  end

  factory :second_label, class: Label do
    name { "HisOrHerString" }
  end
end
