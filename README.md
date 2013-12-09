boundless-cart
==============

To install to a development/staging environment:

Add an environment variable to the vhosts file called APPLICATION_ENV and set it to the relevant environment (development/staging/production). For example:

```
<VirtualHost *:80>
    ServerName staging.example.com
    DocumentRoot /home/example.com/public_html

    SetEnv APPLICATION_ENV "staging"
</VirtualHost>
```

Then duplicate the config.php in the root directory and admin directory and rename to have the APPLICATION_ENV appended to the filename eg 'config_staging.php'.

The system will now use the parameters set in this new config file. If no corresponding config file has been set up for the environment, it will fall back on the original config.php.
