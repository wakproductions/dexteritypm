# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    project_name {  Forgery('internet').domain_name }
  end
end
