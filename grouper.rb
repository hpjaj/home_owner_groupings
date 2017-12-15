class Grouper
  attr_reader :owner_groups, :considerations

  def initialize
    @owner_groups = []
    @considerations = []
  end

  def self.for(home_people)
    new.for(home_people)
  end

  # Finds the unique owner groupings for the passed in HomePeople.
  #
  # @param home_people [Array] An array of HomePerson objects
  # @return [Array<Array>] Returns an array of unique owner grouping arrays.
  #
  def for(home_people)
    split_instant_owner_groups_from_considerations(home_people)
    include_non_accounted_for_considerations
    return_the_unique_owner_groupings
  end

private

  # Takes the unique array of sharings, and divides the sharings off
  # into an array of actual owner groups, and an array of potential
  # owner groups (considerations).
  #
  # A sharing is instantly added to the owner_groups if its length is
  # 1 or 2.  Reason being, since uniq_sharings is uniq, if a sharing
  # is of length 1 or 2, then that that sharing has to be a single home owner,
  # or a couple.
  #
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
    end
  end

  # If the considered sharings array (considerations) has any intersection
  # with any selected sharings arrays (owner_groups), it should not be added
  # to the owner_groups array, because it has already been accounted for.
  #
  # By intersection we mean any person_ids in common.
  #
  # If there is no intersection, it should be added to the owner_groups array,
  # because it has not yet been accounted for.
  #
  # @param consideration [Array] An array containing a person's id and their
  #   shared_with ids
  #
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
