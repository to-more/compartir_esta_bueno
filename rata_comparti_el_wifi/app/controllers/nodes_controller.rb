class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all
    render json: @nodes
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  def get_image
    send_file Rails.root.join("public", "node.png"), type: "image/gif", disposition: "inline"
  end

  # GET /nodes/new
  def new
    @node = Node.new
    @node.build_location
    @node.routers.build
  end

  # GET /nodes/1/edit
  def edit
  end

  # GET /search_by_coordinate?coordinate[longitude]=-58.6725&coordinate[latitude]=-34.587500000000006
  def search_by_coordinate
    coordinate = params[:coordinate]
    
    @node = Node.find_by_coordinate { coordinate }

    render json: @node
  end

  # POST /nodes
  # POST /nodes.json
  def create

    @node = Node.build { params[:node] }

    respond_to do |format|
      if @node.save
        format.html { redirect_to root_path, notice: 'Node was successfully created.' }
        format.json { render action: 'show', status: :created, location: @node }
      else
        format.html { render action: 'new' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: 'Node was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit({location: [:address]}, {router: [:ip, :mac, :essid, :password, :channel, :comment]})
    end
end