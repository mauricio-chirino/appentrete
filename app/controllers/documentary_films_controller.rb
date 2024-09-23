class DocumentaryFilmsController < ApplicationController
  before_action :set_documentary_film, only: %i[ show edit update destroy ]

  # GET /documentary_films or /documentary_films.json
  def index
    @documentary_films = DocumentaryFilm.all
  end

  # GET /documentary_films/1 or /documentary_films/1.json
  def show
  end

  # GET /documentary_films/new
  def new
    @documentary_film = DocumentaryFilm.new
  end

  # GET /documentary_films/1/edit
  def edit
    #validar de donde viene
    
    #@documentary_film=Documentary_film.find(params[:id])
    
  end

  # POST /documentary_films or /documentary_films.json
  def create
    @documentary_film = DocumentaryFilm.new(documentary_film_params)

    respond_to do |format|
      if @documentary_film.save
        format.html { redirect_to @documentary_film, notice: "El documental fue creado correctamente" }
        format.json { render :index, status: :created, location: @documentary_film }
      else
        # Si la base de datos no guarda el registro, se redirige a la vista de "new"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @documentary_film.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documentary_films/1 or /documentary_films/1.json
  def update
    respond_to do |format|
      if @documentary_film.update(documentary_film_params)
        format.html { redirect_to @documentary_film, notice: "Documental fue actualizado." }
        format.json { render :show, status: :ok, location: @documentary_film }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @documentary_film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documentary_films/1 or /documentary_films/1.json
  def destroy
    @documentary_film.destroy!

    respond_to do |format|
      format.html { redirect_to documentary_films_path, status: :see_other, notice: "Documentary film was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_documentary_film
      @documentary_film = DocumentaryFilm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def documentary_film_params
      params.require(:documentary_film).permit(:name, :sinopsis, :director, :imagen)
    end
end
