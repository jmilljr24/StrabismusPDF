class ColorizeJob < ApplicationJob
  queue_as :default

  def perform(pdf_id)
    # last_broadcast_time = nil

    pdf.add_color # do |status|
    # Turbo::StreamsChannel.broadcast_update_to pdf, target: "processing", content: "Processing Page: #{status}"
    # end

    Turbo::StreamsChannel.broadcast_replace_to pdf, target: pdf, partial: "user_pdfs/pdf_list", locals: {user_pdf: pdf}
  end

  private

  def pdf
    @pdf ||= UserPdf.find(arguments.first)
  end
end
