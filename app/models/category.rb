class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words, dependent: :destroy
  validates :category_name, presence: true, length: {maximum:50},
    uniqueness: true
end
