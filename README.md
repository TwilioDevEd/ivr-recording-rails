# IVR Call Recording and Agent Conference. Level: Intermediate. Powered by Twilio - Ruby on Rails

An example application implementing an automated phone line using Twilio.  For a
step-by-step tutorial, [visit this link](https://twilio.com/docs/howto/).

Deploy this example app to Heroku now!

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/TwilioDevEd/ivr-phone-tree-rails)

### Local Development

To run this locally on your machine:

1) Grab latest source
<pre>
git clone git://github.com/TwilioDevEd/ivr-recording-rails.git 
</pre>

2) Navigate to folder and run
<pre>
bundle install
</pre>

On 64 bit versions of OS X, you may need to install with the following to allow the pg gem to install:

```bash
ARCHFLAGS="-arch x86_64" bundle install
```
3) Create the Database
<pre>
rake db:create db:migrate
</pre>

4) Edit db/seeds.rb & seed the database
<pre>
rake db:seed
</pre>

3) Make sure the tests succeed
<pre>
rake test
</pre>

4) Run the server
<pre>
rails server
</pre>

7) Check it out at [localhost:3000/](http://localhost:3000/)

### Configure Twilio to call your webhooks

You will also need to configure Twilio to call your application when calls are received

You will need to provision at least one Twilio number with voice capabilities
so the application's users can take surveys. You can buy a number [right
here](https://www.twilio.com/user/account/phone-numbers/search). Once you have
a number you need to configure your number to work with your application. Open
[the number management page](https://www.twilio.com/user/account/phone-
numbers/incoming) and open a number's configuration by clicking on it.

![Configure Voice](http://howtodocs.s3.amazonaws.com/twilio-number-config-all-med.gif)

## Meta 

* No warranty expressed or implied.  Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
