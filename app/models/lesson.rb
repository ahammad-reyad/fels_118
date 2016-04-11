class Lesson < ActiveRecord::Base
  before_create :assign_words
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  accepts_nested_attributes_for :results

  def number_correct_choices
    results.select{|result| result.answer.try :is_correct}.count
  end

  private
  def assign_words
    words = self.category.words.order("RANDOM()").limit 2
    words.each{|word| self.results.build word: word}
  end
end
