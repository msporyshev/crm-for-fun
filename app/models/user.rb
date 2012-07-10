class User < ActiveRecord::Base
  attr_protected :role, :expires_at, :salt, :hashed_pass, :secure_id

  SESSION_TIME_MIN = 100000.to_i

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :role, presence: true
  validates :name, :presence => true, :length => { :maximum => 40 }
  validates :surname, :presence => true, :length => { :maximum => 40 }
  validates :email,
    :presence => true,
    :uniqueness => { :case_sensitive => false },
    :format => { :with => email_regex }

  validates :subdomain,
    :presence => true,
    :exclusion => { :in => %w(www us ca jp), :message => "Subdomain %{value} is reserved." },
    :format => { :with => /\A[a-z]+\z/ }

  validates :subdomain,
    :uniqueness => { :case_sensitive => false },
    :if => lambda { |record| record.role == "admin" }

  validates :password,
    :presence => true,
    :confirmation => true,
    :length => { :within => 6..40 }

  has_many :people, :dependent => :destroy
  has_many :cases, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :opportunities, :dependent => :destroy

  has_and_belongs_to_many :visible_people, class_name: "Person"
  has_and_belongs_to_many :visible_cases, class_name: "Case"
  has_and_belongs_to_many :visible_opportunities, class_name: "Opportunity"

  has_many :given_tasks, class_name: "Task", foreign_key: "responsible_id", :dependent => :destroy
  has_many :given_opportunities, class_name: "Task", foreign_key: "responsible_id", :dependent => :destroy

  attr_accessor :password_confirmation
  attr_reader :password

  def password=(password)
    @password = password

    return nil if password.blank?

    self.salt = generate_salt
    self.hashed_pass = User.encrypt_password(password, salt)
  end

  def accessible_tasks
    return accessible_by_subd(Task) if role == "admin"

  end

  def accessible_cases
    return accessible_by_subd(Case) if CasesUsers.by_subdomain(subdomain).blank? or
      role == "admin"
    Case.joins(:users).where("users.id = :id OR cases.user_id = :id", {id: id})
  end

  def accessible_people
    return accessible_by_subd(Person) if PeopleUsers.by_subdomain(subdomain).blank?  or
      role == "admin"
    Person.joins(:users).where("users.id = :id OR people.user_id = :id", {id: id})
  end

  def accessible_opportunities
    return accessible_by_subd(Opportunity) if OpportunitiesUsers.by_subdomain(subdomain).blank?  or
      role == "admin"
    Opportunity.joins(:users).
      where("users.id = :id OR opportunities.user_id = :id OR opportunities.responsible_id = :id",
          {id: id})
  end

  def accessible_by_subd(model_const)
    model_const.by_subdomain(subdomain)
  end

  def User.authenticate(email, password)
    return nil if not user = find_by_email(email)
    return nil if user.hashed_pass != encrypt_password(password, user.salt)
    set_session_params(user)
    user
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + salt)
  end

  def User.authenticate_with_sid(secure_id)
    user = User.find_by_secure_id(secure_id.to_s)
    (user && user.expires_at > Time.now.utc) ? user : nil
  end

  def User.by_subdomain(subdomain)
    where(:subdomain => subdomain)
  end

  private

    def User.set_session_params(user)
      user.secure_id = generate_secure_id
      user.expires_at = SESSION_TIME_MIN.minutes.from_now.utc
      user.save(:validate => false)
    end

    def User.generate_secure_id
      Digest::SHA2.hexdigest(Time.now.to_s + rand(10000).to_s)
    end

    def generate_salt
      self.object_id.to_s + rand(255).to_s
    end
end
