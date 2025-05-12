# README

Ruby on Rails Getting Started docs: https://guides.rubyonrails.org/getting_started.html

Checkpoint: https://guides.rubyonrails.org/getting_started.html#adding-authentication

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Getting Started
* Ruby 3.3.6
* Rails 8.0.1

Reference: https://guides.rubyonrails.org/install_ruby_on_rails.html

## Database Modeling
* Generate Active Record model example: `bin/rails generate model Product name:string`

Reference: https://guides.rubyonrails.org/getting_started.html#creating-a-database-model

### Running Migrations
* Run `bin/rails db:migrate`

## Rails Console
* Run `bin/rails console`

Reference: https://guides.rubyonrails.org/getting_started.html#rails-console

### Reload Changes
* Run this command if you have modified your codes but still keeping the console open and want to see the reflected changes: `reload!`

## Rails Routing
![Rails Routing in MVC](./docs/assets/rails-routing-mvc.jpg "Rails Routing in MVC")

* To define the routes, modify the `config/routes.rb`, example:
  ```ruby
  Rails.application.routes.draw do
    get "/products", to: "products#index"
  end
  ```
* To create all CRUD routes for specific route like `/products`, we can just register it like this instead:
  ```ruby
  resources :products
  ```

Reference: https://guides.rubyonrails.org/getting_started.html#routes

### Routes Generation
* Generate the controller command: `bin/rails generate controller Products index --skip-routes`

### Routes Helper Methods
* Run `bin/rails routes`
* Output example:
  ```
                                    Prefix Verb   URI Pattern                                                                                       Controller#Action
                                                /assets                                                                                           Propshaft::Server
                      rails_health_check GET    /up(.:format)                                                                                     rails/health#show
                                products GET    /products(.:format)                                                                               products#index
                            products_new GET    /products/new(.:format)                                                                           products#new
                                         POST   /products(.:format)                                                                               products#create
                                         GET    /products/:id(.:format)                                                                           products#show
                                         GET    /products/:id(.:format)                                                                           products#edit
                                         PATCH  /products/:id(.:format)                                                                           products#update
                                         PUT    /products/:id(.:format)                                                                           products#update
                                         DELETE /products/:id(.:format)                                                                           products#destroy
  ```
* Helpers methods:
  * `products_path` generates "/products"
  * `products_url` generates "http://localhost:3000/products"
  * `product_path(1)` generates "/products/1"
  * `product_url(1)` generates "http://localhost:3000/products/1"

* `_path` returns a relative path which the browser understands is for the current domain.
* `_url` returns a full URL including the protocol, host, and port.

* Combined with the `link_to` helper, we can generate anchor tags and use the URL helper to do this cleanly in Ruby. `link_to` accepts the display content for the link (`product.name`) and the path or URL to link to for the href attribute (`product`).

## CRUD

### Create
* Create `app/views/products/new.html.erb` view.
* Use `form_with` helper to generate the form:
  ```erb
  <h1>New product</h1>

  <%= form_with model: @product do |form| %>
    <div>
      <%= form.label :name %>
      <%= form.text_field :name %>
    </div>

    <div>
      <%= form.submit %>
    </div>
  <% end %>
  ```
* Create `create` action and strong parameters validation in the controller:
  ```ruby
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def product_params
      params.expect(product: [ :name ])
    end
  ```

Reference: https://guides.rubyonrails.org/getting_started.html#creating-products

### Edit
* Create `app/views/products/edit.html.erb` view.
* Add `edit` & `update` methods.

Reference: https://guides.rubyonrails.org/getting_started.html#editing-products

### Delete
* Add `destroy` method.

Reference: https://guides.rubyonrails.org/getting_started.html#deleting-products

### Before Action
* Allows to extract shared code between actions and run it before the action.
* This let use to run `set_product` but only before `show`, `edit`, `update`, and `destroy` action methods are about to be executed:
  ```ruby
  before_action :set_product, only: %i[ show edit update destroy ]
  ```

### ERB Partial Views
* Create a partial view file: `app/views/products/_form.html.erb`
* Update the create & edit ERB template to refer the partial view:
  ```erb
  # products/new.html.erb
  <h1>New product</h1>

  <%= render "form", product: @product %>
  <%= link_to "Cancel", products_path %>
  ```

## Authentication
* To rollout your own authentication, run: `bin/rails generate authentication`
* It will generate a new DB migration, run the migration again.
* We can use Rails console to quick creating an user.