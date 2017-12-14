RSpec.describe Grouper do
  describe ".for" do
    it "with two unique sets of owners, it returns correct groupings" do
      john = HomePerson.build(2, 123, [234])
      mary = HomePerson.build(2, 234, [123])
      elle = HomePerson.build(2, 345, [456])
      alex = HomePerson.build(2, 456, [345])
      home_people = [john, mary, elle, alex]

      expect(Grouper.for(home_people)).to match_array [[123, 234], [345, 456]]
    end

    it "with a husband that owned the home with two different wives, it returns correct groupings" do
      john = HomePerson.build(2, 123, [234, 345])
      mary = HomePerson.build(2, 234, [123])
      elle = HomePerson.build(2, 345, [123])
      home_people = [john, mary, elle]

      expect(Grouper.for(home_people)).to match_array [[123, 234], [123, 345]]
    end

    it "with three people owning the home together, it returns correct groupings" do
      john = HomePerson.build(2, 123, [234, 345])
      mary = HomePerson.build(2, 234, [123, 345])
      elle = HomePerson.build(2, 345, [123, 234])
      home_people = [john, mary, elle]

      expect(Grouper.for(home_people)).to match_array [[123, 234, 345]]
    end

    it "with three people owning the home first, then selling it to one person, it returns the correct groupings" do
      john = HomePerson.build(2, 123, [234, 345])
      mary = HomePerson.build(2, 234, [123, 345])
      elle = HomePerson.build(2, 345, [123, 234])
      alex = HomePerson.build(2, 456, [])
      home_people = [john, mary, elle, alex]

      expect(Grouper.for(home_people)).to match_array [[123, 234, 345], [456]]
    end

    it "with three people owning the home first, then selling it to a new couple, it returns the correct groupings" do
      john = HomePerson.build(2, 123, [234, 345])
      mary = HomePerson.build(2, 234, [123, 345])
      elle = HomePerson.build(2, 345, [123, 234])
      alex = HomePerson.build(2, 456, [567])
      fran = HomePerson.build(2, 567, [456])
      home_people = [john, mary, elle, alex, fran]

      expect(Grouper.for(home_people)).to match_array [[123, 234, 345], [456, 567]]
    end

    it "with four people owning the home first, then selling it to a new couple, it returns the correct groupings" do
      john = HomePerson.build(2, 123, [234, 345, 999])
      mary = HomePerson.build(2, 234, [123, 345, 999])
      elle = HomePerson.build(2, 345, [123, 234, 999])
      jack = HomePerson.build(2, 999, [123, 234, 345])
      alex = HomePerson.build(2, 456, [567])
      fran = HomePerson.build(2, 567, [456])
      home_people = [john, mary, elle, jack, alex, fran]

      expect(Grouper.for(home_people)).to match_array [[123, 234, 345, 999], [456, 567]]
    end
  end
end
