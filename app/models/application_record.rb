class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

    # aqui valida que los campos no esten vacios
  validates :name, :sinopsis, :director, :imagen, presence: true

    #valida que la direcion de la imagen sea una URL
  validates :imagen, presence: true, format: { with: /\A(http|https):\/\/[\S]+\z/, message: "debe ser una URL válida" }

end
