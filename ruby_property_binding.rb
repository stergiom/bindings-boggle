require 'set'

# Note: I added @valid as explcit boolean because method may return nil as
# valid value so I cannot overload @value.
class RubyPropertyBinding
  include javafx.beans.binding.Binding

  def initialize(property:, method:)
    super()
    @property, @method = property, method
    @value, @dependencies, @listeners, @valid = nil, [], Set.new, false
  end

  # Binding interface methods
  def dispose
    @value = nil
  end

  def getDependencies
    @dependencies
  end

  def invalidate
    @valid = false
  end

  def isValid
    @valid
  end
  alias valid? isValid

  # Observable/ObservableValue methods
  def addListener(listener)
    @listeners.add listener
  end

  def removeListener(listener)
    @listeners.remove listener
  end

  def getValue
    reload_value unless @valid
    @value
  end

  def reload_value
    @value = @property.__send__ @method
  end
end
