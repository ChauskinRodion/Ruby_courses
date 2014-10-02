class Hata_by

  def apartments(params)
    raise ArgumentError if params.invalid?

    @apartaments ||= Scraper.scrape_apartments(params)
  end
end