class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  
  # :optional Error Fix Reference: 
  # http://stackoverflow.com/questions/36144877/rolify-table-error-user-add-role-admin-unknown-key-error/36151534#36151534
  belongs_to :resource,
             :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify
end
