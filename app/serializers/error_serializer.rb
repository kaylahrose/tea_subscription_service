class ErrorSerializer
  def self.record_invalid(error)
    { 
      error: [ 
        { 
          title: error.message,
          status: "404" 
        }
      ]
    }
  end
end