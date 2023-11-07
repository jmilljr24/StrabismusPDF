class UserPdf < ApplicationRecord
  has_one_attached :pdf, dependent: :destroy
end
