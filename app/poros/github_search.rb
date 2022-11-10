# require 'httparty'
# require './app/poros/repo_name'
# require './app/services/github_service'
# require './app/poros/contributor'

# class GithubSearch
#   def self.repo_name
#     RepoName.new(GithubService.repo_name)
#   end

#   def self.commits
#     GithubService.contributors.map do |contributor|
#       Contributor.new(contributor)
#     end
#   end

#   def self.pulls
#     GithubService.pulls.map do |pull|
#       Pull.new(pull)
#     end
#   end
# end
