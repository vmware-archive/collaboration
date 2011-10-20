class EmailAddress < ActiveRecord::Base

  VERIFIED_EMAIL_PROVIDERS = [:facebook, :cloudfoundry]
  belongs_to :user
  validates_uniqueness_of :email


end