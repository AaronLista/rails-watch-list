class Review < ApplicationRecord
  belongs_to :list

  validates :content, presence: true
  validates :rating, presence: true, comparison: { less_than_or_equal_to: 5 }
end
