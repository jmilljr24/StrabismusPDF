json.extract! blog_post, :id, :title, :content, :kit, :completed, :duration, :created_at, :updated_at
json.url blog_post_url(blog_post, format: :json)
json.content blog_post.content.to_s
