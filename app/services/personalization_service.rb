require 'open-uri'
require 'json'

# TODO: bring in higher level wrapper, httparty, etc.

module PersonalizationService
  extend self

  PATIENT_PHI_CACHE_KEY = "PHI_PERSONALIZATION_%<patient_id>d"
  PATIENT_PHI_ENDPOINT_TEMPLATE = "https://dummyjson.com/users/%<patient_id>d"

  PatientPHI = Struct.new(:name_first, :name_last) do
    def name_display
      "#{name_first} #{name_last}"
    end
  end

  def fetch!(patient_id:)
    Rails.cache.fetch(cache_key(patient_id), expires_in: 10.minutes) do
      fetch_http!(patient_id)
    end
  end

  private

  def cache_key(patient_id) = PATIENT_PHI_CACHE_KEY % { patient_id: }

  def fetch_http!(patient_id)
    uri = PATIENT_PHI_ENDPOINT_TEMPLATE % { patient_id: }
    URI.open(uri) do |input|
      raise "not a 200: #{input.status}" unless input.status[0] == "200"
      raise "not json: #{input.content_type}"  unless input.content_type == "application/json"

      json = JSON.parse(input.read)
      PatientPHI.new(json["firstName"], json["lastName"])
    end
  end

end
