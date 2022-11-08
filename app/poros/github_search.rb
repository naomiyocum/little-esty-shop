require 'httparty'
require 'pry'
require './app/poros/repo_name'
require './app/poros/collaborator'
require './app/services/github_service'



class GithubSearch
  def self.repo_name
    GithubService.repo_name
  end

  def self.collab_info
    GithubService.collaborators.map do |collab|
      Collaborator.new(collab)
    end
  end

end
