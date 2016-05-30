class Product < ActiveRecord::Base
    
    has_many :locations
    has_many :inventories, through: :locations    
    
    mount_uploader :photo, ProductPhotoUploader
end
