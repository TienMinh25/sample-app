# Sample app

This document will be description all about my sample-app. 
Below is my daily to-do list

#### 23/06/2023:

* Create sample-app, below is command line I use
```
rails _7.0.5_ new sample-app 
```
* Config file *'Gemfile'* and file *'config/database.yml'* to connect database (in app I use 
MySQL for default db)
  1. Trong file *'Gemfile'*, write the code to the file as follows: (in here i use mysql2 version 0.5.2)
        ```
        gem 'mysql2', '~> 0.5.2'
        ```
  2. Trong file *'config/database.yml'* (in here you can modify username and password in db with your account)
        ```
        default: &default
        adapter: mysql2
        encoding: utf8mb4
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
        username: <db_username> 
        password: <db_password>
        socket: /tmp/mysql.sock

        development:
        <<: *default
        database: sample_app
        ```
* I tried to connect to database and it was succesfully. Try it by below code
  1. The command line code below is used to set up tables in the database. When you run the migration command,
  it will search in the **db/migrate** folder and execute them by starting from the oldest file.
        ```
        rails db:migrate
        ```
  2. The command line code below is used to test
        ```
        rails test
        ```
  3. The command line code below is used to run server use rails
        ```
        rails server
        ```
#### 24/06/2023:
* Successfully configured automation test
* Built a static web, used C and V in MVC, and generated controller via command line. Syntax below here
    ```
    rails generate controller <Controller_name> <action_1> <action_2> ...
    ```
    * Besides, even though you are very careful but still wrong in the above syntax (like naming, ..) you can delete it or cancel it with the following command
        ```
        rails destroy controller <Controller_name> <action_1> <action_2> ...
        ```
* Done chapter 3 and run successfully.