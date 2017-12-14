RSpec.describe HomePerson do
  describe "#shared_with_plus_me" do
    it "blah" do
      mary = HomePerson.build(2, 234, [123])
      elle = HomePerson.build(2, 345, [123, 234])
      alex = HomePerson.build(2, 456, [])

      expect(mary.shared_with_plus_me).to eq [123, 234]
      expect(elle.shared_with_plus_me).to eq [123, 234, 345]
      expect(alex.shared_with_plus_me).to eq [456]
    end
  end
end
