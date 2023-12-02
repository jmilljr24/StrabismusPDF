class PurgeJob < ApplicationJob
  queue_as :default

  def perform(blob_id)
    # Do something later
    blob.purge
  end

  private

  def blob
    @blob ||= ActiveStorage::Blob.find(arguments.first)
  end
end
