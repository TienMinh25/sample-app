# Sample app

This document will be description all about my sample-app. 
Below is my daily to-do list

## Chapter 3: _Mostly static pages_

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

## Chapter 4: _Rails-Flavored Ruby_
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

## Chapter 5: *Filling in the Layout*
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

## Chapter 6: _Modeling Users_
#### **Modeling Users**
In Chapter 5, we ended with a stub page for creating new users.

#### User model
#### Database migration
Simple `users` table

| id | name  | email                |
| -- |-------|----------------------|
| 1  | Minh  | letienminh@gmail.com |

A sketch of `users` data model

| field      | type of data |
|------------|--------------|
| id         | integer      |
| name       | string       |
| email      | string       |
| created_at | datetime     |
| updated_at | datetime     |

Generate a User model
```bash
rails generate model User name:string email:string
```
Migrate to database
```bash
rails db:migrate
```
### The model file
Located at `/app/model/`

Play with *sandbox* console: (when exit, nothing was change)
```bash
rails console --sandbox
```
```console
> User.new
=> #<User id: nil, name: nil, email: nil, created_at: nil,
updated_at: nil>

> user = User.new(name: "Michael Hartl", email: "michael@example.com")
=> #<User id: nil, name: "Michael Hartl", email:
"michael@example.com",
created_at: nil, updated_at: nil>

> user.valid?
=> True

> user.save
(0.1ms) SAVEPOINT active_record_1
SQL (0.8ms) INSERT INTO "users" ("name", "email", "created_at",
"updated_at") VALUES (?, ?, ?, ?) [["name", "Michael Hartl"],
["email", "michael@example.com"], ["created_at", "2022-03-11
01:51:03.453035"],
["updated_at", "2022-03-11 01:51:03.453035"]]
(0.1ms) RELEASE SAVEPOINT active_record_1
=> true

> user
=>
#<User:0x00007f666efee260
 id: 1,
 name: "Michael Hartl",
 email: "michael@example.com",
 created_at: Mon, 26 Jun 2023 06:48:30.983122000 UTC +00:00,
 updated_at: Mon, 26 Jun 2023 06:48:30.983122000 UTC +00:00>

> user.name
=> "Michael Hartl"

> user.email
=> "michael@example.com"

> user.updated_at
=> Fri, 11 Mar 2022 01:51:03 UTC +00:00
```
It’s often convenient to make and save a model
in two steps as we have above, but Active Record also lets you combine
them into one step with `User.create`:
```console
> User.create(name: "A Nother", email: "another@example.org")
=>
#<User:0x00007f666c453498
 id: 2,
 name: "A Nother",
 email: "another@example.org",
 created_at: Mon, 26 Jun 2023 06:55:37.444803000 UTC +00:00,
 updated_at: Mon, 26 Jun 2023 06:55:37.444803000 UTC +00:00>
```
### Finding User object
Play with *sandbox* console
```console
> User.find(2)
=>
#<User:0x00007f666c435650
 id: 2,
 name: "A Nother",
 email: "another@example.org",
 created_at: Mon, 26 Jun 2023 06:55:37.444803000 UTC +00:00,
 updated_at: Mon, 26 Jun 2023 06:55:37.444803000 UTC +00:00>
 // or use => it is the same
> User.find_by(id: 2)
```
- **_Note:_**
  `find` method khác `find_by` method ở chỗ, `find` khi không tìm thấy thì sẽ `raise` ra 1 `exception`,
  còn `find_by` thì trả về `nil`.
### Updating User object
```rb
user.name = "New name"
user.save()

user.update_attribute(:email, "new@email.com")
```

## User Validation
### Validating presence
Use `validates` method to make an attribute "cannot be empty"
```rb
class User < ApplicationRecord
  validates(:name, presence: true)
end
```
Check error message
```rb
user.errors.full_messages
```
### Validate length
Limit the length of an attribute
```rb
validates(:email, presence: true, length: { maximum: 255 })
```
### Format validation
Example: `email` need format validation
```rb
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates(:email, format: { with: VALID_EMAIL_REGEX })
```
Break down the `VALID_EMAIL_REGEX`
| Expression    | Meaning           |
| ------------- | ----------------- |
| /             | tart of regex     |
| \A            | match start of a string   |
| [\w+\-.]+     | at least one word character, plus, hyphen, or dot |
| @             | literal "at sign" |
| [a-z\d\-.]+   | at least one letter, digit, hyphen, or dot    |
| \.            | literal dot       |
| [a-z]+        | at least one letter   |
| \z            | match end of a string |
| /             | end of regex      |
| i             | case-insensitive  |

### Uniqueness validation
To enforce uniqueness of an attribute.
```rb
validates(:email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true)
```
The uniqueness validation is case-sensitive
```console
> user = User.create(name: "Example User", email:
"user@example.com")
> user.email.upcase
=> "USER@EXAMPLE.COM"
> duplicate_user = user.dup
>duplicate_user.email = user.email.upcase
> duplicate_user.valid?
=> true
```
Fix
```rb
uniqueness: { case_sensitive: false }
```
#### Ensuring email uniqueness by downcasing the email attribute
```rb
class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
end
```

