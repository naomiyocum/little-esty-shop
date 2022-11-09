class ApplicationController < ActionController::Base
  before_action :repo_name

  def repo_name
    @repo = GithubSearch.repo_name
    @collabs = GithubSearch.collab_info
    @commits = GithubSearch.commits
    @pulls = GithubSearch.pulls
  end
end
