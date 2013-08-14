This project is no longer under active development. You are probably looking for [Signonotron2](https://github.com/alphagov/signonotron2).


Sign-on-o-tron
==============

An OAuth 2-based Single sign-on provider. 

This is a rails app with two key rake tasks:

rake clients:create name=ClientName

This will generate an ID and a Secret that can then be used in the app

rake users:create name=Name email=name@email.com (github=username twitter=username)

This will create the user and send them an email to set their password

