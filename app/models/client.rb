class Client < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, :format => {:with => /\A(\+1)?[0-9]{10}\z/, :message => "Неверный номер телефона"}
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
    if (file != nil)
      ##Загрузка примера
      spreadsheet1 = open_spreadsheet(file)
      header = spreadsheet1.row(2)
      (3..spreadsheet1.last_row).each do |i|
        row = spreadsheet1.row(i)
        client = Client.new()
        client.statement_date = row[header.index('Дата')]

        region = row[header.index('Область')].strip
        region = region.split(' ')[1..-1].join(' ') if region.start_with?('г.', 'обл.', 'респ.', 'край.', 'Аобл.', 'АО.') ## первое слово убираем
        client.region = region

        city = row[header.index('Город')].strip
        city = city.split(' ').drop(1).join(' ') if city.start_with?('г.', 'п.', 'с.') ## первое слово убираем
        client.city = city

        fio = row[header.index('ФИО')].split()
        client.surname = fio[0].mb_chars.downcase.capitalize.to_s
        client.name = fio[1].mb_chars.downcase.capitalize.to_s
        client.patronymic = fio[2].mb_chars.downcase.capitalize.to_s
        client.snils = row[header.index('СНИЛС')].gsub(/[^0-9A-Za-z]/, '')
        client.address = row[header.index('Адрес')]
        client.birth_date = row[header.index('Дата рождения')]
        client.phone = row[header.index('Телефон')].split()[0].gsub(/[^0-9]/, '')
        client.operator_status = row[header.index('Статус')]
        client.operator_comment = row[header.index('Комментарий')]
        client.stage = '1' ###Этап 1 всегда

        #row = Hash[[header, spreadsheet1.row(i)].transpose]
        #client = find_by_id(row["id"]) || new
        #client.attributes = row.to_hash
        client.save!
      end
    end
  end

  def self.open_spreadsheet(file)

    case File.extname(file.original_filename)
      when ".csv" then
        Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xls" then
        Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path, file_warning: :ignore)
      else
        raise "Неизвестный тип файла: #{file.original_filename}"
    end
  end
end
