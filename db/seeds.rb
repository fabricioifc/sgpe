# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

# Criar os usuários padrão do sistema
CreateAdminService.new.call
# Criar os modalidades, formatos e cursos
CreateCourseService.new.call
# Criar disciplinas
CreateDisciplineService.new.call
# Criar perfis
CreatePerfilService.new.call
# Criar usuários fake para testes
CreateFakeUsersService.new.call
