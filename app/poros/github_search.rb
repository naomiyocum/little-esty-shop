require 'httparty'
require 'pry'

class GithubSearch
  def self.repo_name
    GithubService.repo_name
  end

  def self.collaborators
    binding.pry
  end
end

GithubSearch.collaborators
