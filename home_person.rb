class HomePerson
  HP = Struct.new(:home_id, :person_id, :shared_with) do
    def shared_with_plus_me
      shared = [person_id] + shared_with
      shared.sort
    end
  end

  def self.build(home_id, person_id, shared_with)
    HP.new(home_id, person_id, shared_with)
  end
end
