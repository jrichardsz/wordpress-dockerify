# Wordpress with docker

![logo](https://raw.githubusercontent.com/jrichardsz/static_resources/master/wordpress/wordpress-dockerizated.png)

# step 1

Download wp from official web
- wget http://wordpress.org/latest.tar.gz
- wget https://wordpress.org/latest.zip

Or github
- https://github.com/WordPress/WordPress


# step 2

Add these files:

- Dockerfile
- DockerfileEntryPoint.sh
- wp-config.php

# step 3

Create a mysql database

```
docker run -d -p 3306:3306 --name wordpress_database -e MYSQL_ROOT_PASSWORD=changeme mysql:5.7 --character-set-server=utf8 --collation-server=utf8_general_ci
```

```
docker exec -t wordpress_database mysql -uroot -pchangeme  -e "create database db100"
```

# step 4

Build docker image

```
docker build --rm -t wordpress .
```

# step 5

Export required variables:

```
export DB_HOST=$(hostname -I| awk '{printf $1}'):3306
export DB_USER=root
export DB_PASSWORD=changeme
export DB_NAME=db100
```

```
docker run -d -p 80:80  \
-e "DB_HOST=$DB_HOST" \
-e "DB_USER=$DB_USER"  \
-e "DB_PASSWORD=$DB_PASSWORD"  \
-e "DB_NAME=$DB_NAME"  \
-e "AUTH_KEY=$(uuidgen)"  \
-e "SECURE_AUTH_KEY=$(uuidgen)"  \
-e "NONCE_KEY=$(uuidgen)"  \
-e "LOGGED_IN_KEY=$(uuidgen)"  \
-e "AUTH_SALT=$(uuidgen)"  \
-e "SECURE_AUTH_SALT=$(uuidgen)"  \
-e "LOGGED_IN_SALT=$(uuidgen)"  \
-e "NONCE_SALT=$(uuidgen)"  \
-e "AUTH_KEY=$(uuidgen)"  \
-e "DISABLE_WP_CRON=true"  \
--name wordpress-app wordpress
```

# Docker push samples

```

# hub.docker.com
docker tag wordpress:latest dondecomeunocomendos/covid19:latest
docker push dondecomeunocomendos/covid19:latest

#repo.treescale.com
docker tag wordpress:latest repo.treescale.com/dc1c2/wordpress:latest
docker push repo.treescale.com/dc1c2/wordpress:latest

```
---

# Wordpress with config management

coming soon

# Technologies and versions

- wordpress 5.4
- php 7.1

# Contributors

Thanks goes to these wonderful people :

<table>
  <tbody>
    <td>
      <img src="https://avatars0.githubusercontent.com/u/3322836?s=460&v=4" width="100px;"/>
      <br />
      <label><a href="http://jrichardsz.github.io/">Richard Leon</a></label>
      <br />
    </td>    
  </tbody>
</table>
