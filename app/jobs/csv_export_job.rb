require 'csv'
class CsvExportJob < ApplicationJob
  queue_as :default

  def perform(q_params)

    @q = Asset.ransack(q_params)
    @assets = @q.result(distinct: true)

    csv_string = CSV.generate do |csv|
      csv << ["ID","Název", "Kód", "Místo", "Cena", "Datum nákupu", "Datum poslední kontroly", "Popis", "Místnost", "Budova"]
      @assets.each do |asset|
        csv << [asset.id, asset.name, asset.code, asset.room.building.city, asset.purchase_price, asset.purchase_date, asset.last_check_date, asset.note, asset.room.name, asset.room.building.name]
      end
    end
    export_path = Rails.root.join('public', 'exports', 'majetek.csv')
    FileUtils.mkdir_p(File.dirname(export_path))
    File.write(export_path, csv_string)
  end
end