#### Database indixes
In the present case, we are adding structure to an existing model, so we
need to create a migration directly using `migration` generator:
```bash
rails generate migration add_index_to_users_email
```
In `db/migrate/[timestamp]_add_index_to_users_email.rb`
```rb
class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: true
  end
end
```

#### Adding a secure password
#### A hashed password
`has_secure_password` method.

This one method adds the following functionality:
- The ability to save a securely hashed `password_digest` attribute to the
  database
- A pair of virtual attributes: `password`and `password_confirmation`
- An `authenticate` method that returns the user when the password is
  correct
> Requirement for `has_secure_password`: The corresponding model to have
> an attribute called `password_digest`.

> `has_secure_password` uses a state-of-the-art hash function called `bcrypt`

#### Minimum password standards
```rb
validates :password, presence: true, length: { minimum: 6 }
```
#### Create and authenticating User
```rb
User.create(name: "Tuslipid", email: "tuslipid@tus.com", password: "tuslipid", password_confirmation: "tuslipid")
```
```console
> user.authenticate("lmao")
false
> user.authenticate("correct pw")
#<User:0x00007f39fbeef020
 id: 4,
 name: "Tuslipid",
 email: "tuslipid@tus.com",
 created_at: Mon, 26 Jun 2023 08:35:18.469445000 UTC +00:00,
 updated_at: Mon, 26 Jun 2023 08:35:18.469445000 UTC +00:00,
 password_digest: "[FILTERED]">
```
## Chapter 7: _Sign Up_

#### Showing Users
### Debug and Rails environment
```erb
<%= debug(params) if Rails.env.development? %>
```
### A Users resource
Make a user profile page, following REST architecture.

Get the routing for `/user/1` to work by adding a single line to our routes
file `config/routes.rb`
```rb
resource :users
```
**RESTful routes table for Users resource**

| HTTP request method    | URL           | Action    | Named route           |                          Purpose |
|:-----------------------| ------------- | --------- | --------------------- |---------------------------------:|
| GET                    | /users        | index     | users_path            |           page to list all users |
| GET                    | /users/1      | show      | user_path(user)       |                page to show user |
| GET                    | /users/new    | new       | new_user_path         | page to make a new user (signup) |
| POST                   | /users        | create    | users_path            |                create a new user 
| GET                    | /users/1/edit | edit      | edit_user_path(user)  |      page to edit user with id 1 |
| PATCH (PUT)            | /users/1      | update    | user_path(user)       |                      update user |
| DELETE                 | /users/1      | destroy   | user_path(user)       |                      delete user |

**Show user in html.erb**
```rb
def show
    @user = User.find_by(params[:id])
end
```
```erb
<%= @user.name %>, <%= @user.email %>
```
### Debugger
```rb
def show
    @user = User.find_by(params[:id])
    debugger
end
```
The Rails console server shows an `rdbg` prompt
```console
(rdbg)
(rdbg) @user
(rdbg) @user.name
```

### A Gravatar Image and a Sidebar
`Gravatar`: globally recognized avatar - a free service that allows users
to upload images and associate them with email addresses they control

`gravatar_for`: a custom helper function to return a Gravatar image for a given user.
```erb
<!-- app/views/users/show.html.erb -->
<% provide(:title, @user.name) %>
<h1>
    <%= gravatar_for @user %>
    <%= @user.name %>
</h1>
```
Because `Rails` understands and automatically converts the object to the link in method for link.
```rb
# app/helpers/users_helper.rb

def gravatar_for(user)
    gravatarId = Digest::MD5::hexdigest(user.email.downcase)
    gravatarUrl = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatarUrl, alt: user.name, class: "gravatar")
end
```
Add a sizebar to the user `show` view
```erb
<!-- app/views/users/show.html.erb -->
<% provide(:title, @user.name) %>
<div class="row">
    <aside class="col-md-4">
        <section class="user_info">
            <h1>
                <%= gravatar_for @user %>
                <%= @user.name %>
            </h1>
        </section>
    </aside>
</div>
```

