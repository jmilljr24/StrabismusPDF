class PurgeJob < ApplicationJob
  queue_as :default

  def perform(blob_id, user_id)
    # Do something later
    blob.purge
    user.pdf.purge
    user.destroy!
  end

  private

  def blob
    @blob ||= ActiveStorage::Blob.find(arguments.first)
  end

  def user
    @user ||= UserPdf.find(arguments.second)
  end
end
