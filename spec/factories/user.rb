FactoryGirl.define do
  # This factory won't be valid by default because it needs to be associated with a project
  factory :user do
    email { Forgery(:internet).email_address }
    password { Forgery(:basic).password }
    first_name { Forgery(:name).first_name }
    last_name { Forgery(:name).last_name }
  end

end
