# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  flyctl depoly
  bin/rails generate dockerfile #This allows git to work for gem on github

  docker file add after final state FROM base
  ARG DEPLOY_PACKAGES="libvips"

- ...
