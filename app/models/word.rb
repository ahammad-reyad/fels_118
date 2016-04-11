class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
    reject_if: lambda {|attribute| attribute[:content].blank?},
    allow_destroy: true
end
