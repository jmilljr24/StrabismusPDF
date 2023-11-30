class PdfHighlightJob < ApplicationJob
  include UserPdfsHelper

  queue_as :default

  def perform(text)
    # Do something later
    puts "Running background job with user id: #{text}"
    @user_pdf = UserPdf.find_by(id: text)
    # p Turbo::StreamsChannel.broadcast_replace_to "processing_pdf",
    #   target: "processing",
    #   partial: "user_pdfs/downloads",
    #   locals: {
    #     text: text
    #   }
    colorizer(@user_pdf)
    ActionCable.server.broadcast \
      "", {title: "New things!", body: "All that's fit for print"}
  end
end