## Signup form
### Using `form_with`
```erb
<%= form_with(model: @user) do |f| %>
    <%= f.label :name %>
    <%= f.text_field :name %>
    
    <%= f.label :email %>
    <%= f.email_field :email %>
    
    <%= f.label :password %>
    <%= f.password_field :password %>
    
    <%= f.label :password_comfirmation, "Confirmation" %>
    <%= f.password_field :password_comfirmation %>
    
    <%= f.submit "Create my account", class: "btn btn-primary" %>
<% end %>
```
### Get parameters from form
```rb
def create
    @user = User.new(params[:users])

    if @user.save
      # Handle a successful save
    else
      render 'new', status: :unprocessable_entity
    end
end
```
```rb
# params[:users]
"user" => { "name" => "Foo Bar",
            "email" => "foo@invalid",
            "password" => "[FILTERED]",
            "password_confirmation" => "[FILTERED]"
           }
```
### Strong parameters
Permits some parameters instead of all
```rb
params.require(:user).permit(:name, :email, :password, :password_confirmation)
```
### Signup error messages
```rb
@user.errors.any?
@user.errors.count
@user.errors.empty?
@user.errors.full_messages
```
### The finished signup form
At user `create` action
```rb
if @user.save
    redirect_to @user
    # or redirect_to user_url(user)
else
    ...
end
```
### Flash messages
In controller
```rb
flash[:type] = "Message"
```
In html.erb
```erb
<% flash.each do |message_type, message| %>
    <div class="alert alert-<%= message_type %>">
        <%= message %>
    </div>
<% end %>
```
## Chapter 8: _Basic Login_

## Sessions
### Sessions Controller
```bash
rails generate controller Sessions new
```
Add `/login`, `/logout` routes
```rb
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
```
Update appropriate controller's actions and views

```erb
form_with(url: login_path, scope: :session)
```

```
#<ActionController::Parameters
{"authenticity_token"=>"…",
"session" =>#<ActionController::Parameters
            {"email"=>"user@example.com",
            "password"=>"foobar"} permitted: false>,
            "commit"=>"Log in",
            "controller"=>"sessions",
            "action"=>"create"} permitted: false>
```
### Authenticate user
```rb
if user && user.authenticate(params[:session][:password])
    # Handle log in
else
    # Return error
end
```
### Add flash message
We can add
```rb
flash[:danger] = 'Invalid email/password combination'
```
But it isn't quite right, if we redirect to a different route after getting
the flash message, it is till there.

Fix this issue by
```rb
flash.now[:danger] = 'Invalid email/password combination'
```

## Logging in
Include the Sessions helper module into the Application controller
```rb
class ApplicationController < ActionController::Base
    include SessionsHelper
end
```
### `log_in()` method
```rb
# app/helpers/session_helper.rb
def log_in(user)
    session[:user_id] = user.id
end
```
> Because temporary cookies created using the session method are
> automatically encrypted, the code is secure.
### Current user
We'll define `current_user` method

In `html.erb`
```erb
<%= current_user %>
```
In controller
```rb
redirect_to current_user
# or
redirect_to user_path(current_user)
```

```rb
# app/helpers/session_helper.rb
def current_user
    if session[:user_id]
        User.find(id: session[:user_id])
    end
end
```
To prevent hitting the database multiple times
```rb
if @current_user.nil?
    @current_user = User.find(id: session[:user_id])
else
    @current_user
end

or

@current_user = @current_user || User.find(id: session[:user_id])

or

@current_user ||= User.find(id: session[:user_id])
```
### Changing layout links
Add `logged_in` helper function
```rb
# app/helpers/session_helper.rb
def logged_in?
    !current_user.nil?
end
```
```erb
<% if logged_in? %>
    # Links for logged-in users
<% else %>
    # Links for non-logged-in-users
<% end %>
```
### Menu toggle
```bash
rails importmap:install turbo:install stimulus:install
```

## Logging out
```rb
session.delete(:user_id)
```
Better technique
```rb
# app/helpers/session_helper.rb
def log_out
    reset_session
    @current_user = nil
end

# app/controllers/session_controller.rb
def destroy
    log_out
    redirect_to root_url
end
```
## Chapter 9: _Advanced Login_

## Remember me
### Remember token and digest
> The previous chapter's session disappears when the users close their browser

We'll take the first step toward persistent sessions by generating a
*remember token* appropriate for creating permanent cookies using the
`cookies` method, together with a secure *remember digest* for
authenticating those tokens.

Plan:
1. Create a random string as a remember token.
2. Place the token in the browser cookies.
3. Save the hash digest of the token to the database.
4. Place an encrypted version of the user's id in the browser cookies.
5. When presented with a cookie containing a persistent user id, find the
   user in the database using the given id, and verify that the remember token
   cookie matches.

Add the `remember_digest` attribute to the User model
```bash
rails generate migrationadd_remmeber_digest_to_users remember_digest:string
```

In `app/models/user.rb`

Add a method for generating tokens
```rb
def self.new_token
    SecureRandom.urlsafe_base64
end
```

Add a digest method to hash the remember token

The password is created using bcrypt (via `has_secure_password`), so we'll
need to create the fixture password using the same method.

