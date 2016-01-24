class Gift < ActiveRecord::Base
   validates :title, presence: true, length: { minimum: 3 }
   belongs_to :list

   before_validation :smart_add_url_protocol

   protected

   def smart_add_url_protocol
     unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
       self.link = "http://#{self.link}"
     end
   end

end
