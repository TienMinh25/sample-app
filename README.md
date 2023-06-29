# Sample app

This document will be description all about my sample-app. 
Below is my daily to-do list

#### Chapter 3: _Mostly static pages_

* Create sample-app, below is command line I use
```ruby19regexp
rails _7.0.5_ new sample-app 
```
* Config file *'Gemfile'* and file *'config/database.yml'* to connect database (in app I use 
MySQL for default db)
  1. Trong file *'Gemfile'*, write the code to the file as follows: (in here i use mysql2 version 0.5.2)
        ```genericsql
        gem 'mysql2', '~> 0.5.2'
        ```
  2. Trong file *'config/database.yml'* (in here you can modify username and password in db with your account)
        ```ruby19regexp
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
        ```bash
        rails db:migrate
        ```
  2. The command line code below is used to test
        ```bash
        rails test
        ```
  3. The command line code below is used to run server use rails
        ```bash
        rails server
        ```
* Successfully configured automation test
* Built a static web, used C and V in MVC, and generated controller via command line. Syntax below here
    ```bash
    rails generate controller <Controller_name> <action_1> <action_2> ...
    ```
    * Besides, even though you are very careful but still wrong in the above syntax (like naming, ..) you can delete it or cancel it with the following command
        ```bash
        rails destroy controller <Controller_name> <action_1> <action_2> ...
        ```
* Learn about embedded Ruby, which allows to write code Ruby into file html, html file will have the extension `<ten_file>.html.erb`. Have
two syntaxes I was learned:
    ```ruby19regexp
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
    ```ruby
        class Cat
            def initialize(params)
                # Constructor for field in here.
            end
        end
    ```
  * Note:
    > **`params`**: variables want to pass for initialization
* Everything in Ruby is an object 
* `p` method is different with `puts` method
  > **`puts`** method will return **nil**
  
  > **`p`** method will return the printed object

* Learn about access control in Ruby:
  > Ruby provides 3 levels of protection for its method:
    >> 1. **`public`**: this method can be called from anywhere, can be treated as if there is no access control or restriction.
    >> 2. **`private`**: this method can be called from an object of this class or an object that is a child of this class.
    >> 3. **`protected`**: this method is only called inside itself class define it.
  
  >  In addition, Ruby provides some access to the field of a class:
  >> 1. **`attr_reader`**: it allows to read information from a field.
  >> 2. **`attr_writer`**: it allows to modify data in a field.
  >> 3. **`attr_accessor`**: combination of `attr_writer` and `attr_reader`.

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
    > The `asset pipeline` provides a framework that allows connecting, compressing, or minifying CSS or JS resources. It also us to
  > write CSS or JS resources. It also allows us to write CSS, JS in a number of other languages
  > such as CoffeeScript, Sass or ERB. The assets files in the application are automatically linked to
  > the assets contained in the gem.

    > The Rails `asset pipelines` uses three standard directories for static assets, each with its own purpose:
    >> 1. **`app/assets`**: assets specific to the present application
    >> 2. **`lib/assets`**: assets for libraries written by your dev team
    >> 3. **`vendor/assets`**: assets from third-party vendors (not present by default)
    >
    > Each of these directories has a subdirectory for each of two asset classes--**images** and **Cascading Style Sheets**.
