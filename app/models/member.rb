class Member < ActiveRecord::Base
  has_many :product_rentals
  has_many :system_bookings
  belongs_to :member_type

  validates :title, :first_name, :surname, :house_no, :street_name, :postcode, :date_of_birth, :member_type_id, :contact_no, presence: true
  validates :title, inclusion: { in: %w(Dr Mr Mrs Miss Ms Mx), message: '%{value} is not a valid title' }
  validates :id, uniqueness: true
  validate :over_18

  def over_18
    if self.date_of_birth
      if Date.today.year - self.date_of_birth.year < 18
        errors.add(:date_of_birth, 'User is not over 18')
      end
    end
  end

  def self.search(search)
    found_users = []
    all_users = Member.all()
    criteria = search.split(' ')
    criteria.each do |c|
      all_users.each do |s|
        if s.title.downcase == c.downcase or s.first_name.downcase.include? c.downcase or s.surname.downcase.include? c.downcase or s.member_type.easy_name.downcase.include? c.downcase or s.id.to_s == c
          found_users.append(s)
        end
      end
    end
    return found_users
  end

  def self.from_csv(file)
    require 'csv'
    csv = CSV.parse(file.read, :headers => true)
    users = []
    failed_users = []
    csv.each do |row|
      users.append(Member.new(row.to_hash))
    end
    users.each do |sys|
      if sys.valid?
        sys.save
      else
        failed_users.append(sys)
      end
    end
    return failed_users
  end

end