```rb
def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
      BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
end
```
Add a remember method to remember user to the databse
```rb
def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
end
```
### Login with remembering
Make a persistent session by creating a cookie
```rb
cookies[:remember_token] = {
    value: remember_token,
    expires: 20.years.from_now.utc
}

cookies.permanent[:remember_token] = remember_token # Same as above
```
Store id to cookie
```rb
cookies[:user_id] = user.id
cookies.encrypted[:user_id] = user.id # better
cookies.permanent.encrypted[:user_id] = user.id # to be paired with remember token
```
We can retrieve user by
```rb
User.find_by(id: cookies.encrypted[:user_id])
```
To compare the `remember_token` in cookie with the `remember_digest` in
the databse
```rb
BCrypt::Password.new(remember_digest).is_password?(remember_token)
```
### Forgetting users
At User model
```rb
update_attribute(:remember_digest, nil)
```
Delete cookies
```rb
cookies.delete(:user_id)
cookies.delete(:remember_token)
```
### Some checknotes
- Multiple browsers logged in case: Be careful when users hit log out.
- `remember_digest` must exist in database to be compared with `remember_token`

## "Remember me" checkbox
Get value from checkbox form
```rb
params[:session][:remember_me]
```
- `1`: The box is checked
- `0`: The box isn't checked
```rb
if params[:session][:remember_me] == '1'
    remember(user)
else
    forget(user)
end
```
## Chapter 10: _Updating, Showing and Deleting User_
* Completed the REST actions for the Users resource(**_edit, update, index, destroy_** actions)
* Refer to the following table below:
  
  **Restful Route in Rails** (This is the standard)
  Ứng dụng theo chuẩn `RESTful` sẽ coi web như một `resource`. Về cơ bản sẽ có 7 loại action mà bạn có thể làm với `resource`.

  > GET: index, show, new và edit
  > 
  > POST: create
  >
  >PUT: update
  >
  >DELETE: destroy

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

## **_Chapter 11: Account Activation_**
### **_Mailer_**: (Action Mailer Library)
------------------------------------------------
  > `Mailers` are structured much like controller actions, with email templates defined as `views`. These
  templates will include `links` with the `activation token` and `email address`
  associated with the account to be `activated`.
  >
  1. `Mailer Template`:
    
     1. We can `generate` a `mailer` using `rails generate`:
       ```bash
       rails generate mailer UserMailer account_activation password_reset
       ```
        Con viet nua o day
### **_Query parameter_**
---------------------------------------------
* Query parameter, which in a URL appears as a key-value pair located after a question mark.
    > account_activations/q5lt38hQDc_959PVoo6b7A/edit?
  email=foo%40example.com
* **_Note:_**
    * `@` in the email address appears as `%40`, i.e., it’s “escaped
      out” to guarantee a valid URL.
* The way to set a query parameter in Rails is to include a hash in the named route:
    ```ruby
      edit_account_activation_url(@user.activation_token, email:@user.email)
    ```
* When using `named routes` in this way to define `query parameters`, Rails
automatically `escapes out` `any special characters`. The resulting email address
will also be `unescaped automatically` in `the controller`, and will be available
via `params[:email]`.

### **_Email preview:_**
-------------------------------------------------------
In `app/views/user_mailer/account_activation.text.erb`:
```erbruby
    Hi <%= @user.name %>,
    Welcome to the Sample App! Click on the link below to activate your account:
    <%= edit_account_activation_url(@user.activation_token, email: @user.email) %>
```
In `app/views/user_mailer/account_activation.html.erb`:
```erbruby
  <h1>Sample App</h1>
  <p>Hi <%= @user.name %>, </p>
  <p>
  Welcome to the Sample App! Click on the link below to activate your account:
  </p>
  <%= link_to "Activate", edit_account_activation_url(@user.activation_token, email: @user.email) %>
```
* To see result of the templates defined above, we can use `**_email previews_**`
    * `Email setting` in development: (`config/environments/development.rb`):
        ```ruby
            Rails.application.configure do
            .
            .
            .
            config.action_mailer.raise_delivery_errors = false
            host = 'example.com' # Don't use this literally; use your local
            host instead.
            # Use this on the cloud IDE.
            config.action_mailer.default_url_options = { host: host,
            protocol: 'https' }
            # Use this if developing on localhost.
            # config.action_mailer.default_url_options = { host: host,
            protocol: 'http' }
            .
            .
            .
            end
        ```
    * After `restarting` the `development server` to `activate` the `configuration`, we next need to `update` the User mailer `preview file`, which was automatically generated by command line:
        ```bash
            rails generate mailer UserMailer account_activation password_reset
        ```
      In `test/mailers/previews/user_mailer_preview.rb`:
        ```ruby
         # Preview all emails at
        http://localhost:3000/rails/mailers/user_mailer
        class UserMailerPreview < ActionMailer::Preview
        # Preview this email at
        #
        http://localhost:3000/rails/mailers/user_mailer/account_activation
            def account_activation
                user = User.first
                user.activation_token = User.new_token
                UserMailer.account_activation(user)
            end
        # Preview this email at
        # http://localhost:3000/rails/mailers/user_mailer/password_reset
            def password_reset
                UserMailer.password_reset
            end
        end
       ``` 
      
# Account activation

