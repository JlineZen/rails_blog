FactoryGirl.define do
  factory :user do
    name 'bruce'
    gender 'male'
    email '123@qq.com'
    is_admin 1
    birthday '1991-12-15'
  end
end
