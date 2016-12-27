class WorkersController < ApplicationController
  before_action :set_worker, only: [:show, :edit, :update, :destroy]

  # GET /workers
  # GET /workers.json
  def index
    @workers = Worker.all
  end

  def edit_salary
    @worker = Worker.last
  end

  def edit_add_to_salary
  end

  def add_to_salary
    begin
      procedure = ActiveRecord::Base.connection.raw_connection.parse(
        "BEGIN main_package.add_to_salary(:worker_id, :new_salary); END;"
      )
      procedure.bind_param(:worker_id, params[:worker_id])
      procedure.bind_param(:new_salary, params[:new_salary])
      procedure.exec()
      redirect_to workers_path
    #rescue ActiveRecord::StatementInvalid => e
    rescue Exception => e
      flash[:error] = e.message
      render :edit_add_to_salary
    end
    #redirect_to workers_path
  end

  def update_salary
    @worker = Worker.last
    procedure = ActiveRecord::Base.connection.raw_connection.parse(
    "BEGIN main_package.update_salary(:exp, :percent); END;"
    )
    #pp = params[:workers]
    procedure.bind_param(:exp, params[:exp])
    procedure.bind_param(:percent, params[:percent])
    procedure.exec()
    redirect_to workers_path
  end

  # GET /workers/1
  # GET /workers/1.json
  def show
  end

  # GET /workers/new
  def new
    @worker = Worker.new
  end

  # GET /workers/1/edit
  def edit
  end

  # POST /workers
  # POST /workers.json
  def create
    @worker = Worker.new(worker_params)

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Worker was successfully created.' }
        format.json { render :show, status: :created, location: @worker }
      else
        format.html { render :new }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workers/1
  # PATCH/PUT /workers/1.json
  def update
    begin
      respond_to do |format|
        if @worker.update(worker_params)
          format.html { redirect_to @worker, notice: 'Worker was successfully updated.' }
          format.json { render :show, status: :ok, location: @worker }
        else
          format.html { render :edit }
          format.json { render json: @worker.errors, status: :unprocessable_entity }
        end
      end
    rescue ActiveRecord::StatementInvalid => e
      flash[:error] = e.message
      render :edit
      #redirect_to worker_error_path
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, notice: 'Worker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def worker_params
      params.require(:worker).permit(:salary, :exp_month)
    end
end