Strategy:
1. Start users in an "unactivated" state.
2. When a user signs up, generate an activation token and corresponding activation
digest
3. Save the activation digest to the database, and then send an email to the user with
a link containing the activation token and user's email address.
4. When the user clicks the link, find the user by email address, and then authenticate
the token by comparing with the activation digest.
5. If the user is authenticated, change the status from "unactivated" to "activated"

Analogy between login, remembering, account activation, pw reset:
| Method                | find_by   | String            | Digest            | Authentication        |
| --------------------- | --------- | -------------     | -------------     | --------------------- |
| login                 | email     | password          | password_digest   | authenticate (pw)     |
| remember me           | id        | remember_token    | remember_digest   | authenticated?(:remember, token)      |
| account activation    | email     | activation_token  | activation_digest | authenticated?(:activation, token)    |
| password reset        | email     | reset_token       | reset_digest      | authenticated?(:reset, token) |

## Account Activations Resource
### Account Activations controller
```bash
rails generate controller AccountActivations
```
Adding a route for the Account Activations `edit` action
```rb
resources :account_activations, only: [:edit]
```
### Account Activations data model
We need a unique activation token for use in the activation email.
```rb
user.activation_token
```
Authenticate the user with code like
```rb
user.authenticated?(:activation, token)
```
Add a boolean attribute `activated` to the model, which will allow us to test if an
user is activated
```rb
if user.activated?
```
The model finally looks like:
|                   |           |
| ----------------- | --------- |
| id                | integer   |
| name              | string    |
| email             | string    |
| created_at        | datetime  |
| updated_at        | datetime  |
| password_digest   | string    |
| remember_digest   | string    |
| admin             | string    |
| activation_digest | string    |
| activated         | boolean   |
| activated_at      | datetime  |

```bash
rails generate migration add_activation_to_users \
> activation_digest:string activated:boolean activated_at:datetime
```
### Activation token callback
```rb
before_create :create_activation_digest
.
.
.
def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
end
```

## Account activation emails
```bash
rails generate mailer UserMailer account_activation password_reset
```
URL pattern
```rb
edit_account_activation_url(@user.activation_token, @user.email)
```
```
http://www.example.com/account_activations/q5lt38hQDc_959PVoo6b7A/edit?email = foo%40example.com
```
Update mailer views
```erb
<!-- app/views/user_mailer/account_activation.text.erb -->
Hi <%= @user.name %>,
Welcome to the Sample App! Click on the link below to activate your
account:
<%= edit_account_activation_url(@user.activation_token, email:
@user.email) %>

<!-- app/views/user_mailer/account_activation.html.erb -->
<h1>Sample App</h1>

<p>Hi <%= @user.name %>, </p>

<p>
  Welcome to the Sample App! Click on the link below to activate your
  account:
</p>

<%= link_to "Activate",
  edit_account_activation_url(@user.activation_token,
  email: @user.email) %>
```
### Preview email
```rb
# config/environments/development.rb
Rails.applcation.configure do
    .
    .
    .
    config.action_mailer.raise_delivery_errors = false

    localhost = 'domain.com' # In local development, use localhost:3000 instead
    # Use this on the cloud IDE.
    config.action_mailer.default_url_options = { host: localhost, protocol: 'https' }
    # Use this if developing on localhost.
    # config.action_mailer.default_url_options = { host: host, protocol: 'http' }
    .
    .
    .
end
```
```rb
# test/mailers/previews/user_mailer_preview.rb
def account_activation
  user = User.first
  user.activation_token = User.new_token
  UserMailer.account_activation(user)
end
```
### Update the Users `create` action
```rb
def create
  if @user.save
    UserMailer.account_activation(@user).deliver_now
    flash[:info] = "Please check your email to activate your account"
    redirect_to root_url
  else
    ...
```

## Activating the account
### Generalizing the `authenticated?` method
```rb
user = User.find_by(email: params[:email])
if user && user.authenticated?(:activation, params[:id])
```
```rb
def authenticated?(attribute, token)
  digest = self.send("{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token)
end
```
### Activation `edit` action
```rb
if user && !user.activated? && user.authenticated?(:activation, params[:id])
```
If the user is authenticated according to the booleans above, we need to activate the
user and update the `activted_at` timestamp.
```rb
user.update_attribute(:activated, true)
user.update_attribute(:activated, Time.zone.now)
```
Show only mail-activated user


### app/controllers/users_controller.rb



# Chapter 12: Password reset

