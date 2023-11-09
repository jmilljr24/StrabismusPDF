class ParseController < ApplicationController
  def index; end

  def show
    @new_file_name = params[:new_file_name]

    render 'show'
  end

  def parse_file # rubocop:disable Metrics/
    uploaded_file = params[:file]
    return if uploaded_file.nil?

    # errors.add(:pdf, 'is too big. Max 10MB') unless File.size(uploaded_file) <= 10.megabyte
    unless uploaded_file.content_type == 'application/pdf' && File.size(uploaded_file) < 10.megabyte
      p flash.alert = 'Invalid File. Check file type and size.'
      redirect_to root_path
      return
    end

    File.open(Rails.root.join('public', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    doc = HexaPDF::Document.open(uploaded_file.path)
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
    @new_file_name = "colored_#{uploaded_file.original_filename}"
    doc.write("#{Rails.root}/public/#{@new_file_name}", optimize: true)

    redirect_to parse_show_path(new_file_name: @new_file_name)
  end

  def download
    @new_file_name = params[:new_file_name]
    send_file(
      "#{Rails.root}/public/#{@new_file_name}",
      filename: @new_file_name,
      type: 'application/pdf',
      disposition: 'inline'
    )
  end
end
