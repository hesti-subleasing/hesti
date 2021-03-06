# Hesti 🏠🔥
An application that connects subletters to subleasers. Made for students.

## Ruby Version
Before running any commands, make sure you have the proper ruby version: `3.0.4`  
Check which ruby version you have by running: `rbenv local`  
If it does not say `3.0.4`, run 
```
rbenv install 3.0.4
rbenv local 3.0.4
```

## Environment Variables
This application needs to have certain environment variables set up. All environment variables are located in the `setup.sh.gpg` file.  
To decrypt the file, you must first import the private and public key if it was sent to you.  
To decrpy/get the actual setup file, run: `gpg -o setup.sh -d setup.sh.gpg`  
This will create the file `setup.sh` which has the list of environment variables.  
To export the environment variables, run: `. ./setup.sh`  
To check, run: `printenv`

## Running the Application
After properly setting up your environment variables, run the following commands to start the applicaiton in development mode:
```
bundle install          // installs all gems from gemfile
rails server            // runs application locally
```

## GitHub Actions
Whenever you push or do a pull request, GitHub Actions will automatically run the cucumber and rspec tests. Details on the steps can be found in the `.github/workflows/main.yml` file. The YAML file utilizes GitHub Secrets which have already been set in the repo. They are essentially the environment variables for this application.
To run these tests locally, run the following commands:
```
bundle exec cucumber        // runs the cucumber tests
bundle exec rspec           // runs the rspec tests
```

## Heroku
This application is deployed on Heroku. Whenever you push to main, it will automatically trigger Heroku to deploy the current project.