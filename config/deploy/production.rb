#Конфиг деплоя на production
server 'brandymint.ru', port: 2222, :app, :web, :db, :primary => true
set :branch, "master" unless exists?(:branch)
