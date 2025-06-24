class ColorizeJob < ApplicationJob
  queue_as :default
  DEBOUNCE_TIME = 0.5 # seconds

  def perform(pdf_id)
    last_broadcast_time = nil

    pdf.add_color do |status|
      now = monotonic_time
      @last_status = status
      if last_broadcast_time.nil? || (now - last_broadcast_time) >= DEBOUNCE_TIME
        Turbo::StreamsChannel.broadcast_update_to pdf, target: "user_pdf_#{pdf_id}", content: status
        last_broadcast_time = now
      end
    end

    Turbo::StreamsChannel.broadcast_replace_to pdf, target: "processing", content: @last_status
  end

  private

  def pdf
    @pdf ||= UserPdf.find(arguments.first)
  end

  def monotonic_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
