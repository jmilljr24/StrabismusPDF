class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
end
