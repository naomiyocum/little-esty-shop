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

  def self.pulls
    get_uri("https://api.github.com/repos/naomiyocum/little-esty-shop/pulls?state=closed")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri, headers: {"Authorization" => "Bearer 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"})
    JSON.parse(response.body, symbolize_names: true)
  end
end
