# IVR Call Recording and Agent Conference. Level: Intermediate. Powered by Twilio - Ruby on Rails

An example application implementing an automated phone line using Twilio.  For a
step-by-step tutorial, [visit this link](https://twilio.com/docs/howto/).

Deploy this example app to Heroku now!

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/TwilioDevEd/ivr-phone-tree-rails)

## Installation

To run this locally on your machine:

1) Grab latest source
<pre>
git clone git://github.com/TwilioDevEd/ivr-phone-tree-rails.git 
</pre>

2) Navigate to folder and run
<pre>
bundle install
</pre>

On 64 bit versions of OS X, you may need to install with the following to allow the pg gem to install:

```bash
ARCHFLAGS="-arch x86_64" bundle install
```

3) Make sure the tests succeed
<pre>
rake test
</pre>

4) Run the server
<pre>
rails server
</pre>

7) Check it out at [localhost:3000/](http://localhost:3000/)

## Meta 

* No warranty expressed or implied.  Software is as is. Diggity.
* [MIT License](http://www.opensource.org/licenses/mit-license.html)
* Lovingly crafted by Twilio Developer Education.
