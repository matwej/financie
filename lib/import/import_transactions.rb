require 'nokogiri'

class ImportTransactions

  INPUT_DIR = 'inputs/*'
  LOG = 'outputs'

  def self.execute
    Dir[INPUT_DIR].each do |file_name|
      file = File.open(file_name)
      doc = Nokogiri::XML(file)
      transactions = doc.xpath("//transaction")
      ActiveRecord::Base.transaction do
        transactions.each do |transaction|
          res = Transaction.create(
              owner_id: transaction.xpath("owner-id").text,
              account: transaction.xpath("account").text,
              processing_date: transaction.xpath("processing-date").text,
              description: transaction.xpath("description").text,
              amount: transaction.xpath("amount").text
          )
          if res
            File.open(File.join(LOG,File.basename(file_name)), 'a') { |f| f.puts res.to_xml }
          end
        end
      end
      File.delete file
    end
  end

end