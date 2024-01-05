class CreateBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts do |t|
      t.string :title, null: false
      t.integer :kit, default: 0
      t.date :completed
      t.float :duration

      t.timestamps
    end
  end
end
