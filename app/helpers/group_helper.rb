module GroupHelper
  def group_for_mustache(group)
    {
      url: group_url(group),
      name: group.name
    }
  end
end