* Used **image_tag** helper, Rails will automatically find any images in the `app/assets/images` directory using the asset pipeline
    > <%= image_tag("rails.svg", alt: "Rails logo", width: "200", "https://rubyonrails.org"%>
    * Example about used `image_tag` method above
* Use bootstrap and custom CSS (use SASS)
* **In Ruby, when the final arguments are hashes in a function call, curly braces {} are optional**
    ``` erbruby
    # Curly braces on fianl hash arguments are optional
    # This:
    stylesheet_link_tag("application", {"data-turbo-track": "reload"})
    
    # is the same as this:
    stylesheet_link_tag("application", "data-turbo-track": "reload")
    ```
* Rails use a facility ***partials*** to divide application layout
* Beside layout, We can split chunks of code using **Partials**.

    In `app/views/layouts/application.html.erb`
    ```rhtml
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
    ``` scss
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
    ```erbruby
    <%= link_to "About", about_path %>
    ```
    - `name_path` -> `/name`
    - `name_url` -> `https://example.com/name`
    - **Note**: 
      > Bởi vì link_to sẽ tự hiểu khi truyền 1 object vào about_path thì Rails sẽ hiểu và tự chuyển đổi
      object thành đường dẫn muốn liên kết đến.
      
      > Cũng có thể dùng chuyển đổi link trong `link_to` method

      **Example:**
      ```erbruby
        <%= link_to "Improve Your Ruby Skills", book_path(@book) %>
      ```
      is the same: 
      ```erbruby
        <%= link_to "Improve Your Ruby Skills", @book %>
      ```
      
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
  > **`200 OK`** - Trả về thành công cho những phương thức GET, PUT, PATCH hoặc DELETE.
  > 
  > **`201 Created`** - Trả về khi một Resource vừa được tạo thành công.
  > 
  > **`204 No Content`** - Trả về khi Resource xóa thành công.
  >   
  > **`304 Not Modified`** - Client có thể sử dụng dữ liệu từ cache (hỗ trợ server giảm tải xử lí request).
  > 
  > **`400 Bad Request`** - Request không hợp lệ.
  > 
  > **`401 Unauthorized`** - Request cần có sự authentication.
  > 
  > **`403 Forbidden`** - Server hiểu request nhưng bị từ chối không cho phép.
  > 
  > **`404 Not Found`** - Không tìm thấy resource từ URI.
  > 
  > **`405 Method Not Allowed`** - Phương thức không cho phép với user hiện tại.
  > 
  > **`410 Gone - Resource`** - không còn tồn tại, version cũ đã không còn hỗ trợ.
  > 
  > **`415 Unsupported Media Type`**
  > 
  > **`422 Unprocessable Entity`** - Dữ liệu không được kiểm chứng.
  > 
  > **`429 Too Many Requests`** - Request bị từ chối do bị giới hạn. 

* Passing local variables in `render` method:

  >   Rails hỗ trợ `render` có thể truyền các `biến local` vào `partial` để chúng thêm mạnh mẽ và linh hoạt. Chúng ta có thể dùng `object` để khai báo 1 `variable` vào `partial`, và as để customize tên biến truyền vào. 
  > 
  >   Ví dụ đơn giản nhất là trong trường hợp tạo mới và chỉnh sửa profile user: ở `views/users/new.html.erb` :

    ```
      #new.html.erb

    <h1>Sign Up</h1>
    <%= render partial: "form", object: @user, as: "user" %>

  ```
  - Ở `views/user/edit.html.erb`:
  ``` rhtml
      #edit.html.erb

      <h1>Editing Profile</h1>
      <%= render partial: "form", object: @user, as: "user" %>
  ```
  và ở `partial _form.html.erb` chúng ta có thể dùng `user` thay cho `@user`:
  ``` rhtml
    <%= form_for user do |f| %>
      <p>
         <b>user name</b><br>
         <%= f.text_field :name %>
      </p>
      <p>
         <%= f.submit %>
      </p>
    <% end %>
  ```
  option as rất thú vị trong trường hợp `render` `partial` ở nhiều chỗ và mỗi chỗ lại có một tên object truyền vào khác nhau. Đấy là trường hợp truyền `1 biến` vào `partial`, còn trong trg hợp biến truyền vào là 1 `tập hợp`, thì chúng ta sẽ dùng `collection` để khai báo.
  ``` erbruby
     <tbody>
         <%= render partial: "user",  collection: @users, as: "user" %>
     </tbody>
  ```
  Về cú pháp không có vấn đề gì, tuy nhiên có vẻ như hơi lặp nhiều từ "user", rails có hỗ trợ cú pháp đơn giản hơn cho trường hợp này:
  ``` erbruby
    <%= render(model: @users) %>
  ```
  Đơn giản đến mức tối đa, nhưng mà làm sao để Rails `hiểu được` chúng ta muốn `render` ra `partial` `_user.html.erb` với 1 loạt biến `@users` và có tên biến chung là `user`? Thực ra thì trong Rails tất cả partial đều mặc định có 1 biến local variable với tên trùng với tên của `partial`, tức là `partial` `_user.html.erb` sẽ luôn có sẵn `local variable` là `user`. Và trong trường hợp trên, Rails sẽ xác định ra `partial` cần `render` thông qua việc tìm từng tên của `model` trong tập hợp các biến đó. Trong trường hợp `collection` trả về `empty`, `render` sẽ trả về giá trị `nil`, cho nên cũng khá đơn giản để đưa ra các nội dung thay thế:
  ``` erbruby
     #(Search) index.html.erb

     <h1>Search Result</h1>
     <%= render(@users) || "Khong co ket qua phu hop!" %>
   ```
  Ngoài ra kỹ thuật Rails `render` nói chung và `render view` khác đa dụng và hữu dụng, còn nhiều kỹ thuật render view khác.
* **Authorization**:
  > In the **context** of web applications, **authentication** allows us to **identify users**
 of our site, while **authorization** lets us **control** what they can do.
  - **Requiring logged-in users**:
    - Used `callback` `before_action` provided by **Active Support**
      ``` ruby
      class UsersController < ApllicationController
        before_action :logged_in_user, {only: [:edit, :update]}
        ..
        ..
        ..
        ..
      
        # Confirms a logged_in user
        def logged_in_user
          unless logged_in?
            flash[:danger] = "Please log in."
            redirect_to(login_url, status: :see_other)
          end
        end
      end
      ```
* **Sample Users**
  * Used `Faker` gem to the `Gemfile`, which will allow us to make sample users with semi-realistic names and addresses
  > Adding the `Faker` gem to the Gemfile:
  > 
  >    `gem "faker"`
    
  > Code for seeding the database with sample users in `db/seeds.rb`
  > 
  ```ruby
     # Create a main sample user.
  
     User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar")
     # Generate a bunch of additional users.
     99.times do |n|
         name = Faker::Name.name
         email = "example-#{n+1}@railstutorial.org"
         password = "password"
         User.create!(name: name, email: email, password: password, password_confirmation: password)
     end
  ```
* Use two commends to reset and constructor sample data:
  > rails db:migrate:reset
  > 
  > rails db:seed 
  > 
* **Pagination:** (trang 676)
    - Problem: My website has _**too many**_ users. And they all appear on the same page.
    
      > **_=> Solution for it:_**
      > 
      > The solution is to _**paginate**_ the users, so that (for example) only 30 show up on a page at any one time.
  
    - Config `Gemfile`:
      > gem "will_paginate"
      > 
      > gem "bootstrap-will_paginate" 
      > 
    - Then run `bundle install` in command line.
    - In `app/views/users/index.html.erb`:
        ```
        <% provide(:title, 'All users') %>
        <h1>All users</h1>
        <%= will_paginate %>
            <ul class="users">
                <% @users.each do |user| %>
                  <li>
                     <%= gravatar_for user, size: 50 %>
                     <%= link_to user.name, user %>
                  </li>
                <% end %>
            </ul>
        <%= will_paginate %>
        ```
    > 1. The `will_paginate` method is a little magical; inside a users view, it
  automatically looks for an `@users` object, and then displays `pagination links`
  to access other pages.
  > 
  >
  > 2. But, the view in code above doesn't work yet, though, because currently `@user` contains the results of `User.all`,
  > whereas `will_paginate` requires that we paginate the results explicitly using the `paginate` method.

* Sử dụng `pagy` gem thay thế cho `will_paginate` gem -> Dùng để hiển thị số lượng người dùng nhất định, giống như hiển thị bài viết nhất định 
  chứ không cần hiển thị cả.
