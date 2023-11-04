class DropPdfs < ActiveRecord::Migration[7.1]
  def change
    drop_table :pdfs
  end
end
