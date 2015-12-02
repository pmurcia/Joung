class User < ActiveRecord::Base
  attr_accessor :login
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [:login]


  validate :validate_username

  validates :username,
    :presence => true,
    :uniqueness => {
    :case_sensitive => false
  }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
    conditions[:email].downcase! if conditions[:email]
    where(conditions.to_hash).first
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
end
