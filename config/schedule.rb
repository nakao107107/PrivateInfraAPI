# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
set :output, 'log/crontab.log'
set :environment, :production

every 8.hours do
  runner 'Batch::DataUpdate.new.execute'
end

every 8.hours do
  runner 'Batch::UpdateApplicationCount.new.execute'
end
