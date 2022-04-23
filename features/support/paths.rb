module NavigationHelpers
    # Maps a name to a path. Used by the
    #
    #   When /^I go to (.+)$/ do |page_name|
    #
    # step definition in web_steps.rb
    #
    def path_to(page_name)
      case page_name

      when /the home page/
        '/'
  
      when /the signup page/
        '/signup'
        
      when /the login page/
        '/login'

      when /the profile page/
        '/profile'
        
      when /the listings page/
        '/listings'

      when /the new listing page/
        '/listings/new'

      when /^the listing details page for id (.*)$/
        '/listings/' + $1

      when /^the edit listing page for id (.*)$/
        '/listings/' + $1 + '/edit'
        
      when /^the edit user page$/
        '/edit'
  
      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))
  
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  World(NavigationHelpers)