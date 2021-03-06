class MetricsController < ApplicationController
  before_action :set_metric, only: [:show, :update, :destroy]

  # GET /metrics
  def index
    @start_date = params[:start_date] || 0
    @end_date = params[:end_date] || Time.now

    @metrics = Metric.select(:name, :value, :created_at)
      .created_between(@start_date, @end_date)

    render json: @metrics
  end

  # GET /metrics/1
  def show
    render json: @metric
  end

  # POST /metrics
  def create
    @metric = Metric.new(metric_params)

    if @metric.save
      render json: @metric, status: :created, location: @metric
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /metrics/1
  def update
    if @metric.update(metric_params)
      render json: @metric
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  # DELETE /metrics/1
  def destroy
    @metric.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric
      @metric = Metric.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def metric_params
      params.require(:metric).permit(:name, :value)
    end
end
