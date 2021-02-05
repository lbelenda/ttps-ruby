class Note < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  has_rich_text :body
end
