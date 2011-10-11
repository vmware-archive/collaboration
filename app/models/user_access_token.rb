class UserAccessToken

  include Mongoid::Document

  field :email, type: String
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

  index :user_id

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

  def self.add_tokens email, provider, creds
    user_token = UserAccessToken.where(email: email, provider: provider).first

    if email && provider && creds['token']
      if (user_token.nil?)
        user_token = UserAccessToken.new email: email, provider: provider
      end
      user_token.token = creds['token']
      user_token.refresh_token = creds['refresh_token'] if creds.has_key? 'refresh_token'
      user_token.save!
    end
    user_token = user_token.reload
    logger.info "Updated Access Token #{user_token.inspect}"

    return user_token
  end

  def self.first_access_token user, provider
    UserAccessToken.get_access_tokens(user, provider).values.first
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