## Password Resets Controller
- Generate controller `PasswordResets` 
```bash
  rails generate controller PasswordResets new edit --no-test-framework
```
- Adding a link `forgot_password` in `app/views/sessions/new.html.erb`:
```erb
  <% provide(:title, t("sessions.login")) %>
  <h1><%= t("sessions.login") %></h1>

<div class="row">
  <div class="col-md-6 col-md-offset-3">
    <%= form_with(url: login_path, scope: :session) do |f|%>
      <%= f.label(:email) %>
      <%= f.email_field(:email, class: 'form-control') %>

      <%= f.label(:password) %>
      <%= link_to("forgot password", new_password_reset_path)%>
      <%= f.password_field(:password, class: 'form-control') %>

      <%= f.label(:remember_me, class: "checkbox inline") do %>
        <%= f.check_box(:remember_me) %>
        <span>Remember me on this computer</span>
      <%end %>

      <%= f.submit("Log in", class: 'btn btn-primary') %>
    <%end %>
    <p>New User ? <%= link_to("Sign up now!", signup_path) %></p>
  </div>
</div>
```
- Adding a resource for password resets, in `config/routes.rb`:
```ruby
  Rails.application.routes.draw do
      scope "(:locale)", locale: /en|vi/ do
        root "static_pages#home"
        get '/help', to: 'static_pages#help'
        get '/about', to: 'static_pages#about'
        get '/contact', to: 'static_pages#contact'
        get '/signup', to: 'users#new'
        get '/login', to: 'sessions#new'
        post '/login', to: 'sessions#create'
        delete '/logout', to: 'sessions#destroy'
        get 'account_activations/edit_account_activation_url'
        resources :users
        resources :account_activations, only: [:edit]

        resources :password_resets, only: [:new, :create, :edit, :update]
    end
  end
```

RESTful routes provided by the Password Resets resource:
---------------------------------------------------
| HTTP request method | URL | Action | Named route|
|:--------------------|-----|--------|-----------:|
|GET|/password_resets/new|new|new_password_reset_path|
|POST|/password_resets|create|password_resets_path|
|GET|/password_rests/token/edit|edit|edit_password_reset_url(token)|
|PATCH|/password_resets/token|update|password_reset_path(token)|

* In here, use `edit_password_reset_url(token)` instead of the `_path` form because we want to use it for gmail.

## New Password Resets

* The User model with added `password reset` attributes

    |Users  |Type   |
    |:----  |------:|
    |id     |integer| 
    |name|string|
    |email|string|
    |created_at|datetime|
    |updated_at|datetime|
    |password_digest|string|
    |remember_digest|string|
    |admin|boolean|
    |activation_digest|string|
    |activated|boolean|
    |activated_at|datetime|
    |reset_digest|string|
    |reset_sent_at|datime|

* The `migration` to add attributes above:
```bash
  rails generate migration add_reset_to_users reset_digiest:string reset_sent_at:datetime
```
* And execute it to update database:
```bash
  rails db:migrate
```

* A new password reset view, in `app/views/password_resets/new.html.erb
```erb
<% provide(:title, "Forgot password")%>
<h1>Forgot password</h1>

<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <%= form_with(url: password_resets_path, scope: :password_reset) do |f| %>
            <%= f.label(:email)%>
            <%= f.email_field(:email, class: "form-control")%>

            <%= f.submit("Submit", class: "btn btn-primary")%>
        <% end %>
    </div>
</div>

```

## Resetting the Password
- The form to reset a password (`app/views/password_resets/edit.html.erb`)
```erb
  <% provide(:title, 'Reset password') %>
<h1>Reset password</h1>

<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <%= form_with(model: @user, url: password_reset_path(params[:id])) do |f| %>
            <%= render 'shared/error_messages' %>

            <%= hidden_field_tag :email, @user.email %>

            <%= f.label :password %>
            <%= f.password_field :password, class: 'form-control' %>

            <%= f.label :password_confirmation, "Confirmation" %>
            <%= f.password_field :password_confirmation, class: 'form-control' %>
            
            <%= f.submit "Update password", class: "btn btn-primary" %>
        <% end %>
    </div>
</div>
```
# Conf nua

# Chapter 13: User Microposts

## The Basic Model Microposts

|Microposts|Type    |
|:---------|-------:|
| id       |integer |
|content   |text    |
|user_id   |integer |
|created_at|datetime|
|updated_at|datetime|

### Generating the Micropost model
```bash
rails generate model Micropost content:text user:references
```
=> Code in file `db/migrate/[timestamp]_create_microposts.rb`
```rb
class CreateMircoposts < ActiveRecord::Migration[7.0]
  def change
    create_table :mircoposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

### The Micropost migration with added index.
```rb
class CreateMicroposts < ActiveRecord::Migration[7.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
```

### Micropost Validations
In `app/model/microposts.rb`
```rb
class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
```
### User/Microposts Associations
We use 
> user.microposts.create
>
> user.microposts.create!
>
> user.microposts.build

instead of

> Micropost.create
>
> Micropost.create!
>
> Micropost.new

Table in below is a summary of `user/micropost` association methods
|Method|Purpose |
|:-----|-------:|
|micropost.user|returns the User object associated with the micropost|
|user.microposts|returns a collection of the user's microposts|
|user.microposts.create(arg)|creates a micropost associated with `user`
|user.microposts.create!(arg)|creates a micropost associated with `user` (exception on failure)
|user.microposts.build|returns a new Micropost object associated with `user`|
|user.microposts.find_by(id: 1)|finds the micropost with id `1` and `user_id` equal to user.id|

