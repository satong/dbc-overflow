# Seed users
content_for_users = [
  { :username => "tim",
    :email => "tim@test.com",
    :password => "1234" },
  { :username => "sam",
    :email => "sam@test.com",
    :password => "1234" },
  { :username => "pat",
    :email => "pat@test.com",
    :password => "1234" }
]

# Seed questions
content_for_indexs = [
  { :title => "What do nighthawks eat primarily?",
    :body  => Faker::Lorem.paragraph,
    :user_id => 1 },
  { :title => "Where do nighthawks winter?",
    :body  => Faker::Lorem.paragraph,
    :user_id => 1 },
  { :title => "What do otters eat primarily?",
    :body  => Faker::Lorem.paragraph,
    :user_id => 2 },
  { :title => "Do nighthawks make nests?",
    :body  => Faker::Lorem.paragraph,
    :user_id => 2 },
  { :title => "How fast can raccoons run?",
    :body  => Faker::Lorem.paragraph,
    :user_id => 3 }
]

# Seed answers
content_for_answers = [
  { :body => "insects",
    :question_id  => 1,
    :user_id => 2 },
  { :body => "South America",
    :question_id  => 2,
    :user_id => 3 },
  { :body => "fish",
    :question_id  => 3,
    :user_id => 3 },
  { :body => "Nighthawks don't make nests.",
    :question_id  => 4,
    :user_id => 1 },
  { :body => "Raccoons can run crazy fast - up to 15 miles per hour.",
    :question_id  => 5,
    :user_id => 2 }
]

User.create!(content_for_users)
Question.create!(content_for_indexs)
Answer.create!(content_for_answers)
