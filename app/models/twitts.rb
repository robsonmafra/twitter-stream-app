require 'open-uri'

class Twitts

  SOLR_URL = "http://app.robsonmafra.me:8983/solr/query"

  def self.search_all(search)
    search = "*:*" if search.blank?
    url = SOLR_URL + "?q=#{search}&start=0&rows=50&sort=created_at%20desc"
    response = JSON.parse(open(url).read)
    return response['response']['numFound'], response['response']['docs']
  end
end
