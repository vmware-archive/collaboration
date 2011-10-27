class Everyone < Group
  public
    def includes? user
      return true
    end
end