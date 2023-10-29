# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby -v 3.0.0
* Rails -v 7.0.8
step 1
rails new actor_app
cd actor_app

create a model.
Name: Actor
rails generate model Actor name:string age:integer height:float rating:float
run the migration  --- rake db:migrate

create env file at root (.env) #for secret keys
Create a contorller
rails generate controller Actors create update
