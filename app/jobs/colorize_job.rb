class ColorizeJob < ApplicationJob
  queue_as :default
  DEBOUNCE_TIME = 0.5 # seconds

  def perform(pdf_id)
    last_broadcast_time = nil

    pdf.add_color do |status|
      now = monotonic_time
      if last_broadcast_time.nil? || (now - last_broadcast_time) >= DEBOUNCE_TIME
        Turbo::StreamsChannel.broadcast_update_to pdf, target: "processing", content: status
        last_broadcast_time = now
      end
    end

    sleep 0.1 if last_broadcast_time.nil? || (monotonic_time - last_broadcast_time) < 0.2
    Turbo::StreamsChannel.broadcast_replace_to pdf, target: pdf, partial: "user_pdfs/pdf_list", locals: {user_pdf: pdf}
  end

  private

  def pdf
    @pdf ||= UserPdf.find(arguments.first)
  end

  def monotonic_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
