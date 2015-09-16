class Client < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, :format => { :with => /\A(\+1)?[0-9]{10}\z/, :message => "Неверный номер телефона" }
  validates :snils, snils: true


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    ##Загрузка примера
    spreadsheet1 = open_spreadsheet(file)
    header = spreadsheet1.row(2)
    (3..spreadsheet1.last_row).each do |i|
      row = Hash[[header, spreadsheet1.row(i)].transpose]
      client = find_by_id(row["id"]) || new
      client.attributes = row.to_hash
      client.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
      else raise "Неизвестный тип файла: #{file.original_filename}"
    end
  end
end
