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
    split_instant_results_from_considerations(home_people)
    eliminate_already_accounted_for_sharings

    owner_groups.empty? ? considerations.uniq : owner_groups.uniq
  end

private

  def split_instant_results_from_considerations(home_people)
    uniq_sharings(home_people).each do |sharing|
      if sharing.length == 1 || sharing.length == 2
        owner_groups << sharing
      else
        considerations << sharing
      end
    end
  end

  def eliminate_already_accounted_for_sharings
    considerations.each do |consideration|
      owner_groups.each do |owner_group|
        if (owner_group & consideration).empty?
          owner_groups << consideration
        end
      end
    end
  end

  def uniq_sharings(home_people)
    home_people.map(&:shared_with_plus_me).uniq
  end
end
