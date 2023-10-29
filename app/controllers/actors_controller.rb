class ActorsController < ApplicationController
  helper ApplicationHelper
  before_action :find_actor, only: [:edit, :update]
  protect_from_forgery with: :null_session

  def index
    @actors = Actor.all
  end

  def new
    @actor = Actor.new
  end

  def create
    @actor = Actor.new(actor_params)
    # byebug
    if @actor.save
      notify_third_parties(@actor)
      flash[:notice] = 'Actor was successfully created.'
      redirect_to actors_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @actor.update(actor_params)
      notify_third_parties(@actor)
      redirect_to actors_path, notice: 'Actor was successfully updated.'
    else
      render :edit
    end
  end

  private

  def actor_params
    params.require(:actor).permit(:name, :age, :height, :rating)
  end

  def find_actor
    @actor = Actor.find(params[:id])
  end

  def notify_third_parties(actor)
    third_party_endpoints.each do |endpoint, secret_key|
      begin
        payload = { actor: actor.as_json, secret_key: secret_key }
        response = HTTParty.post(endpoint, body: payload.to_json, headers: { 'Content-Type' => 'application/json' })
        if response.success?
          Rails.logger.info "Webhook delivered to #{endpoint} successfully"
        else
          Rails.logger.error "Webhook delivery to #{endpoint} failed"
        end
      rescue
        Rails.logger.error "Webhook not found for #{endpoint}"
      end
    end
  end

  def third_party_endpoints
    # Fetch third-party endpoints from environment variable
    count = ENV['THIRD_PARTY_ENDPOINT_COUNT'].to_i
    (1..count).map do |index|
      endpoint_key = "THIRD_PARTY_ENDPOINT_#{index}"
      secret_key_key = "THIRD_PARTY_SECRET_KEY_#{index}"
      [ENV[endpoint_key], ENV[secret_key_key]] if ENV[endpoint_key].present? && ENV[secret_key_key].present?
    end.compact.to_h
  end

end
