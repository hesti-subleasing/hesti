# Hesti 🏠🔥
An application that connects subletters to subleasers. Made for students.

<br>

## Ruby Version
Before running any commands, make sure you have the proper ruby version: `3.0.4`  
Check which ruby version you have by running: `rbenv local`  
If it does not say `3.0.4`, run 
```
rbenv install 3.0.4
rbenv local 3.0.4
```
<br>

## Environment Variables
This application needs to have certain environment variables set up. All environment variables are located in the `setup.sh.gpg` file.  
Decrpyt the `setup.sh.gpg` file. Run:
`gpg -d setup.sh.gpg`  
It will prompt you for the passphrase. Enter the passphrase if you have it. Once you do, it will create the file `setup.sh` which has the list of environment variables.  
To export the environment variables, run: `. ./setup.sh`  
To check, run: `printenv`

<br>

## Running the Application
After properly setting up your environment variables, run the following commands to start the applicaiton in development mode:
```
bundle install          // installs all gems from gemfile
rails server            // runs application locally
```

<br>

## GitHub Actions
Whenever you push or do a pull request, GitHub Actions will automatically run the cucumber and rspec tests. Details on the steps can be found in `.github/workflows/main.yml` file. The YAML file utilizes GitHub Secrets which have already been set in the repo. They are essentially the environment variables for this application.
To run these tests locally, run the following commands:
```
bundle exec cucumber        // runs the cucumber tests
bundle exec rspec           // runs the rspec tests
```

<br>

## Heroku
This application is deployed on Heroku. Whenever you push to main, it will automatically trigger heroku to deploy the current project.