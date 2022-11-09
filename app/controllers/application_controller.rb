class ApplicationController < ActionController::Base
  before_action :github_info

  def github_info
    @repo = GithubSearch.repo_name
    @commits = GithubSearch.commits
    @pulls = GithubSearch.pulls
  end
end
