class PageController < ApplicationController

  before_action :set_film, only: %i[   ]



  # GET /films or /films.json
  def index
    @films = Film.limit(4) # Solo devuelve 4 películas
  end



 





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_film
      @film = Film.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def film_params
      params.require(:film).permit(:name, :sinopsis, :director, :imagen)
    end
end