To have associated between `microposts` and `users`, we need to added `belongs_to :user` in `app/models/microposts.rb`(was generated), after that, we added `has_many :microposts` in `app/models/user.rb`:
```rb
class User < ApplicationRecord
  has_many :microposts
  .
  .
  .
  .
  .
end
``` 

## Micropost Refinements

### Associations
### **1. Why Associations?**
* In `Rails`, an `association` is a connection between two `Active Record models`. 
* For instance, consider a simple Rails application that includes a model for authors and a model for books. Each author can have many books. Without associations, the model declarations would look like this:
  ```rb
  class Author < ApplicationRecord
  end

  class Book < ApplicationRecord
  end
  ```
  Now, suppose we wanted to add a new book for an existing author. We'd need to do something like this:
  ```rb
  @book = Book.create(created_at: Time.zone.now, author_id: @author.id)
  ```
  Or when we wanted to delete an author, and ensured that all of its books got deleted as well:
  ```rb
  @books = Book.where(author_id: @author.id)
  @books.each do |book|
    book.destroy
  end
  @author.destroy
  ```

  And now, with Active Record associations, we can streamline these - and other - operations by declaratively telling Rails that there is a connection between the two models :D that's much easy!!!
  ```rb
  class Author < ApplicationRecord
    has_many :books, dependent: :destroy
  end

  class Book < ApplicationRecord
    belongs_to :author
  end
  ``` 
  With this change, creating a new book for a particular author is easier:
  ```rb
  @book = @author.books.create(created_at: Time.zone.now)
  ```
  Deleting an author and all of its books is _much_ easier:
  ```rb
  @author.destroy
  ```

  Now we see :)) it's very easy when use `association` in `Rails`.

### **2.Types of Associations:**
`Rails` supports six types of associations:
- `belongs_to`
- `has_one`
- `has_many`
- `has_many :through`
- `has_one :through`
- `has_and_belongs_to_many`






# **_Some additional knowledge:_**
## 1. What is different between `flash.now` and `flash`:

    > `flash`: `redirection`, for the `next request`
    > 
    >`flash.now`: `render template only`, for the `same request`


## 2. Với web nói chung thì session vs cookie là gì? 
## Cơ chế làm việc khi browser giao tiếp với server?
## Trong rails cookie vs cookie.encrypted khác nhau như nào? Trường hợp áp dụng?
Trong rails có những cơ chế lưu trữ session nào? Mặc định là gì?
- Với web nói chung thì `sesson` và `cookie` là dùng để lưu trữ dữ liệu.
- Cơ chế làm việc của browser giao tiếp với server là: (giả sử trong trường hợp đã đăng nhập và được cấp token)
    > Browser sẽ gửi http **`request`** lên cho server, server xác thực qua token được gửi cùng với http header, sau đó server sẽ dựa theo request và đi theo **`router`**, sẽ cho biết chuyển đến **`controller`** nào và **`action`** gì, sau đó **`server`** đựa vào đó để xử lí và trả lại **`response`** cho browser.

    
* Trong Rails `cookie` sẽ trả ra dữ liệu nguyên gốc cho trước khi gửi cho browser, còn `cookie.encrypted` thì mã hóa dữ liệu trước khi gửi đi. Trường hợp áp dụng cho `cookie` là wesite đó không cần đăng nhập hay không cần authenticate, là 1 trang web mở và mọi người đều có thể truy cập. Còn `cookie.encrypted` thường dùng cho mục đích ngăn không cho người dùng đọc được thông tin và nâng cao tính bảo mật.

* Trong Rails có 3 cơ chế lưu trữ session: `CookieStore`, `ActiveRecord`, `RedisStore`. Mặc định sẽ dùng `CookieStore` để lưu trữ `session data`.

* Sự khác biệt giữa 3 cơ chế:
 > Với cơ chế **`CookieStore`**, thì toàn bộ **`session data`** và **`session id`** sẽ được lưu trữ trong **`cookie`** ở phía client. Do đó server không phải lưu trữ bất kì thông tin nào liên quan đến session và chỉ cần đọc từ **`cookie`** do client gửi kèm theo mỗi request.

 > Với cơ chế **`ActiveRecord`** thì sẽ lưu trữ **`Session ID`** ở cookie, còn dữ liệu về **`session data`** thì được lưu trữ ở database.

 > Với cơ chế **`RedisStore`** thì cũng gần giống với cơ chế **`ActiveRecord`**, tuy nhiên **`session data`** được lưu trữ ở database thì sẽ sử dụng 1 cơ sở dữ liệu có dạng key-value, có điểm mạnh là tốc độ đọc và ghi.

 ## 3. Different between resource and resources

 _**Resource**_
