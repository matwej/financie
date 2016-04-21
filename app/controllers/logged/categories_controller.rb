class Logged::CategoriesController < LoggedController
  before_action :set_category, only: [:edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    categories = Category.of(current_user).includes(:transactions)

    categories = categories.transactions_from(params.delocalize(from_filter: :date)[:from_filter]) unless params[:from_filter].blank?
    categories = categories.transactions_to(params.delocalize(to_filter: :date)[:to_filter]) unless params[:to_filter].blank?

    smart_listing_create :categories, categories, partial: "categories/list"
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.user = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Kategória vytvorená.' }
      else
        format.html { redirect_to categories_path, alert: @category.errors.full_messages.join('<br>') }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Kategória upravená.' }
      else
        format.html { redirect_to categories_path, alert: @category.errors.full_messages.join('<br>') }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Kategória vymazaná.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
