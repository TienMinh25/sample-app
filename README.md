# Sample app

This document will be description all about my sample-app. 
Below is my daily to-do list

#### Chapter 3: _Mostly static pages_

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
* Successfully configured automation test
* Built a static web, used C and V in MVC, and generated controller via command line. Syntax below here
    ```
    rails generate controller <Controller_name> <action_1> <action_2> ...
    ```
    * Besides, even though you are very careful but still wrong in the above syntax (like naming, ..) you can delete it or cancel it with the following command
        ```
        rails destroy controller <Controller_name> <action_1> <action_2> ...
        ```
* Learn about embedded Ruby, which allows to write code Ruby into file html, html file will have the extension `<ten_file>.html.erb`. Have
two syntaxes I was learned:
    ```
        <%  %>: Execute code inside.
  
        <%= %>: Execute code inside and insert it into file.
    ```
  
* Setting root route

### Chapter 4: _Rails-Flavored Ruby_
* Learn about built-in helpers. Some method in below:
    > **link_to**: generate tag <a></a> in html and custom as you like

    > **stylesheet_link_tag**: used to insert .css files  

* Learn `arrays` and `range` (data structure) and learn about blocks.
* Learn `hashes` and `symbol`
* Learn about class in Ruby, class inheritance, modify class built-in.
* Learn about constructor in Ruby (example below):
    ```
        class Cat
            def initialize(params)
                # Constructor for field in here.
            end
        end
    ```
  * Note:
    > **params**: variables want to pass for initialization
* Everything in Ruby is an object 
* `p` method is different with `puts` method
  > **puts** method will return **nil**
  
  > **p** method will return the printed object

* Learn about access control in Ruby:
  > Ruby provides 3 levels of protection for its method:
    >> 1. **public**: this method can be called from anywhere, can be treated as if there is no access control or restriction.
    >> 2. **private**: this method can be called from an object of this class or an object that is a child of this class.
    >> 3. **protected**: this method is only called inside itself class define it.
  
  >  In addition, Ruby provides some access to the field of a class:
  >> 1. **attr_reader**: it allows to read information from a field.
  >> 2. **attr_writer**: it allows to modify data in a field.
  >> 3. **attr_accessor**: combination of `attr_writer` and `attr_reader`.

### Chapter 5: *Filling in the Layout*
* Use `bootstrap` framework to built layout
* #### Bootstrap and custom CSS
```rb
gem "bootstrap-sass"
```
```bash
bundle install
```
Create a custom SCSS file
```bash
touch app/assets/stylesheets/custom.scss
```
Inside the `custom.scss` use `@import` function to include Bootstrap. Then add some custom CSS to the file.
```scss
@import "bootstrap-sprockets";
@import "bootstrap";
```
* Learn about asset pipeline, it's a **powerful feature** that rails provides:
    > The asset pipeline provides a framework that allows connecting, compressing, or minifying CSS or JS resources. It also us to
  > write CSS or JS resources. It also allows us to write CSS, JS in a number of other languages
  > such as CoffeeScript, Sass or ERB. The assets files in the application are automatically linked to
  > the assets contained in the gem.

    > The Rails asset pipelines uses three standard directories for static assets, each with its own purpose:
    >> 1. **app/assets**: assets specific to the present application
    >> 2. **lib/assets**: assets for libraries written by your dev team
    >> 3. **vendor/assets**: assets from third-party vendors (not present by default)
    >
    > Each of these directories has a subdirectory for each of two asset classes--**images** and **Cascading Style Sheets**.
