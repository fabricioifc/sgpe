# necessário para funcionar com whenever via cron
env :PATH, ENV['PATH']

# SCHEDULE PARA REALIZAR BACKUP DIÁRIO
every 30.minute do
  rake "db:sql_dump"
end
