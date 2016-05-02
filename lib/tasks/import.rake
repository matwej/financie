require 'import/import_transactions'

namespace :imports do
  desc 'Importuje transakcie z inputs'
  task :transactions => :environment do
    ImportTransactions.execute
  end
end