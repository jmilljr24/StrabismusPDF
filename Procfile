web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -e production -c2
release: bin/rails db:migrate:with_data