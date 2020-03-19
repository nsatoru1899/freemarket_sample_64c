FactoryBot.define do

  factory :user do
    nickname              {"testuser"}
    email                 {|n| "test#{n}@example.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    familyname            {"テスト"}
    firstname             {"太郎"}
    familyname_kana       {"てすと"}
    firstname_kana        {"たろう"}
    birth_date            {"2020-01-01"}
    phonenumber           {"000000"}
  end

end