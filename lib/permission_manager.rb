module PermissionManager
  READ = 1
  UPDATE = 2
  CREATE = 4
  DELETE = 8
  ALL = READ | UPDATE | CREATE | DELETE

  def read?
    self.permission_set & READ == READ
  end

  def read!(val=true)
    self.permission_set = make val, READ
  end

  def update?
    self.permission_set & UPDATE == UPDATE
  end

  def update!(val=true)
    self.permission_set = make val, UPDATE
  end

  def create?
    self.permission_set & CREATE == CREATE
  end

  def create!(val=true)
    self.permission_set = make val, CREATE
  end

  def delete?
    self.permission_set & DELETE == DELETE
  end

  def delete!(val=true)
    self.permission_set = make val, DELETE
  end

  def make (val, perm)
    (val) ? (self.permission_set | perm) :(self.permission_set & ~perm)
  end

  # Add more permissions if needed
end