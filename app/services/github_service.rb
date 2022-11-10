# require 'httparty'

# class GithubService
#   def self.repo_name
#     get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop")
#   end

#   def self.contributors
#     get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/contributors")
#   end

#   def self.pulls
#     get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/pulls?state=closed")
#   end

#   def self.get_uri(uri)
#     response = HTTParty.get(uri)
#     JSON.parse(response.body, symbolize_names: true)
#   end
# end
