module PermissionManager
  READ = 1
  WRITE = 2
  DELETE = 4

  def read?
    self.permission_set & READ == READ
  end

  def read!(val=true)
    self.permission_set = make val, READ
  end

  def write?
    self.permission_set & WRITE == WRITE
  end

  def write!(val=true)
    self.permission_set = make val, WRITE
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