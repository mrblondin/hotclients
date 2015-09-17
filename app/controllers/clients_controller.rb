class ClientsController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  # выбираем клиентов для разных типов ролей
  def index
    @clients = [];
    if current_role == 'superadmin' or current_role == 'admin'
      @clients = Client.all
    elsif current_role == 'operator'
      @clients = current_user.clients
    elsif current_role == 'partner'
      cur_city_codes = []
      current_user.cities.each do |city|
        cur_city_codes.push(city.city_code)
      end
      @clients = Client.where(:city_code => cur_city_codes)
    elsif current_role == 'agent'
      cur_city_codes = []
      current_user.partner.cities.each do |city|
        if (current_user.cities.map { |c| c.city_code }.include? city.city_code)
          cur_city_codes.push(city.city_code)
        end
      end
      @clients = Client.where(:city_code => cur_city_codes)
    else
      @clients = Client.none
    end

    @clients = @clients.search(params[:search])
    @clients = @clients.operator_status(params[:operator_status]) if params[:operator_status].present?
    @clients = @clients.partner_status(params[:partner_status]) if params[:partner_status].present?
    @clients = @clients.order(sort_column + ' ' + sort_direction).page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html
      format.js
      format.xls # { send_data @clients.to_csv(col_sep: "\t") }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    @client.statement_date = Time.now
    format_snils
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Клиент успешно создан' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      format_snils
      if (@client.stage == 1 && params[:client][:stage] == '2')
        params[:client][:statement_date] = Time.now
      end

      if @client.update(client_params)
        format.html { redirect_to clients_path, notice: 'Клиент успешно обновлён' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Клиент успешно удалён' }
      format.json { head :no_content }
    end
  end

  def import
    Client.import(params[:file])
    redirect_to clients_url, notice: "Импорт клиентов успешно завершён."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  def format_snils
    params[:client][:snils] = params[:client][:snils].gsub(/[^0-9A-Za-z]/, '')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:name, :surname, :patronymic, :birth_date, :phone, :stage, :meeting_date, :operator_status, :operator_comment, :partner_status, :partner_comment, :user_id, :statement_date, :city, :region, :city_code, :snils, :address)
  end

  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
