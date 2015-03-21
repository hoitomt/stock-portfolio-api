require 'test_helper'

describe User do
  let(:github_id){ 123 }
  let(:github_response) {
    {
      login: "hoitomt",
      id: github_id,
      avatar_url: "https://avatars.githubusercontent.com/u/253541?v=3",
      gravatar_id: "",
      url: "https://api.github.com/users/hoitomt",
      html_url: "https://github.com/hoitomt",
      followers_url: "https://api.github.com/users/hoitomt/followers",
      following_url: "https://api.github.com/users/hoitomt/following{/other_user}",
      gists_url: "https://api.github.com/users/hoitomt/gists{/gist_id}",
      starred_url: "https://api.github.com/users/hoitomt/starred{/owner}{/repo}",
      subscriptions_url: "https://api.github.com/users/hoitomt/subscriptions",
      organizations_url: "https://api.github.com/users/hoitomt/orgs",
      repos_url: "https://api.github.com/users/hoitomt/repos",
      events_url: "https://api.github.com/users/hoitomt/events{/privacy}",
      received_events_url: "https://api.github.com/users/hoitomt/received_events",
      type: "User",
      site_admin: false,
      name: "Michael Hoitomt",
      company: nil,
      blog: "www.hoitomt.com",
      location: "Eau Claire, WI",
      email: "mike@hoitomt.com",
      hireable: true,
      bio: nil,
      public_repos: 31,
      public_gists: 7,
      followers: 4,
      following: 0,
      created_at: "2010-04-26T22:48:54Z",
      updated_at: "2015-03-17T02:32:33Z"
    }
  }

  describe "fetch" do
    let(:access_token) {'123abc'}

    before do
      stub_request(:get, "https://api.github.com/user").
        to_return(:status => 200, :body => github_response.to_json)
    end

    describe "create" do
      it "new user" do
        lambda {
          User.fetch(access_token)
        }.must_change "User.count", +1
      end
    end

    describe "retrieve" do
      it "retrieves and existing user" do
        user = create :user, github_id: github_id
        User.fetch(access_token).id.must_equal user.id
      end

    end
  end

  describe "authenticate" do
    let(:auth_token){"anawesometoken"}

    it "returns a user" do
      user = create :user, auth_token: auth_token
      User.authenticate(auth_token).id.must_equal user.id
    end
  end
end

