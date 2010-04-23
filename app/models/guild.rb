class Guild < ActiveRecord::Base
  has_many :events
  has_many :characters
  has_many :remoteQueries
  has_many :assignments
  has_many :users, :through => :assignments
  
  validates_presence_of :name
  validates_length_of :description, :minimum => 100, :message => "please write some more words"
  validates_length_of :description, :maximum => 1000, :message => "ok thats to much. Please keep a little bit shorter"
  validates_uniqueness_of :name
  
  validates_presence_of :token
  validates_uniqueness_of :token
  
  def managers
    @managers = Array.new
    @managers_role_id ||= Role.find_by_name("guild_manager").id
    assignments.find_all_by_role_id(@managers_role_id).each{|a| @managers << a.user}
    @managers
  end
  
  def leaders
    @leaders = Array.new
    @leaders_role_id ||= Role.find_by_name("guild_leader").id
    assignments.find_all_by_role_id(@leaders_role_id).each{|a| @leaders << a.user}
    @leaders
  end
  
  def officers
    @officers = Array.new
    @officers_role_id ||= Role.find_by_name("guild_officer").id
    assignments.find_all_by_role_id(@officer_role_id).each{|a| @officers << a.user}
    @officers
  end
  
  def members
    @members = Array.new
    @members_role_id ||= Role.find_by_name("guild_members").id
    assignments.find_all_by_role_id(@members_role_id).each{|a| @members << a.user}
    @members
  end
  
  def reset_token
    self.token = ActiveSupport::SecureRandom::hex(8)
    self.save
  end
  
  protected
  def before_validation_on_create
    self.token = ActiveSupport::SecureRandom::hex(8) if self.new_record? and self.token.nil?
  end
end
