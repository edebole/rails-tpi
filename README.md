# Trabajo Final Integrador - TTPS Ruby 2019

## Requisitos
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Ruby](https://www.ruby-lang.org/es/)
- [Bundle gem](https://github.com/bundler/bundler)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instalando el proyecto

Para instalar el proyecto es necesario abrir la terminal y ejecutar los siguientes comandos:

```sh
git clone git@github.com:EstebanDebole/ruby-tpi.git
cd ruby-tpi
docker-compose build
```

## Levantando el proyecto

Para levantar el proyecto es necesario estar posicionado en la carpeta del proyecto y ejecutar los comandos:

```sh
docker-compose up -d
docker-compose exec web rails db:setup
```

Una vez hecho esto, se podrá acceder al sitio desde http://localhost:3000

## Corriendo los tests
Para correr todos los tests juntos utilizando el comando:
```sh
docker-compose exec web rails spec
```
Para correrlos uno por uno:
```sh
docker-compose exec web rails spec spec/models/product_spec.rb
docker-compose exec web rails spec spec/models/item_spec.rb
```

## Terminando
Para finalizar es necesario ejecutar:

```sh
docker-compose down
```



