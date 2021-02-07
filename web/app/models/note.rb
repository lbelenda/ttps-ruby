class Note < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :title, presence: true, uniqueness: true, length: {maximum: 255, too_long: "%{count} caracteres es el maximo permitido"}
  has_rich_text :body

  def export_pdf
    pdf = Prawn::Document.new
    pdf.text "Titulo: #{title}"
    pdf.move_down 20
    pdf.text "Contenido:"
    pdf.move_down 20
    pdf.styled_text body.to_s
    pdf
  end
end
