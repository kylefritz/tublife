ActiveAdmin.register Ahoy::Message, as: "Email" do
  actions :all, except: [:edit, :update] # updating doesn't make sense
  includes :menu, :user

  scope :all, default: true

  filter :to
  filter :user_id_equals
  filter :subject
  filter :sent_at

  index do
    selectable_column
    id_column
    column :to do |email|
      div auto_link email.user, email.to
    end
    column :sent_at
    column :opened_at
    column :clicked_at
    column :subject
    actions
  end
end
