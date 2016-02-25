
#############################################################################################
#   RUBY methods and snippets.
#############################################################################################

class Hash
  ## Instance method for Hash objects.
  ## Returns the same object with empty (e.g., "", "  ") values changed to nil.
  ## Note: NO RETURN VALUE. Obect is modified in place, thus the "!" name.
  ## Use:   my_hash.nullify!
  def nullify!
    self.each do |key, value|
      self[key] = nil if value && value.blank?
    end
  end
end


class Time
  ## 'hms' converts seconds into HH:MM:SS or HH:MM:SS.ss format.
  ## Seconds are rounded to optional 'decimals' places, default 0 (integer).
  ## 'decimals' limited to 8 due to floating point error. Better to use 6 or fewer.
  ## Uses:
  ## Time.hms(9234.5612)    #=> "00:20:35"
  ## Time.hms(9234.5612, 2) #=> "00:20:34.56"
  def self.hms(seconds, decimals = 0)
    decs  = [decimals, 8].min
    int   = seconds.floor
    frac  = seconds - int
    hh    = (int / 3600).to_s.rjust(2, '0')
    mm    = ((int / 60) % 60).to_s.rjust(2, '0')
    secs  = int % 60
    ss    = (secs + frac).round(decimals).to_s.rjust(2, '0')
    "#{hh}:#{mm}:#{ss}"
  end
end


class Float
  ## Returns the fractional part of a float.
  ## NOTE: be wary of floating-point errors! Ruby floats are already double
  ## precision, but don't expect more than 7 or 8 correct decimal places!
  ## https://en.wikipedia.org/wiki/Floating_point#Accuracy_problems
  def frac(decimals = 8)
    int = self.floor
    (self - int).round(decimals)
  end
end


class String
  ## 'capostrophe' changes incorrect capitalization in names with apostrophes.
  ## Example:  "O'reilly" => "O'Reilly"
  ## >>>> Warning! Result:  name if it was changed, else nil. <<<<
  ## You can do it this way if you are going to use the string regardless of whether it changed:
  ##     name.capostrophe || name
  ## or you can use it conditionally:
  ##     name = old_name.capostrophe
  ##     if name ...
  ## NOTE: in order to filter out possessives, name must have 2+ letters after the apostrophe.
  def capostrophe
    match = self =~ /[A-Za-z]'[A-Za-z][\w]/
    if match
      lft = $`
      mid = $&
      rgt = $'
      m_last = mid[-1]
      mid = mid[0..-2]
      lft.upcase!
      mid.upcase!
      "#{lft}#{mid}#{m_last}#{rgt}"
    else
      nil
    end
  end
end


#############################################################################################
#   RAILS methods and snippets.
#############################################################################################

## Instance method for ActiveRecord objects.
## Returns the same object with empty (e.g., "", "  ") values changed to nil.
## Note: NO RETURN VALUE. Object is modified in place, thus the "!" name.
## Use:   my_record.nullify!
class ActiveRecord::Base
  def nullify!
    attrib = attributes
    attrib.each do |key, value|
      attrib[key] = nil if value && value.blank?
    end
    self.attributes = attrib
  end
end


