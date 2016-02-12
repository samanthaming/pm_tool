require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "validation" do

    it 'requires title to be present' do
      project = Project.new
      project.valid?
      expect(project.errors).to have_key(:title)
    end
    it 'requires title to be unique' do
      Project.create({title: "same", due_date: "Jan 01, 2020"})
      proj = Project.new(title:"same")
      proj.valid?
      expect(proj.errors).to have_key(:title)
    end
    it "requires due_date must be greater than today's date" do
      project = Project.create({title: "something", due_date: "Jan 01, 2000"})
      project.valid?
      expect(project.errors).to have_key(:due_date)
    end
  end

end
