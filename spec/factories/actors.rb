# spec/factories/actors.rb
FactoryBot.define do
  factory :actor do
    name { 'John Doe' }
    age { 30 }
    height { 180.5 }
    rating { 8.5 }
  end
end
