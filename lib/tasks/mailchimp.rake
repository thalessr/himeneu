namespace :mailchimp do
  # gb = Gibbon::API.new(Gibbon::API.api_key)

  desc "Sync the not_completed list"
  task not_completed: :environment do
    User.not_completed.find_each do |user|
      begin

        Gibbon::API.lists.subscribe({
                                      :id => "69a4f0aabf",
                                      :email => {:email => user.email},
        :double_optin => false, :update_existing => true})

      rescue Gibbon::MailChimpError => e
        puts e.message
        puts e.code

      rescue => ex
        puts e.message
        puts e.code
      end
    end
  end

  desc "Sync the not_confirmated list"
  task not_confirmated: :environment do
    User.not_confirmated.find_each do |user|
      begin

        Gibbon::API.lists.subscribe({
                                      :id => "32def9e4ea",
                                      :email => {:email => user.email},
        :double_optin => false, :update_existing => true})

      rescue Gibbon::MailChimpError => e
        puts e.message
        puts e.code

      rescue => ex
        puts e.message
        puts e.code
      end
    end
  end

end
