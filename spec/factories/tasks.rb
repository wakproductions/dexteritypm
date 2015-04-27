FactoryGirl.define do
  sequence :task_title do |n|
    "Dexterity task ##{n}"
  end

  sequence :task_group_title do |n|
    "Dexterity group ##{n}"
  end

  # This factory won't be valid by default because it needs to be associated with a project
  factory :task do
    title { generate(:task_title) }
    description { Forgery(:lorem_ipsum).sentences(3) }
    group false

    trait :new_feature do
      category Task::CATEGORY[:feature]
      status Task::STATUS[:pending]
    end

    trait :group do
      title { generate(:task_group_title) }
      description nil
      group true
    end

    factory :new_feature_task, traits: [:new_feature]
    factory :task_group, traits: [:group]
  end

end
