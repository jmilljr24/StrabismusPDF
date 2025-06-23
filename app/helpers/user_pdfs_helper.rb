module UserPdfsHelper
  # def colorizer(user_pdf) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  #   file = user_pdf.pdf.blob
  #   file.open do |tempfile|
  #     doc = HexaPDF::Document.open(tempfile.path)
  #     doc.pages.each_with_index do |page, index|
  #       puts "Processing page #{index + 1}"
  #       processor = if index == 0
  #         StringBoxesProcessor.new(page)
  #       else
  #         StringBoxesProcessor.new(page, @color_key)
  #       end
  #       page.process_contents(processor)
  #       str_boxes = processor.str_boxes
  #       processor.match(str_boxes)
  #       page_parts = processor.page_parts

  #       both_pages = @prev_page_parts & processor.current_page_parts.uniq

  #       processor.assign_color(page_parts, both_pages)
  #       processor.color(page_parts)
  #       @color_key = processor.color_key
  #       @prev_page_parts = processor.current_page_parts.uniq
  #     end
  #     @filename = Rails.root.join("tmp", "colored_#{user_pdf.pdf.filename}").to_s
  #     doc.write(@filename, optimize: true)
  #     file = File.open(@filename)
  #     @blob = ActiveStorage::Blob.create_and_upload!(io: file, filename: "colored_#{user_pdf.pdf.filename}")
  #   end
  # end

  def python_color(user_pdf) # rubocop:disable Metrics/
    file_name = user_pdf.pdf.filename
    # colored_file_name = "#{file_name}_colored.pdf"
    # input_file = ActiveStorage::Blob.service.path_for(user_pdf.pdf.key)
    user_pdf.pdf.open do |file|
      # ...

      input_file = file.path

      output_file = Rails.root.join("tmp", file_name.to_s)
      # script_blob = ActiveStorage::Blob.find_by_filename("highlight.py")
      # script = ActiveStorage::Blob.service.path_for(script_blob.key)
      script = Rails.root.join("app", "assets", "python", "highlight.py")
      Open3.popen2("python3", "#{script}", "-i", "#{input_file}", "-o", "#{output_file}") do |stdin, stdout, status_thread|
        stdout.each_line do |line|
          puts "LINE: #{line}"
        end
        raise "Processing failed" unless status_thread.value.success?
      end

      new_file = File.open(output_file)
      @blob = ActiveStorage::Blob.create_and_upload!(io: new_file, filename: "colored_#{file_name}")
    end
  end
end
