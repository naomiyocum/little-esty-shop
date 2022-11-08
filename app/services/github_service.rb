require 'httparty'

class GithubService
  def self.repo_name
    get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop")
  end

  def self.collaborators
    get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/collaborators")
  end

  def self.contributors
    get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/contributors")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri, headers: {"Authorization" => "Bearer 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"})
    JSON.parse(response.body, symbolize_names: true)
  end
end