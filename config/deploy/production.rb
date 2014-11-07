#Конфиг деплоя на production
server 'brandymint.ru', :app, :web, :db, :primary => true
set :branch, "master" unless exists?(:branch)
