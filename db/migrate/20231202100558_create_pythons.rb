class CreatePythons < ActiveRecord::Migration[7.1]
  def change
    create_table :pythons do |t|

      t.timestamps
    end
  end
end
