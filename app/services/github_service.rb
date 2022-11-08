require 'httparty'

class GithubService
  def self.repo_name
    get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop")
  end

  def self.collaborators
    x = get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/collaborators")
    require "pry"; binding.pry
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end
end

GithubService.collaborators
