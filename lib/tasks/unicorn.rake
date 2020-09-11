namespace :unicorn do
  desc 'unicornを起動します'

  task :start do
    config = Rails.root.to_s + '/config/unicorn.rb'
    sh "bundle exec unicorn_rails -c #{config} -E production -D"
  end

  desc 'unicornを停止します'
  task :stop do
    unicorn_signal :QUIT
  end

  desc 'unicornを再起動します'
  task(:restart) do
    unicorn_signal :USR2
  end

  # Helpers
  def unicorn_signal(signal)
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    File.read(Rails.root.to_s + '/tmp/pids/unicorn.pid').to_i
  rescue Errno::ENOENT
    raise 'Unicorn does not seem to be running'
  end
end