- `resource`: chỉ tạo ra 6 action là `new`, `edit`, `show`, `update`, `destroy`, `create`.
- Trong đường dẫn của resource thì không có `:id`, ví dụ: `user/edit/`, vì resource thì được hiểu là 1 tài nguyên, nên chỉ cần 1 đường dẫn như vậy là được.

_**Resources**_
- `resources`: tạo ra 7 action tiêu chuẩn theo RESTful, là `index`, `new`, `edit`, `show`, `create`, `update`, `destroy`.
- Trong đường dẫn của resources thì có thể có `:id` để lấy `id` người dùng, ví dụ: `users/:id/edit`, vì resources được hiểu là nhiều tài nguyên, vì vậy mà cần có `:id` để query data.

_**Cơ chế hoạt động của turbo-method ở đây là gì, tại sao lại logout được?**_
```erb
   <%= link_to("Log out", logout_path, data: {"turbo-method": :delete}) %>
```

* Cơ chế của `turbo-method` ở đây là sẽ do browser khi gửi request chỉ hỗ trợ 2 phương thức POST và GET, vậy nên `turbo-method` ở đây sẽ là sửa đổi lại phương thức `POST` thành `DELETE` để `server` có thể xử lí theo method `delete` và theo `action` `destroy`.

## 4. So sánh sự khác nhau giữa update, update_columns, update_column, update_attribute, update_attributes trong rails
- Ngoài `update_columns` còn có các method khác là `update`, `update_attributes`, `update_attribute`, update_column`.
- So sánh:
   - `update(id, attributes):`
         - Là 1 `public method` gọi trực tiếp từ `model class`. Có `2 tham số `truyền vào là `id` và `1 hash` các `attributes`. Hàm này `update` các `attributes` của `record chứa id` tương ứng.

       
         # Ví dụ:
         User.update(1, {name: "Le Van Tien Minh", email: "abc@gmail.com"})
   

  - `update_attributes(attributes):`
         - Hàm này được gọi từ 1 `object` của `model class`. Hàm này thực hiện `update` tất cả các `attributes` được 
         truyền vào từ params của 1 object nếu `pass validate`.
       
         # Ví dụ:
         user = User.find_by id:1
         user.update_attributes name: "Canh", email: "abc@gmail.com"
      
  - `update_attribute(name, value):`
         - Hàm này được gọi từ 1 `object` của `model class`. Hàm này chỉ có thể `update` 1 `attribute` của `object` đó.

         Tuy nhiên hàm này có 1 số lưu ý sau:

          - Trường được `update` sẽ bỏ qua `validate`.
          - Callback vẫn chạy
          - `updated_at` vẫn được cập nhật
  - `update_columns(attributes):`
         - Hàm này tương tự như `update_attributes` method, tuy nhiên hàm này `update` trực tiếp vào DB. Và:

          - Bỏ qua validate
          - Callback không được thực thi
          - `updated_at` không được cập nhật
  - `update_column(name, value):`
         - Hàm này được gọi từ 1 `object` của model class, nó cũng `update` trực tiếp vào DB. Tuy nhiên hàm này có 
         1 số lưu ý sau:  

          - Bỏ qua validate
          - Bỏ qua callback
          - Gọi cập nhật `updated_at`
 
Ngoài ra, còn có hàm `update!(id, attributes)` và `update_attributes!(attributes)`, nhưng chỉ khác nhau khi trả về, các hàm này sẽ `raise  exception` nếu không `update` thành công, còn hàm `update` và `update_attributes` sẽ trả về false nếu không `update` thành công.
 
## 5. Filters vs Callbacks in Rails
* **Filters**: Filters are methods that are run before, after or "around" a **_controller_** action.

  * **_before_action_**: Before filters are run on requests before the request gets to the controller’s action 
  * **_ater_action_**: After filters are run after action completes
  * **_around_action_**: Around filters may have logic before and after the action being run. `Can use around filters` for `exception handling`, `setup and teardown`, and a myriad of other cases.

* **Callbacks**: Callbacks allow you to trigger logic before or after an alteration of an object's state in _model_.

It is possible to write code that will run whenever an `Active Record` object is `created`, `saved`, `updated`, `deleted`, `validated`, or `loaded` from the `database`.

**Creating an Object**
> before_validation
> 
> after_validation
>
> before_save
> 
> around_save
>
> before_create
>
> around_create
>
> after_create
> 
> after_save
>
> after_commit/after_rollback

**Updating an Object**
> before_validation
>
> after_validation
>
> before_save
>
> around_save
>
> before_update
>
> around_update
> 
> after_update
>
> after_save
>
> after_commit/after_rollback

**Destroying an Object**
> before_destroy
>
> around_destroy
>
> after_destroy
>
> after_commit/after_rollback

## Scope in Rails (must be figure out)



## Reset databse and reseed the database:
The command line in below:
```bash
rails db:migrate:reset
rails db:seed
```

