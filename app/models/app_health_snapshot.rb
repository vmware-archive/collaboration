class AppHealthSnapshot
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :email, :type => String
  field :provider, :type => Symbol
  field :instances, :type => Integer, :default => 1
  field :running_instances, :type => Integer, :default => 0
  field :app_id, :type => Integer

  index :app_id

  public
  def self.latest app_id
    AppHealthSnapshot.first(conditions: {:app_id => app_id}, :sort => [[ :created_at, :desc ]])
  end

  def percentage
    running_instances * 100 / instances
  end
end
