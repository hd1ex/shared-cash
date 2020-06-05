# Shared Cash

This is a Django project to digitally manage _cash_ 
which is shared between people.

For that the
[`django-shared-cash-boxes`](https://github.com/hd1ex/django-shared-cash-boxes)
app is used.
   
This project additionally provides a login view, the django admin interface
 and a html base which renders the breadcrumbs.
Additionally a [bootstrap](https://getbootstrap.com/) css theme is provided.

## Getting it up and running
### Basic development setup

First make sure the following dev dependencies are installed on your system:
 - python3
 - git
 - make _(optional)_
 
Then proceed by cloning the projects repository and fetching its submodule:
 ```shell script
git clone https://github.com/hd1ex/shared-cash.git
cd shared-cash
git submodule update --init
```

Now install a [python venv](https://docs.python.org/3/library/venv.html) 
with the projects dependencies by running
```shell script
make install
```

You can also do this by running the commands listed in the 
[Makefile](Makefile) manually.

Now you can activate the venv by running
```shell script
source venv/bin/activate
```

To create the database and an admin user just run
```shell script
python manage.py migrate
python manage.py createsuperuser
```

After that you can simply run the django dev server with
```shell script
python manage.py runserver
```

and visit [http://127.0.0.1:8000/](http://127.0.0.1:8000/)   
You should see the login view of the website.  
Now a Django admin (super user) can add data and other users at
[http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)

### Deployment

For deployment you need the following tools:
 - git
 - docker
 - docker-compose
 
After you made sure they are installed, 
 proceed by cloning the repo and its submodule:
 ```shell script
git clone https://github.com/hd1ex/shared-cash.git
cd shared-cash
git submodule update --init
```
 
Then you probably want to extend the
[`ALLOWED_HOSTS` in the Django settings](shared_cash/settings.py)
and the [`server_name` in the nginx config](nginx/shared_cash_nginx.conf).

After that you can start the website as container:
```shell script
docker-compose up -d
```

To setup a first admin user, start a shell in the container by running
```shell script
docker exec -it shared_cash_shared-cash_1 /bin/sh
```
and run
```shell script
python manage.py createsuperuser
exit
```

Now you can visit your website and login with the admin user
(visit [`http://localhost`](http://localhost) if you left the default value).

In the long run you probably want to set up some kind of a backup system.   
All interesting files live in docker volumes. To list these run
```shell script
docker volume ls
```

The _files_ volume contains all uploaded files
 and the _databases_ volume contains all other valid data.
 