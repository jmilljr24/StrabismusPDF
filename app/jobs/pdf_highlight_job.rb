class PdfHighlightJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # Do something later

    puts "Running background job with user id: #{user_id}"
    colorizer(user_id)
    @blob.inspect
    Turbo::StreamsChannel.broadcast_replace_to ["processing_pdf", user_id].join(":"),
      target: "processing",
      partial: "/user_pdfs/downloads",
      locals: {
        pdf_blob: @blob,
        user_pdf: user_pdf
      }
  end

  def colorizer(user_pdf) # rubocop:disable Metrics/AbcSize
    current_pdf = UserPdf.find(user_pdf)
    file = current_pdf.pdf.blob
    file.open do |tempfile|
      doc = HexaPDF::Document.open(tempfile.path)
      doc.pages.each_with_index do |page, index|
        puts "Processing page #{index + 1}"
        processor = if index == 0
          StringBoxesProcessor.new(page)
        else
          StringBoxesProcessor.new(page, @color_key)
        end
        page.process_contents(processor)
        str_boxes = processor.str_boxes
        processor.match(str_boxes)
        page_parts = processor.page_parts

        both_pages = @prev_page_parts & processor.current_page_parts.uniq

        processor.assign_color(page_parts, both_pages)
        processor.color(page_parts)
        @color_key = processor.color_key
        @prev_page_parts = processor.current_page_parts.uniq
      end
      @filename = Rails.root.join("tmp", "colored_#{current_pdf.pdf.filename}").to_s
      doc.write(@filename, optimize: true)
      file = File.open(@filename)
      @blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "colored_#{current_pdf.pdf.filename}")
    end
  end

  private

  def user_pdf
    @user_pdf ||= UserPdf.find(arguments.first)
  end
end
