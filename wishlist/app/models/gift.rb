class Gift < ActiveRecord::Base
   belongs_to :list

   before_validation :smart_add_url_protocol

   protected

   def smart_add_url_protocol
     if !self.link.empty?
       unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
         self.link = "http://#{self.link}"
       end
     end
   end

end
