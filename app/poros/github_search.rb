require 'httparty'

class GithubSearch
  def self.repo_name
    GithubService.repo_name
  end
end