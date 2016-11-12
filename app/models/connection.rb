class Connection < ApplicationRecord
  include HttpClient
  include Stackoverflow
  include Linkedin
  include Github
  include Youtube

  belongs_to :developer, touch: true
  has_many :imports, dependent: :destroy

  validates_presence_of :provider
  validates_uniqueness_of :provider

  after_commit :create_or_update_imports, if: :active?

  def active?
    !expired? && access_token.present?
  end

  def owner?(user)
    user == developer
  end

  def expired?
    expiring.include?(provider) && Time.now.to_i > expires_at.to_i
  end

  def create_or_update_imports
    ImportConnectionDataWorker.perform_async(id)
  end

  def fetch_data
    send(import_methods.fetch(provider))

  rescue KeyError
    'Unknown import type'
  end

  def import_methods
    {
      'github' => 'fetch_repos',
      'stackoverflow' => 'fetch_answers',
      'linkedin' => 'fetch_positions',
      'youtube' => 'fetch_talks'
    }.freeze
  end

  def expiring
    %w(stackoverflow linkedin youtube)
  end
end
