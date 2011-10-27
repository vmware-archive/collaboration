module OrgsHelper

    ## Helper Method which list all potential resources in an org
  def potential_owned_resources org
    array = []
    if org.owned_resources
      array = org.owned_resources.inject([['Use Route', '']]){|array, o| array << [o.to_s, o.id]}
    end
    array
  end

  ## Helper Method which returns the list of users in an org
  def potential_users org
    user_list = []
    org.groups.each do |group|
      group.group_members.each do |m|
        user_list << [m.user.display_name, m.user_id]
      end
    end
    user_list.uniq
  end

  ## Helper Method which returns the list of groups in an org
  def potential_groups org
    if org.groups
      return org.groups.collect{|g| [g.display_name, g.id]}
    end
    []
  end
end
