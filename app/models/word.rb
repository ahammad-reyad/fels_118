class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  has_many :lessons, through: :results
  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attribute| attribute[:content].blank?},
    allow_destroy: true
  validates :content, presence: true
  before_save :must_be_a_correct_answer

  scope :learned, ->user_id, category_id{
    where("id in (select results.word_id from results join answers
    on results.answer_id = answers.id where answers.is_correct = 't' and
    lesson_id in (select id from lessons where
    category_id = #{category_id} and user_id = #{user_id}))")}

  scope :not_learned, ->user_id, category_id{
    where("id in(select id from words where category_id = #{category_id}
    and id not in (select results.word_id from results join answers on
    results.answer_id = answers.id where answers.is_correct = 't' and
    lesson_id in (select id from lessons where
    category_id = #{category_id} and user_id = #{user_id})))")}

  OPTION = {learned: :learned, not_learned: :not_learned, all_word: :all_word}

  class << self
    def filter_words category, current_filter, current_user
      case current_filter
      when "learned"
        self.learned current_user.id, category.id
      when "not_learned"
        self.not_learned current_user.id, category.id
      else
        category.words
      end
    end
  end

  private
  def must_be_a_correct_answer
    unless self.answers.select{|answer| answer.is_correct}.size == 1
      errors.add " ", I18n.t("must_be_a_answer_correct")
    end
  end
end
