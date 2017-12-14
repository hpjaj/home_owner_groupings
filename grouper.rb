class Grouper
  attr_reader :results, :extras

  def initialize
    @results = []
    @extras = []
  end

  def self.for(home_people)
    new.for(home_people)
  end

  def for(home_people)
    split_instant_results_from_considerations(home_people)
    eliminate_already_accounted_for_sharings

    results.empty? ? extras.uniq : results.uniq
  end

private

  def split_instant_results_from_considerations(home_people)
    uniq_sharings(home_people).each do |sharing|
      if sharing.length == 1 || sharing.length == 2
        results << sharing
      else
        extras << sharing
      end
    end
  end

  def eliminate_already_accounted_for_sharings
    extras.each do |extra|
      results.each do |result|
        if (result & extra).empty?
          results << extra
        end
      end
    end
  end

  def uniq_sharings(home_people)
    home_people.map(&:shared_with_plus_me).uniq
  end
end
