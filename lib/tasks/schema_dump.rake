require 'open3'

namespace :db do
  desc 'Creates a db/schema.rb file that is portable against any DB supported by Sequel'
  task 'schema:dump' => :environment do
    filename = Rails.root.join('db', 'schema.sql').to_s
    command = "pg_dump --no-owner --schema-only $DATABASE_URL > #{filename}"
    stdout_stderr, status = Open3.capture2e(command)
    raise StandardError, stdout_stderr unless status.success?
  end
end

task('db:migrate').clear.enhance(['db:schema:dump'])
