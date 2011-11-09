class UserAccessToken

  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :external_id, type: String
  field :provider, type: Symbol
  field :token, type: String
  field :refresh_token, type: String
  field :expires, type: DateTime
  field :user_id, type: Integer

  index(
    [
      [ :email, Mongo::ASCENDING ],
      [ :provider, Mongo::ASCENDING ]
    ],
    unique: true
  )

  index(
    [
      [ :external_id, Mongo::ASCENDING ],
      [ :provider, Mongo::ASCENDING ]
    ],
    unique: true
  )

  index :user_id

  attr_accessible :provider

  public

  def self.get_tokens user
    tokens = []
    emails = user.email_addresses.collect &:email

    UserAccessToken.any_in(:email => emails).each do |record|
      tokens << record
    end

    UserAccessToken.where(user_id: user.id).each do |record|
      tokens << record
    end
    tokens.uniq
  end

  def self.add_tokens email, id, provider, creds
    user_token = nil

    if provider && creds['token']
      if email
        user_token = UserAccessToken.first(conditions: { email: email, provider: provider})
      elsif id
        user_token = UserAccessToken.first(conditions: { external_id: id, provider: provider})
      end

      unless (user_token)
        user_token = UserAccessToken.new email: email, provider: provider
      end
      user_token.token = creds['token']
      user_token.external_id = id
      user_token.refresh_token = creds['refresh_token'] if creds.has_key? 'refresh_token'
      user_token.save!
      user_token = user_token.reload
    end

    return user_token
  end

  def self.first_access_token user, provider
    UserAccessToken.get_access_tokens(user, provider).values.first
  end

  def self.get_user_by_provider_and_id provider, id
    record = UserAccessToken.where(provider: provider, external_id: id).first
    return record
  end

  def self.access_tokens_for_user user_id
    UserAccessToken.where(user_id: user_id)
  end

  def self.get_access_tokens user, provider
    access_tokens = {}

    emails = user.email_addresses.collect &:email
    UserAccessToken.any_in(:email => emails).and(:provider => provider).each do |record|
      access_tokens[record.email] = record
    end

    UserAccessToken.where(provider: provider, user_id: user.id).each do |record|
      access_tokens[record.email] = record
    end

    access_tokens
  end
end