# Overview

The purpose of this is to document how to start up a Digital Ocean droplet running EmberJS.

## Creating the Droplet
> Because I am creating this for testing purposes I decided on the smallest size droplet as this is the cheapest to run.

> Everything here must be run as the root user.

1. Create a `Ubuntu:16.04.1 x64` droplet. Choose the lowest size ($5/mo).

2. When `ssh`'d into the droplet, clone this repository and go into it:
    ```
    # git clone https://github.com/watksimo/ember-start-up.git
    # cd ember-start-up
    ```

3. Execute the `startup.sh` file with the username of the user you wish to be setup as a `sudoer` as the first parameter, and the name of your new ember app as the second parameter:

    ```
    # ./startup.sh username new-app
    ```

4. The ember server is started at the end of the script to test everything worked. Navigate to the url output by the script on the line starting with `##########`, it should now display the 'Welcome to Ember' page.

5. A new `sudo` user has now also been created with the username set to what was entered on the command line, and the password is the same.

6. New ember projects can now be created and modified.
