class ColorizeJob < ApplicationJob
  queue_as :default

  def perform(pdf_id, page_count)
    # last_broadcast_time = nil

    pdf.add_color do |status|
      Turbo::StreamsChannel.broadcast_update_to pdf, target: "progress_bar", partial: "user_pdfs/progress_bar", locals: {progress: status * 100 / page_count}
    end

    Turbo::StreamsChannel.broadcast_replace_to pdf, target: pdf, partial: "user_pdfs/pdf_list", locals: {user_pdf: pdf}
  end

  private

  def pdf
    @pdf ||= UserPdf.find(arguments.first)
  end
end
