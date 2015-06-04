namespace :mailchimp do

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


  desc "Sync the HimeneuFornecedores list and should be executed only once"
  task providers: :environment do
    Provider.find_each do |p|
      begin

        Gibbon::API.lists.subscribe({
                                      :id => "fcf8671c29",
                                      :email => {:email => p.user.email},
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

  desc "Sync the HimeneuNoivas list and should be executed only once"
  task customers: :environment do
    Customer.find_each do |c|
      begin

        Gibbon::API.lists.subscribe({
                                      :id => "2c7321aed9",
                                      :email => {:email => c.user.email},
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
