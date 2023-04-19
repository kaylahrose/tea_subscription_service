class ErrorSerializer
  def self.record_invalid(error)
    { 
      error: [ 
        { 
          title: error.message,
          status: "400" 
        }
      ]
    }
  end

  def self.record_not_found(error)
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