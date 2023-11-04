class CreateUserPdfs < ActiveRecord::Migration[7.1]
  def change
    create_table :user_pdfs do |t|

      t.timestamps
    end
  end
end
