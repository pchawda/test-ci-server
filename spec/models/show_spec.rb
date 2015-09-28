require 'rails_helper'

RSpec.describe Show, type: :model do
  it { should belong_to(:user) }
  describe "validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:by) }
    it { should validate_presence_of(:music_by) }
    it { should validate_presence_of(:stage) }
    it { should validate_length_of(:title).is_at_most(100) }
    it { should validate_length_of(:stage).is_at_most(100) }
    it { should validate_length_of(:by).is_at_most(50) }
    it { should validate_length_of(:music_by).is_at_most(50) }

    it "uniqeness of title" do
      title = "test title"
      create(:show, title: title)
      show = build(:show, title: title)
      expect(show.valid?).to eq false
      expect(show.errors.full_messages).to eq ["Title has already been taken"]
    end
  end

  describe "friedly_id title_slug" do
    it "it should generate slug" do
      title = 'test title'
      show = create(:show, title: title)
      expect(show.slug).to eq title.gsub(' ', '-')
    end

    it "should update slug when update title change" do
      title = 'test title'
      show = create(:show)
      show.title = title
      show.save
      expect(show.reload.slug).to eq title.gsub(' ', '-')
    end

    it "should not update slug when title is not changed" do
      title = 'test title'
      show = create(:show, title: title)
      show.by = 'test'
      show.save
      expect(show.reload.slug).to eq title.gsub(' ', '-')
    end
  end

  it "should delete when user delete" do
    user = create(:user)
    shows = create_list(:show, 5, user: user)
    show = create(:show)
    user.destroy
    expect(Show.count).to eq 1
    expect(Show.first.id).to eq show.id
  end

end
