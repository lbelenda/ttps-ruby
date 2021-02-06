class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: {maximum: 255, too_long: "%{count} caracteres es el maximo permitido"}

  def export_pdf
    pdf = Prawn::Document.new
    pdf.text "Libro: #{name}"
    pdf.move_down 20
    pdf.text "Notas:"
    pdf.move_down 20
    notes.each do |note|
      pdf.move_down 20
      pdf.text "Titulo: #{note.title}"
      pdf.move_down 20
      pdf.text "Contenido:"
      pdf.move_down 20
      pdf.styled_text note.body.to_s
      pdf.move_down 20
      pdf.text "----------------------------------------------"
    end
    pdf
  end

end
