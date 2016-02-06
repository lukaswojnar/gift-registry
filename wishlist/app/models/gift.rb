class Gift < ActiveRecord::Base
   validates :title, presence: true, length: { minimum: 3, maximum: 500,
                                               too_long: "%{count} characters is the maximum allowed" }
   belongs_to :list

   has_attached_file :image, styles: { large: "800x800>", thumb: "220x220#", small_thumb: "100x100#" }, default_url: "/images/:style/gift-image-missing.png"
   validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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
