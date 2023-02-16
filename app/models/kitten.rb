class Kitten < ApplicationRecord
  validates :name, :age, :cuteness, :softness, presence: {message: "
  is missing!"}
  validates :name, uniqueness: true
  validates :age, numericality: {in: 0..25, message: "Max age is 25!"}
  validates :cuteness, :softness, numericality: {in: 0..10, message: "can have a maximum of 10"}

  def as_json(options={})
    {name: self.name, age: self.age, cuteness: self.cuteness, softness: self.softness}
  end
end
