class UserAccessToken
  include Mongoid::Document

  field :email, type: String
  field :provider, type: Symbol
  field :token, type: String
  field :refresh_token, type: String
  field :expires, type: DateTime

  index(
    [
      [ :email, Mongo::ASCENDING ],
      [ :provider, Mongo::ASCENDING ]
    ],
    unique: true
  )

  public

  def self.add_tokens email, provider, token, refresh_token=nil
    user_token = get_user_token(email, provider)

    if email && provider && token
      if (user_token.nil?)
        user_token = UserAccessToken.new email: email, provider: provider
      end
      user_token.token = token
      user_token.refresh_token = refresh_token if refresh_token
      user_token.save!
    end

    return user_token.reload
  end

  def self.get_user_token email, provider
    UserAccessToken.where(email: email, provider: provider).first
  end
end