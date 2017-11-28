user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

# Criar os modalidades, formatos e cursos
CreateCourseService.new.call
# Criar disciplinas
CreateDisciplineService.new.call
# Criar perfis
CreatePerfilService.new.call
# Criar usuários padrão
CreateUsersService.new.call
