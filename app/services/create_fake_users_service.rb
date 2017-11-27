class CreateFakeUsersService

  def call

    # if Rails.env.development?
    #   10.times do
    #
    #     user = User.find_or_create_by(email: Faker::Internet.email) do |user|
    #       user.username               = user.email.split('@')[0]
    #       user.name                   = Faker::Name.name
    #       user.password               = '123456'
    #       user.password_confirmation  = '123456'
    #       user.admin                  = false
    #       user.teacher                = true
    #       user.confirm
    #     end
    #   end
    # end
  end
end
