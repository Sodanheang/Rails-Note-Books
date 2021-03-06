class PapersController < ApplicationController
  before_action :set_paper, only: [:edit, :update, :destroy]
  before_action :init_search

  # GET /papers
  # GET /papers.json
  def index
  end

  # GET /papers/new
  def new
    @paper = Paper.new
  end

  # GET /papers/1/edit
  def edit
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = current_user.papers.new(paper_params)
    if @paper.save
      redirect_to papers_url, notice: 'Paper was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /papers/1
  # PATCH/PUT /papers/1.json
  def update
    if current_user.id == @paper.user_id
      if @paper.update(paper_params)
        redirect_to papers_url, notice: 'Paper was successfully updated.'      
      else
        render :edit
      end
    else
      redirect_to papers_url, notice: 'Please learn doing this in right way,kid!'
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    if current_user.id == @paper.user_id
      @paper.destroy
      redirect_to papers_url, notice: 'Paper was successfully destroyed.'
    else
      redirect_to papers_url, notice: 'Please learn doing this in right way,kid!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = current_user.papers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paper_params
      params.require(:paper).permit(:title, :body, :color)
    end

    def init_search
      @q = current_user.papers.ransack(params[:q])
      @papers = @q.result(distinct: true).order(created_at: :desc)
    end
end
