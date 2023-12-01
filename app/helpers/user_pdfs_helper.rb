module UserPdfsHelper
  def colorizer(user_pdf) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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
      return @blob.id
    end
  end
end
