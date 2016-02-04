desc "Heroku scheduler tasks"
task :send_notifications => :environment do
  puts "Sending out email notifications."
  NotificationsController.notify
  puts "Emails sent!"
end