* Used **image_tag** helper, Rails will automatically find any images in the `app/assets/images` directory using the asset pipeline
    > <%= image_tag("rails.svg", alt: "Rails logo", width: "200", "https://rubyonrails.org"%>
    * Example about used `image_tag` method above
* Use bootstrap and custom CSS (use SASS)
* **In Ruby, when the final arguments are hashes in a function call, curly braces {} are optional**
    ```
    # Curly braces on fianl hash arguments are optional
    # This:
    stylesheet_link_tag("application", {"data-turbo-track": "reload"})
    
    # is the same as this:
    stylesheet_link_tag("application", "data-turbo-track": "reload")
    ```
* Rails use a facility ***partials*** to divide application layout
* Beside layout, We can split chunks of code using **Partials**.

    In `app/views/layouts/application.html.erb`
    ```erb
    <head>
       ...Some tags
       <%= render 'layouts/shim' %>
    </head>
    <body>
        <%= render 'layouts/header' %>
        ...Some tags
    </body>
    ```
* Use global variable in SCSS file

    `$light-gray: #777`
* Learn about **nested attribute** in scss and **mixins** and learn about inheritance of other format use **@extend**, example below:
    ```
    .field_with_errors {
         @extend .has-error;
         .form-control {
             color: $state-danger-text;
         }
    }
   ```
* Built and use Rails routes
  
  **Define shorter path:**
    ```rb
    # Initially
    get 'static_pages/home'
    
    # Now
    get "/home", to: "static_pages#help"(1)
    ```
  (1) **Note:**
    * `/home` -> `path`
    * `static_pages` -> `controller`
    * `#help` -> `action`
* **Layout Links**
    ```erb
    <%= link_to "About", about_path %>
    ```
    - `name_path` -> `/name`
    - `name_url` -> `https://example.com/name`
* Learn layout link tests, use **assert_select** method:
    > Some more uses of **assert_select** appear in table below:
    >
    | Code                                       |                    Matching HTML |
    |:-------------------------------------------|---------------------------------:|
    | assert_select "div"                        |              \<div>foobar\</div> |
    | assert_select "div", "foobar"              |              \<div>foobar\</div> |
    | assert_select "div.nav"                    |  \<div class="nav">foobar\</div> |
    | assert_select "div#profile"                | \<div id="profile">foobar\</div> |
    | assert_select "div[name=yo]"               |     \<div name = "yo">hey\</div> |
    | assert_select "a[href=?]", "/" , count: 1  |          \<a href = "/">foo\</a> |
    | assert_select "a[href=?]", "/", text: "foo" |          \<a href = "/">foo\</a> |

### Chapter 6: _Modeling Users_
### Chapter 7: _Sign Up_
### Chapter 8: _Basic Login_
### Chapter 9: _Advanced Login_
### Chapter 10: _Updating, Showing and Deleting User_
* Completed the REST actions for the Users resource(**_edit, update, index, destroy_** actions)
* Refer to the following table below:
  
  **Restful Route in Rails** (This is the standard)

  | Method    | Action   | URL             | Route(Controller#Action) |                                                   Description |
  |:----------|----------|-----------------|--------------------------|--------------------------------------------------------------:|
  | GET       | index    | /posts          | posts#index              |                               Show list of articles(bai viet) |
  | GET       | new      | /posts/new      | posts#new                |   Returns an HTML page containing a form to create an article |
  | GET       | show     | /posts/:id      | posts#show               |                                Display a post with a given id |
  | GET       | edit     | /posts/:id/edit | posts#edit               | Returns the HTML page containing the form to edit the article |
  | POST      | create   | /posts          | posts#create             |                                             Create a new post |
  | PATCH/PUT | update   | /posts/:id      | posts#update             |                                 Update a post with a given id |
  | DELETE    | delete   | /posts/:id      | posts#destroy            |                                 Delete a post with a given id |
  
* Some common status code:
  > **200 OK** - Trả về thành công cho những phương thức GET, PUT, PATCH hoặc DELETE.
  > 
  > **201 Created** - Trả về khi một Resource vừa được tạo thành công.
  > 
  > **204 No Content** - Trả về khi Resource xóa thành công.
  >   
  > **304 Not Modified** - Client có thể sử dụng dữ liệu từ cache (hỗ trợ server giảm tải xử lí request).
  > 
  > **400 Bad Request** - Request không hợp lệ.
  > 
  > **401 Unauthorized** - Request cần có sự authentication.
  > 
  > **403 Forbidden** - Server hiểu request nhưng bị từ chối không cho phép.
  > 
  > **404 Not Found** - Không tìm thấy resource từ URI.
  > 
  > **405 Method Not Allowed** - Phương thức không cho phép với user hiện tại.
  > 
  > **410 Gone - Resource** - không còn tồn tại, version cũ đã không còn hỗ trợ.
  > 
  > **415 Unsupported Media Type.**
  > 
  > **422 Unprocessable Entity** - Dữ liệu không được kiểm chứng.
  > 
  > **429 Too Many Requests** - Request bị từ chối do bị giới hạn. 


