class BlogPost < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true

  enum kit: ["Miscellaneous", "Empennage", "Wing", "Fuselage", "Finishing", "Firewall Forward"]
end
