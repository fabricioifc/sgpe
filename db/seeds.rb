# user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

puts 'Criar os modalidades, formatos e cursos'
# CreateCourseService.new.call
puts 'Criar disciplinas'
# CreateDisciplineService.new.call
puts 'Criar perfis'
# CreatePerfilService.new.call
puts 'Criar usuários padrão'
# CreateUsersService.new.call

#puts 'Cadastrar usuários através de convite'
# InviteUsersService.new.call if Rails.env.production?
