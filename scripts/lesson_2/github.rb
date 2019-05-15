require './http_request.rb'

TEST_USER = 'smartiqa-test'
# GitHub restricts pushing Authentication Token to public repo
# That's why it's necessary to update it with valid token before running
AUTH_TOKEN = '<Please change me for b4a1d07f32....c5ca8594f>'
TEST_REPO = 'test_repository_2'
TEST_ISSUE_NUM = 3
TEST_COMMIT_SHA = '063b6dde79957b9f34a0a5f74f4febe0e34cbba5'

module Lesson2

  class API

    HOST = 'api.github.com'
    PROTOCOL = 'https'

    def initialize
      @http = Http.new(HOST, PROTOCOL)
    end

    def call(method, relative_url, headers=nil, params=nil, json=nil)
      @http.send_request(method, relative_url, headers, params, json)
    end

  end

  class User

    def initialize(auth_token=nil)
      @api = API.new
      # Majority of the API requests need Authentication Token but not all
      @headers = {Authorization: "token #{auth_token}"} if auth_token
    end


    # ------ Get User info without Authentication ------
    def get(user_name)
      @api.call('GET', "/users/#{user_name}")
    end

    def get_bio( user_name)
      get(user_name)['bio']
    end

    # -- Get additional User info with Authentication --
    def get_authenticated
      @api.call('GET', '/user', @headers)
    end

    # --------------- Update User info -----------------
    def update_bio(new_bio)
      @api.call('PATCH', '/user', @headers, nil, {bio: new_bio})
    end

  end

  class Issue

    def initialize(auth_token)
      @api = API.new
      @headers = {Authorization: "token #{auth_token}"}
    end

    # ------- List Issues -------------
    def list
      @api.call('GET', '/issues', @headers)
    end

    def list_for_repository(owner, repo)
      @api.call('GET', "/repos/#{owner}/#{repo}/issues", @headers)
    end

    # ------- Get Issue info ----------
    def get(owner, repo, number)
      @api.call('GET', "/repos/#{owner}/#{repo}/issues/#{number}", @headers)
    end

    # ------- Edit Issues -------------
    def edit_title(owner, repo, number, new_title)
      edit(owner, repo, number, {title: new_title})
    end

    def edit_body(owner, repo, number, new_body)
      edit(owner, repo, number, {body: new_body})
    end
    # ---------------------------------

    private

    def edit(owner, repo, number, json)
      @api.call('PATCH', "/repos/#{owner}/#{repo}/issues/#{number}", @headers, nil, json)
    end

  end

end

# Check GitHub User API functionality
user = Lesson2::User.new(AUTH_TOKEN)
user.get(TEST_USER)
user.get_bio(TEST_USER)
user.get_authenticated
user.update_bio('New Test bio')

# Check GitHub Issue API functionality
issue = Lesson2::Issue.new(AUTH_TOKEN)
issue.list
issue.list_for_repository(TEST_USER, TEST_REPO)
issue.get(TEST_USER, TEST_REPO, TEST_ISSUE_NUM)
issue.edit_title(TEST_USER, TEST_REPO, TEST_ISSUE_NUM, 'Smartiqa Test issue 3')
issue.edit_body(TEST_USER, TEST_REPO, TEST_ISSUE_NUM, 'Smartiqa Test body 3')