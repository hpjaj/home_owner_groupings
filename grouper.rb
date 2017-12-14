class Grouper
  def self.for(home_people)
    uniq_sharings = home_people.map(&:shared_with_plus_me).uniq

    results = []
    extras  = []

    uniq_sharings.each do |sharing|
      if sharing.length == 1 || sharing.length == 2
        results << sharing
      else
        extras << sharing
      end
    end

    extras.each do |extra|
      results.each do |result|
        if (result & extra).empty?
          results << extra
        end
      end
    end

    results.empty? ? extras.uniq : results.uniq
  end
end
