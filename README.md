# Overview

The purpose of this is to document how to start up a Digital Ocean droplet running EmberJS.

## Creating the Droplet
> Because I am creating this for testing purposes I decided on the smallest size droplet as this is the cheapest to run.

1. Create a `Ubuntu:16.04.1 x64` droplet. Choose the lowest size ($5/mo).

2. When `ssh`'d into the droplet, clone this repository:
```
# git clone https://github.com/watksimo/ember-start-up.git
```

3. Execute the `startup.sh` file with the name of your new ember app as the first parameter:

```
# ./startup.sh new-app
```

4. The ember server is started at the end of the script to test everything worked. Navigate to the url output by the script before the server started, it should noew display the 'Welcome to Ember' page.

5. New ember projects can now be created and modified.
