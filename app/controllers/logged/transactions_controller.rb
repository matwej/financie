class Logged::TransactionsController < LoggedController
  before_action :set_transaction, only: [:edit, :update, :destroy]
  before_action :set_transaction_account, only: [:edit, :update, :destroy]

  # GET /transactions/new
  def new
    set_and_auth_account params[:account_id]

    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit

  end

  # POST /transactions
  # POST /transactions.json
  def create
    set_and_auth_account params[:transaction][:owner_id]

    byebug
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to account_path(@account.id), notice: 'Transakcia úspešne vytvorená.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to account_path(@account.id), notice: 'Transakcia úspešne upravená.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Transakcia úspešne vymazaná.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      delocalize_params = {:amount => :number, :processing_date => :date}
      params.require(:transaction)
          .permit(:account, :processing_date, :description, :amount, :category_id, :owner_id)
          .delocalize(delocalize_params)
    end

    def set_and_auth_account(id)
      @account = Account.find(id)
      if @account.user != current_user
        flash[:error] = 'Nemáte oprávnenie manipulácie s týmto účtom'
        redirect_to accounts_path
      end
    end

    def set_transaction_account
      @account = @transaction.owner
      if @transaction.owner.user != current_user
        flash[:error] = 'Nemáte oprávnenie manipulácie s týmto účtom'
        redirect_to accounts_path
      end
    end
end
