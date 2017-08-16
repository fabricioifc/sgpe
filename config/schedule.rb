# necessário para funcionar com whenever via cron
env :PATH, ENV['PATH']

# SCHEDULE PARA REALIZAR BACKUP DIÁRIO

if @environment == "production"

  every 1.minute do
    rake "db:sql_dump"
  end

end
