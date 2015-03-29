ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  menu priority: 2, label: "Sidekiq", url: "/admin/sidekiq", :html_options => { :target => :blank }

  content title: proc{ I18n.t("active_admin.dashboard") } do
  #   div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

    section "Recentes Noivas " do
        table_for Customer.order("created_at desc").limit(5) do
          column :first_name do |customer|
            link_to customer.first_name, [:admin, customer]
          end
          column :last_name do |customer|
            link_to customer.first_name, [:admin, customer]
          end
          column :created_at
        end
        strong { link_to "Visualizar todas noivas", admin_customers_path }
    end

   section "Recentes provedores de serviços " do
        table_for Provider.order("created_at desc").limit(5) do
          column :first_name do |provider|
            link_to provider.first_name, [:admin, provider]
          end
          column :last_name do |provider|
            link_to provider.first_name, [:admin, provider]
          end
          column :created_at
        end
        strong { link_to "Visualizar todos prestadores", admin_providers_path }
   end

    section "Roles" do
        table_for Role.order("created_at desc").limit(5) do
          column :name do |role|
            link_to role.name, [:admin, role]
          end
          column :description do |role|
            link_to role.description, [:admin, role]
          end
          column :created_at
        end
        # strong { link_to "Visualizar todos roles", admin_roles_path }
   end

  section "Email confirmados e não completado" do
    table_for User.where(is_completed: false).where.not(confirmed_at: nil) do
       column :email
    end
  end

  section "Não confirmados" do
    table_for User.where(confirmed_at: nil) do
       column :email
    end
  end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
