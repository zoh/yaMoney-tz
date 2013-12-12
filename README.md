## Тестовое задание Яндекс

Демонстрация: http://zoh.github.io/yaMoney-tz/


#### Установка

устанавливаем через bower компоненты

``bower install``

и тянем npm модули

``npm install``

Запускаем static server из корневой: 

    $ ./node_modules/http-server/bin/http-server 
      Starting up http-server, serving ./ on port: 8082
      Hit CTRL-C to stop the server

#### Тестирование

Для тестирования необходимо уставновить testem ``[sudo] npm install -g testem``
и выполнить из корневой ``testem -f testem.json``
