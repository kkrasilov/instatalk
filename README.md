# Instatalk

Приложение, где каждый пользователь без регистрации может создать «комнату» для общения: ссылку на эту «комнату» можно кинуть другу и тот тоже сможет вступить в переписку.  

Главная фишка приложения - библтиотека ActionCable, с помощью которой реализован функционал общения в реальном времени. Так же можно смотреть кто из пользователей онлайн!

## Preview

https://instatalk-friend-chat.herokuapp.com/

## Установка

Для корректной работы приложения на Вашем компьютере должны быть установлены Ruby 2.4.9 и Rails 5.1.4. [(Install Ruby On Rails on
Ubuntu 20.04 Focal Fossa)](https://gorails.com/setup/ubuntu/20.04).

```
$ git clone https://github.com/kkrasilov/instatalk.git
$ cd ./instatalk
$ bundle install --without production
$ cp config/databese.yml.example config/databese.yml
$ rails db:migrate
```

## Запуск

Запуск осуществляется командой

```
$ bundle exec rails s
```
Приложение находится по адресу ```http://localhost:3000/```
