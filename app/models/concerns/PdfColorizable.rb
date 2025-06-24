module PdfColorizable
  extend ActiveSupport::Concern

  def add_color(&block)
    file_name = pdf.filename
    pdf.open do |file|
      input_file = file.path

      output_file = Rails.root.join("tmp", file_name.to_s)
      script = Rails.root.join("app", "assets", "python", "highlight.py")
      Open3.popen2("python3", "#{script}", "-i", "#{input_file}", "-o", "#{output_file}") do |stdin, stdout, status_thread|
        stdout.each_line do |line|
          puts "LINE: #{line}"
          yield line.strip if block # Yield the line to the caller
        end
        raise "Processing failed" unless status_thread.value.success?
      end

      new_file = File.open(output_file)
      @blob = ActiveStorage::Blob.create_and_upload!(io: new_file, filename: "colored_#{file_name}")
    end
  end
end
