class UserPdf < ApplicationRecord
  has_one_attached :pdf, dependent: :destroy
  validate :acceptable_pdf

  private

  def acceptable_pdf
    return unless pdf.attached?

    errors.add(:pdf, 'is too big. Max 10MB') unless pdf.blob.byte_size <= 10.megabyte

    return if pdf.content_type.in?(%w[application/pdf])

    errors.add(:pdf, 'must be a PDF')
  end
end
