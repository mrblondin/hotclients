class User < ActiveRecord::Base
  acts_as_authentic
  ROLES = %w[superadmin admin operator partner agent]
  has_many :clients
  has_many :agents, class_name: 'User',
           foreign_key: 'partner_id'
  has_many :cities, :dependent =>  :destroy

  belongs_to :partner, class_name: 'User'

  validates :login, presence: true
  validates :role, presence: true

  validates_presence_of :password, :on => :create
  validates_confirmation_of :password, :allow_blank => true

  def self.roles
    [['Главный Админ', 'superadmin'], ['Админ', 'admin'], ['Оператор', 'operator'], ['Партнёр', 'partner'], ['Агент', 'agent']]
  end
end
