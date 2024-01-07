class AddSectionToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :section, :integer
  end
end
