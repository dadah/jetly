class JetlyUrl < ActiveRecord::Base

  validates_format_of :complete_url, with: URI::regexp(%w(http https)), message: '%{value} is invalid'
  before_save :cleanup_url
  after_create :hashify

  def increment_visits
    update_attribute :visits_count, self.visits_count + 1
  end

  private

  def hashify
    update_attribute :url_hash, self.id.to_s(32)
  end

  def cleanup_url
    self.complete_url.strip!
    self.complete_url = URI::escape(self.complete_url) if self.complete_url == URI::unescape(self.complete_url)
  end

end
