require 'digest'
class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation, :profile_image, 
    :country, :state, :city, :zip, :height, :weight, :birthday, :profile_text, :preferred_age_low, :preferred_age_high,
    :relationship, :sexually, :activated_at, :activation_code, :last_login, :last_activity, :remember_me
  attr_accessor :password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true, :length => { :within => 2..20 }
  validates :birthday, :presence => true
  validates :country, :presence => true
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => { :within => 6..40 },
                        :if => :password_required?

  before_save :encrypt_password, :if => :password_required?
  before_create :make_activation_code

  has_many :posts
  has_many :visitors
  has_many :comments
  has_many :user_images
  has_many :followers, :class_name => 'Follow', :foreign_key => 'following_id'
  has_many :following, :class_name => 'Follow', :foreign_key => 'follower_id'
  has_many :messages_sent, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :messages_received, :class_name => 'Message', :foreign_key => 'recipient_id'

  mount_uploader :profile_image, ProfileImageUploader

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def followed?(current_id)
    followers.find_by_follower_id(current_id) == nil ? false : true
  end

  def age
    now = Time.now.utc.to_date
    birthday.nil? ? 0 : now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end

  def unread_messages
    messages_received.where('read = ?', :false).size
  end

  # Activates the user in the database.
  def activate
    update_attributes(:activated_at => Time.now.utc, :activation_code => nil)
  end

  def activated?
    activation_code.nil?
  end

  def online?
    activated? && Time.now() - last_activity < 600 ? true : false
  end

  def premium?
    membership_expiration.nil? ? false : Date.today <= membership_expiration
  end

  def self.search(params)
    if params
      older_than(params[:min]).younger_than(params[:max]).online(params[:on]).activated
    else
      activated
    end
  end

  scope :older_than, lambda { |value| where('birthday <= ?', Integer(value).years.ago) if value }
  scope :younger_than, lambda { |value| where('birthday >= ?', Integer(value).years.ago) if value }
  scope :online, lambda { |value| where('last_activity >= ?', Time.now() - 600) if value }
  scope :activated, where('activation_code is ?', nil)

    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end
    
    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end
    
    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end
    
    def conditions_parts(params)
      private_methods(false).grep(/_conditions$/).map { |m| send(m,params) }.compact
    end

  private

    def password_required?
      encrypted_password.blank? || !password.blank?
    end

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end

end
