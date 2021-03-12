<a  href="https://www.twilio.com">
<img  src="https://static0.twilio.com/marketing/bundles/marketing/img/logos/wordmark-red.svg"  alt="Twilio"  width="250"  />
</a>
 
# IVR Call Recording and Agent Conference. Level: Intermediate. Powered by Twilio - Ruby on Rails

![](https://github.com/TwilioDevEd/ivr-recording-rails/actions/workflows/build.yml/badge.svg)

## About

IVRs (interactive voice response) are automated phone systems that can
facilitate communication between callers and businesses. In this tutorial you
will learn how to screen and send callers to voicemail if an agent is busy.

[Read the full tutorial here!](https://www.twilio.com/docs/howto/walkthrough/ivr-screening/ruby/rails).

## Local development

This project is built using [Ruby on Rails](http://rubyonrails.org/) and [NodeJS](https://nodejs.org/en/) Frameworks.

1. First clone this repository and `cd` into it.

   ```bash
   $ git clone git://github.com/TwilioDevEd/ivr-recording-rails.git
   $ cd ivr-recording-rails
   ```

1. Install Rails the dependencies.
   ```
   $ bundle install
   ```

1. Install Webpack the dependencies.
   ```
   $ npm install
   ```

1. Create database and run migrations.

   _Make sure you have installed [PostgreSQL](http://www.postgresql.org/). If on a Mac, I recommend [Postgres.app](http://postgresapp.com)_

   ```bash
   $ bundle exec rails db:setup
   ```

1. Edit db/seeds.rb and seed the database.

   ```bash
   $ bundle exec rails db:seed
   ```

1. Make sure the tests succeed.

   ```bash
   $ bundle exec rails test
   ```

1. Start the server.

   ```bash
   $ bundle exec rails s
   ```

1. Check it out at [http://localhost:3000](http://localhost:3000)

## How to Demo

1. Expose the application to the wider Internet using [ngrok](https://ngrok.com/).

   ```bash
   $ ngrok http 3000
   ```

1. Provision a number with voice capabilities under the
   [Manage Numbers page](https://www.twilio.com/console/phone-numbers/incoming)
   on your account. Set the *Voice URL* for the number to
   `http://<your-ngrok-subdomain>.ngrok.io/ivr/welcome`.

1. Grab your phone and call your newly-provisioned number!

## Meta

* No warranty expressed or implied. Software is as is. Diggity.
* [MIT License](LICENSE)
* Lovingly crafted by Twilio Developer Education.
