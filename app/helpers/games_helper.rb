module GamesHelper
  def wanted(request, game)
    request.wanted_per_requests.find(game)
  end
end
