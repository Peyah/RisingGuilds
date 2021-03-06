require 'spec_helper'

describe Character do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    Factory.create(:Character)
  end
  
  it "should can be linked to a guild" do
    guild = Guild.first || Factory.create(:Guild)
    character = Factory.create(:Character)
    character.guild = guild
    character.guild.name.should == guild.name
  end
  
  it "should self-update on sync" do
    char = Factory.create(:Character,:name => "Nerox")
    char.sync
    char.reload
    char.achivementpoints.should == 1425
    char.level.should == 77
    char.talentspec1.class.should == Arsenal::TalentSpec
    char.talentspec2.class.should == Arsenal::TalentSpec
    char.items.first.class.should == Arsenal::Item
    char.profession1.class.should == Arsenal::Profession
    char.profession2.class.should == Arsenal::Profession
  end
  
  it "should update the ail of a character" do
    char = Factory.create(:Character,:name => "Nerox")
    char.sync
    char.sync_ail
    char.reload
    char.ail.should == 137
  end
  
  #test for Error #13 ... double-levelup-events
  it "should update the level and trigger the event ONCE" do
    char = Factory.create(:Character,:name => "Nerox")
    char.sync
    char.reload
    char.level.should == 77
    configatron.arsenal.url.character.sheet = 'char_levelup.xml'
    char.sync
    char.reload
    char.level.should == 78
    event = char.events.last
    event.action.should == "levelup"
    char.sync
    char.reload
    char.events.last.should == event
  end
end
