class RemoveNullConstraintFromTitleOnBlogPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :blog_posts, :title, true
  end
end
