# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
set :output, 'log/crontab.log'
set :environment, :production

every 10.minutes do
  runner 'Batch::DataUpdate.new.execute'
end

every 10.minutes do
  runner 'Batch::UpdateApplicationCount.new.execute'
end
