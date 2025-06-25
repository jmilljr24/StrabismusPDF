module ActiveStorage
  class Analyzer
    class PDFAnalyzer < Analyzer
      # Only run this analyzer on PDF files
      def self.accept?(blob) = blob.content_type == "application/pdf"

      def metadata
        page_count = nil

        download_blob_to_tempfile do |file|
          reader = PDF::Reader.new(file)
          page_count = reader.page_count
        end

        {
          page_count: page_count
        }
      end
    end
  end
end

# Add the analyzer to the default set so that it gets run on every upload
Rails.application.config.active_storage.analyzers << ActiveStorage::Analyzer::PDFAnalyzer
