class User < ActiveRecord::Base
    # ej. User.authenticate('fernando@codea.mx', 'qwerty')


  validates :usuario, uniqueness: true
  validates :mail, uniqueness: true

  def self.authenticate(email, password)

    # si el email y el password corresponden a un usuario valido, regresa el usuario
    # de otra manera regresa nil
    user_find = User.find_by(mail: email)
    if email == user_find.mail && password == user_find.password
      user_find
    else
      nil
    end
  end

end