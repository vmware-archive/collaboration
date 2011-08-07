class Service < ActiveRecord::Base
  has_many :owned_resources, :as => :resource

  validates_presence_of :display_name
end
