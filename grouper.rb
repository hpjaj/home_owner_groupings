class Grouper
  attr_reader :owner_groups, :considerations

  def initialize
    @owner_groups = []
    @considerations = []
  end

  def self.for(home_people)
    new.for(home_people)
  end

  def for(home_people)
    split_instant_owner_groups_from_considerations(home_people)
    include_non_accounted_for_considerations
    return_the_unique_owner_groupings
  end

private

  def split_instant_owner_groups_from_considerations(home_people)
    uniq_sharings(home_people).each do |sharing|
      if sharing.length == 1 || sharing.length == 2
        owner_groups << sharing
      else
        considerations << sharing
      end
    end
  end

  def include_non_accounted_for_considerations
    considerations.each do |consideration|
      add_consideration_when_no_intersection(consideration)
  def add_consideration_when_no_intersection(consideration)
    owner_groups.each do |owner_group|
      if (owner_group & consideration).empty?
        owner_groups << consideration
      end
    end
  end

  def uniq_sharings(home_people)
    home_people.map(&:shared_with_plus_me).uniq
  end

  def return_the_unique_owner_groupings
    if owner_groups.empty?
      considerations.uniq
    else
      owner_groups.uniq
    end
  end
end
