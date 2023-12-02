require "open3"

class PdfHighlightJob < ApplicationJob
  queue_as :default

  def perform(user_id) # rubocop:disable Metrics/
    # uploaded_file = UserPdf.find(user_id)
    @blob = python_color

    puts "Running background job with user id: #{user_id}"
    # colorizer(user_id)
    # @blob.inspect
    # Turbo::StreamsChannel.broadcast_replace_to ["processing_pdf", user_id].join(":"),
    #   target: "processing",
    #   partial: "/user_pdfs/downloads",
    #   locals: {
    #     pdf_blob: @blob,
    #     user_pdf: user_pdf
    #   }
  end

  def python_color # rubocop:disable Metrics/
    file_name = user_pdf.pdf.filename
    # colored_file_name = "#{file_name}_colored.pdf"
    input_file = ActiveStorage::Blob.service.path_for(user_pdf.pdf.key)
    output_file = Rails.root.join("public", file_name.to_s)
    script_blob = ActiveStorage::Blob.find_by_filename("highlight.py")
    script = ActiveStorage::Blob.service.path_for(script_blob.key)
    Open3.popen2("python3", "#{script}", "-i", "#{input_file}", "-o", "#{output_file}") do |stdin, stdout, status_thread|
      stdout.each_line do |line|
        puts "LINE: #{line}"
      end
      raise "Processing failed" unless status_thread.value.success?
    end

    file = File.open(output_file)
    @blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "colored_#{file_name}")
    Turbo::StreamsChannel.broadcast_replace_to ["processing_pdf", user_pdf.id].join(":"),
      target: "processing",
      partial: "/user_pdfs/downloads",
      locals: {
        pdf_blob: @blob,
        user_pdf: user_pdf
      }
  end

  private

  def user_pdf
    @user_pdf ||= UserPdf.find(arguments.first)
  end
end
