class Organization < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :owned_resources, :dependent => :destroy, :as => :owner
  has_many :apps, :through => :owned_resources
end
